import 'package:geniuses_school/app_keys.dart';
import 'package:geniuses_school/data/models/books_model.dart';
import 'package:geniuses_school/data/models/payment_request.dart';
import 'package:geniuses_school/l10n/app_localizations.dart';
import 'package:geniuses_school/presentation/state/booking_provider.dart';
import 'package:geniuses_school/presentation/state/moyasar_provider.dart';
import 'package:geniuses_school/presentation/widgets/booking/booking_widget.dart';
import 'package:geniuses_school/presentation/widgets/common/ballsWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../payment/payment_webview_screen.dart';
import 'booking_preview_screen.dart';

class BookingsScreen extends ConsumerStatefulWidget {
  const BookingsScreen({super.key});

  @override
  ConsumerState<BookingsScreen> createState() => _BookingsScreenState();
}

class _BookingsScreenState extends ConsumerState<BookingsScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final loc = AppLocalizations.of(context)!;

    ref.listen<MoyasarState>(moyasarProvider, (previous, next) {
      if (next.status == MoyasarStatus.paymentCreated) {
        if (mounted) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => PaymentWebViewScreen(
                amount: 0.0, // Amount should be retrieved from the booking
                currency: 'SAR',
                checkoutId: next.paymentId!,
                redirectUrl: next.redirectUrl!,
                onPaymentComplete: (status) {
                  ref.read(moyasarProvider.notifier).reset();
                  ref.refresh(booksProvider);
                  scaffoldMessengerKey.currentState?.showSnackBar(
                    SnackBar(
                      content: Text(loc.paymentSuccess),
                      backgroundColor: Colors.green,
                    ),
                  );
                },
                onPaymentFailed: (error) {
                  ref.read(moyasarProvider.notifier).reset();
                  if (error == 'user_cancelled') {
                    scaffoldMessengerKey.currentState?.showSnackBar(
                      SnackBar(
                        content: Text('⚠️ ${loc.paymentCancelled}'),
                        backgroundColor: Colors.orange,
                      ),
                    );
                  } else {
                    scaffoldMessengerKey.currentState?.showSnackBar(
                      SnackBar(
                        content: Text('❌ فشل الدفع: $error'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
              ),
            ),
          );
        }
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.bookings),
        backgroundColor: theme.primaryColor,
        foregroundColor: Colors.white,
      ),
      body: Stack(
        children: [
          BallsWidget(
            size: 40,
            color: const Color(0xFF5170ff),
            alignment: const Alignment(1.1, -0.8),
            opacity: 0.9,
          ),
          BallsWidget(
            size: 100,
            color: theme.primaryColorLight,
            alignment: const Alignment(-1.4, -0.8),
            opacity: 0.9,
          ),
          BallsWidget(
            size: 100,
            color: const Color(0xFF5170ff),
            alignment: const Alignment(-1.3, 1),
            opacity: 0.9,
          ),

          Consumer(
            builder: (context, ref, _) {
              final bookingsAsync = ref.watch(booksProvider);
              final booksNotifier = ref.read(booksProvider.notifier);

              return RefreshIndicator(
                onRefresh: () async {
                  await booksNotifier.refreshBookings();
                },
                child: bookingsAsync.when(
                  data: (booksState) {
                    if (booksState.bookings.isEmpty) {
                      return Center(
                        child: Text(AppLocalizations.of(context)!.noBookings),
                      );
                    }
                    return NotificationListener<ScrollNotification>(
                      onNotification: (ScrollNotification scrollInfo) {
                        if (!booksState.isLoadingMore &&
                            booksState.pagination.hasMore &&
                            scrollInfo.metrics.pixels ==
                                scrollInfo.metrics.maxScrollExtent) {
                          booksNotifier.loadMore();
                        }
                        return false;
                      },
                      child: ListView.builder(
                        itemCount:
                            booksState.bookings.length +
                            (booksState.pagination.hasMore ? 1 : 0),
                        itemBuilder: (context, index) {
                          if (index == booksState.bookings.length) {
                            return const Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Center(child: CircularProgressIndicator()),
                            );
                          }
                          final booking = booksState.bookings[index];
                          return BookingCard(
                            booking: booking,
                            onCancel: () =>
                                _handleCancelBooking(context, ref, booking.id),
                            onReschedule: () {
                              // Handle reschedule action
                            },
                            onTap: () => _showBookingPreview(booking),
                          );
                        },
                      ),
                    );
                  },
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  error: (error, stack) => Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${AppLocalizations.of(context)!.errorPrefix}$error',
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {
                            booksNotifier.refreshBookings();
                          },
                          child: Text(AppLocalizations.of(context)!.retry),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  String _formatTimeTo12Hour(String timeString) {
    try {
      final time = DateTime.parse('1970-01-01T$timeString');
      return DateFormat.jm().format(time);
    } catch (e) {
      return timeString;
    }
  }

  Future<void> _handleCancelBooking(
    BuildContext context,
    WidgetRef ref,
    int bookingId,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(AppLocalizations.of(context)!.cancelBooking),
        content: Text(AppLocalizations.of(context)!.confirmCancelBooking),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: Text(AppLocalizations.of(context)!.cancel),
          ),
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: Text(
              AppLocalizations.of(context)!.confirm,
              style: const TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );

    if (confirmed == true && mounted) {
      final booksNotifier = ref.read(booksProvider.notifier);
      final success = await booksNotifier.cancelBooking(bookingId);

      if (mounted) {
        scaffoldMessengerKey.currentState?.showSnackBar(
          SnackBar(
            content: Text(
              success
                  ? AppLocalizations.of(context)!.bookingCancelledSuccess
                  : AppLocalizations.of(context)!.bookingCancellationFailed,
            ),
            backgroundColor: success ? Colors.green : Colors.red,
            duration: const Duration(seconds: 3),
            behavior: SnackBarBehavior.floating,
            margin: const EdgeInsets.all(16),
          ),
        );
      }
    }
  }

  void _showBookingPreview(BooksModel booking) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (paymentContext) => BookingPreviewScreen(
          bookingDetails: {
            'lessonType': booking.type,
            'level': booking.subject,
            'className': booking.subject,
            'subject': booking.subject,
            'day': booking.day,
            'time': _formatTimeTo12Hour(booking.time),
          },
          price: booking.price,
          teacherName:
              "${booking.teacher.firstName} ${booking.teacher.lastName}",
          teacherImage: booking.teacher.profilePhoto,
          onConfirm: (savedCardId, brand, totalSessions) async {
            if (booking.status.toLowerCase() != 'pending_payment') {
              // If already paid or confirmed, just close or show info
              Navigator.of(context).pop();
              return;
            }

            final amount = double.tryParse(booking.price) ?? 0.0;
            if (amount <= 0) return;

            // Trigger Moyasar payment for this booking
            ref
                .read(moyasarProvider.notifier)
                .initPayment(
                  PaymentRequest(
                    amount: amount,
                    currency: 'SAR',
                    merchantTransactionId: 'booking_${booking.id}',
                    savedCardId: savedCardId,
                    paymentBrand: brand,
                  ),
                );
          },
          onCancel: () {
            Navigator.of(context).pop();
          },
        ),
      ),
    );
  }
}
