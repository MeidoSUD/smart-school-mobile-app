import 'package:geniuses_school/l10n/app_localizations.dart';
import 'package:geniuses_school/presentation/state/booking_provider.dart';
import 'package:geniuses_school/presentation/state/payments_cards_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:showcaseview/showcaseview.dart';

class BookingPreviewScreen extends ConsumerStatefulWidget {
  final Map<String, dynamic> bookingDetails;
  final String price;
  final String teacherName;
  final String? teacherImage;
  final Function(int? savedCardId, String? brand, int totalSessions) onConfirm;
  final VoidCallback onCancel;

  const BookingPreviewScreen({
    super.key,
    required this.bookingDetails,
    required this.price,
    required this.teacherName,
    this.teacherImage,
    required this.onConfirm,
    required this.onCancel,
  });

  @override
  ConsumerState<BookingPreviewScreen> createState() =>
      _BookingPreviewScreenState();
}

class _BookingPreviewScreenState extends ConsumerState<BookingPreviewScreen> {
  int? selectedSavedCardId;
  String _selectedNewCardBrand = 'VISA'; // Default for new card selection
  int selectedSessions = 1;
  final GlobalKey _sessionsKey = GlobalKey();
  bool _showcaseStarted = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final loc = AppLocalizations.of(context)!;
    final cardsAsync = ref.watch(paymentCardProvider);

    String displayLessonType = widget.bookingDetails['lessonType'] ?? '-';
    if (widget.bookingDetails['lessonType'] == 'single') {
      displayLessonType = loc.typeSingle;
    } else if (widget.bookingDetails['lessonType'] == 'group') {
      displayLessonType = loc.typeGroup;
    }

    return ShowCaseWidget(
      builder: (innerContext) {
        if (!_showcaseStarted) {
          _showcaseStarted = true;
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted) {
              // Ignore lint warnings about BuildContext passing asynchronously because innerContext is fully mounted via ShowCaseWidget
              ShowCaseWidget.of(innerContext).startShowCase([_sessionsKey]);
            }
          });
        }

        return Scaffold(
          backgroundColor: Colors.grey.shade50,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_rounded),
              onPressed: widget.onCancel,
              color: theme.primaryColor,
            ),
            title: Text(
              loc.confirmYourBooking,
              style: const TextStyle(
                color: Color(0xFF1E293B),
                fontWeight: FontWeight.bold,
              ),
            ),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Teacher Card
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      widget.teacherImage != null
                          ? Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                image: DecorationImage(
                                  image: NetworkImage(widget.teacherImage!),
                                  fit: BoxFit.cover,
                                ),
                                border: Border.all(
                                  color: theme.primaryColor.withOpacity(0.2),
                                  width: 2,
                                ),
                              ),
                            )
                          : Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                color: theme.primaryColor.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Icon(
                                Icons.person,
                                size: 40,
                                color: theme.primaryColor,
                              ),
                            ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              loc.yourTeacher,
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey.shade600,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              widget.teacherName,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF1E293B),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                Text(
                  loc.bookingDetails,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade800,
                  ),
                ),

                const SizedBox(height: 12),

                _buildDetailCard(
                  icon: Icons.person_outline,
                  label: loc.lessonType,
                  value: displayLessonType,
                  theme: theme,
                ),

                const SizedBox(height: 12),
                _buildDetailCard(
                  icon: Icons.menu_book_rounded,
                  label: loc.subject,
                  value: widget.bookingDetails['subject'] ?? '-',
                  theme: theme,
                ),
                const SizedBox(height: 12),
                _buildDetailCard(
                  icon: Icons.calendar_today_rounded,
                  label: loc.date,
                  value: widget.bookingDetails['day'] ?? '-',
                  theme: theme,
                ),
                const SizedBox(height: 12),
                _buildDetailCard(
                  icon: Icons.access_time_rounded,
                  label: loc.time,
                  value: widget.bookingDetails['time'] ?? '-',
                  theme: theme,
                ),

                const SizedBox(height: 24),

                Text(
                  loc.managePaymentMethods,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade800,
                  ),
                ),
                const SizedBox(height: 12),
                cardsAsync.when(
                  data: (cards) {
                    if (cards.isEmpty) {
                      return const SizedBox.shrink();
                    }

                    return Column(
                      children: [
                        ...cards.map(
                          (card) => RadioListTile<int?>(
                            value: card.id,
                            groupValue: selectedSavedCardId,
                            onChanged: (value) {
                              setState(() {
                                selectedSavedCardId = value;
                              });
                            },
                            title: Text(card.cardholderName ?? ''),
                            subtitle: Text(card.maskedCardNumber),
                            secondary: Icon(
                              card.cardType == 'visa'
                                  ? Icons.credit_card
                                  : Icons.credit_card_outlined,
                              color: theme.primaryColor,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                              side: BorderSide(
                                color: selectedSavedCardId == card.id
                                    ? theme.primaryColor
                                    : Colors.grey.shade200,
                                width: selectedSavedCardId == card.id ? 2 : 1,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        RadioListTile<int?>(
                          value: null,
                          groupValue: selectedSavedCardId,
                          onChanged: (value) {
                            setState(() {
                              selectedSavedCardId = value;
                            });
                          },
                          title: Text(loc.newPaymentCard),
                          subtitle: Text(loc.useAnotherCard),
                          secondary: const Icon(Icons.add_card),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                            side: BorderSide(
                              color: selectedSavedCardId == null
                                  ? theme.primaryColor
                                  : Colors.grey.shade200,
                              width: selectedSavedCardId == null ? 2 : 1,
                            ),
                          ),
                        ),
                        if (selectedSavedCardId == null)
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 32,
                              right: 32,
                              bottom: 8,
                            ),
                            child: Column(
                              children: [
                                RadioListTile<String>(
                                  title: Text(loc.creditCardVisaMaster),
                                  value: 'VISA',
                                  groupValue: _selectedNewCardBrand,
                                  onChanged: (val) {
                                    if (val != null)
                                      setState(
                                        () => _selectedNewCardBrand = val,
                                      );
                                  },
                                  contentPadding: EdgeInsets.zero,
                                  dense: true,
                                ),
                                RadioListTile<String>(
                                  title: Text(loc.mada),
                                  value: 'MADA',
                                  groupValue: _selectedNewCardBrand,
                                  onChanged: (val) {
                                    if (val != null)
                                      setState(
                                        () => _selectedNewCardBrand = val,
                                      );
                                  },
                                  contentPadding: EdgeInsets.zero,
                                  dense: true,
                                ),
                              ],
                            ),
                          ),
                      ],
                    );
                  },
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  error: (e, _) => Text(loc.cardsLoadError(e.toString())),
                ),

                const SizedBox(height: 24),

                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.green.shade50, Colors.green.shade100],
                    ),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.green.shade200, width: 2),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        loc.priceSummary,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.green.shade700,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            loc.totalSessions,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.green.shade700,
                            ),
                          ),
                          Row(
                            children: [
                              _buildCounterButton(
                                icon: Icons.remove,
                                onPressed: selectedSessions > 1
                                    ? () => setState(() => selectedSessions--)
                                    : null,
                              ),
                              Container(
                                width: 50,
                                alignment: Alignment.center,
                                child: Text(
                                  '$selectedSessions',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green.shade700,
                                  ),
                                ),
                              ),
                              _buildCounterButton(
                                icon: Icons.add,
                                onPressed: () =>
                                    setState(() => selectedSessions++),
                              ),
                            ],
                          ),
                        ],
                      ),
                      if (selectedSessions > 1) ...[
                        const SizedBox(height: 8),
                        Text(
                          loc.session_timing_info,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.green.shade600,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            loc.hourlyRate,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.green.shade700,
                            ),
                          ),
                          Text(
                            '${widget.price} ${loc.sar}',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.green.shade700,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      const Divider(color: Colors.green),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            loc.total,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.green.shade700,
                            ),
                          ),
                          Text(
                            '${(double.parse(widget.price) * selectedSessions).toStringAsFixed(0)} ${loc.sar}',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.green.shade700,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // Info Message
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.blue.shade200),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.info_rounded,
                        color: Colors.blue.shade700,
                        size: 20,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          loc.cancellationPolicy,
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.blue.shade700,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 32),
              ],
            ),
          ),
          bottomNavigationBar: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: widget.onCancel,
                    style: OutlinedButton.styleFrom(
                      foregroundColor: theme.primaryColor,
                      side: BorderSide(color: theme.primaryColor),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      loc.cancel,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  flex: 2,
                  child: ElevatedButton(
                    onPressed: () {
                      String? selectedBrand;
                      if (selectedSavedCardId != null) {
                        final cards = cardsAsync.asData?.value ?? [];
                        final selectedCard = cards.firstWhere(
                          (c) => c.id == selectedSavedCardId,
                        );
                        // Map cardType to Moyasar brand format (VISA, MASTER, MADA)
                        // Assuming card.cardType comes as 'visa', 'master', etc.
                        final type = selectedCard.cardType.toUpperCase();
                        if (type.contains('VISA')) {
                          selectedBrand = 'VISA';
                        } else if (type.contains('MASTER')) {
                          selectedBrand = 'MASTER';
                        } else if (type.contains('MADA')) {
                          selectedBrand = 'MADA';
                        } else {
                          selectedBrand = 'VISA'; // Default fallback
                        }
                      } else {
                        // New Card Case
                        selectedBrand = _selectedNewCardBrand;
                      }

                      widget.onConfirm(
                        selectedSavedCardId,
                        selectedBrand,
                        selectedSessions,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: theme.primaryColor,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Consumer(
                      builder: (context, ref, _) {
                        final bookState = ref.watch(bookingProvider);

                        if (bookState.isLoading) {
                          return const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          );
                        }

                        return Text(
                          loc.proceedToPayment,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildDetailCard({
    required IconData icon,
    required String label,
    required String value,
    required ThemeData theme,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: theme.primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: theme.primaryColor, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade600,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1E293B),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCounterButton({
    required IconData icon,
    required VoidCallback? onPressed,
  }) {
    final bool isDisabled = onPressed == null;
    return GestureDetector(
      onTap: onPressed,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: isDisabled ? Colors.grey.shade200 : Colors.green.shade600,
          shape: BoxShape.circle,
          boxShadow: [
            if (!isDisabled)
              BoxShadow(
                color: Colors.green.shade200,
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
          ],
        ),
        child: Icon(
          icon,
          color: isDisabled ? Colors.grey.shade400 : Colors.white,
          size: 20,
        ),
      ),
    );
  }
}
