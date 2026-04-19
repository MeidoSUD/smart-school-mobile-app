// lib/widgets/booking_card.dart

import 'package:geniuses_school/data/models/books_model.dart';
import 'package:geniuses_school/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BookingCard extends StatelessWidget {
  final BooksModel booking;
  final VoidCallback? onTap;
  final VoidCallback? onCancel;
  final VoidCallback? onReschedule;

  const BookingCard({
    super.key,
    required this.booking,
    this.onTap,
    this.onCancel,
    this.onReschedule,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    // Get the first subject or a default message
    final subject = booking.subject.isNotEmpty
        ? booking.subject
        : AppLocalizations.of(context)!.unknownSubject;

    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header: Subject and Status
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      subject,
                      style: textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.onSurface,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(width: 8),
                  _buildStatusChip(context),
                ],
              ),
              const SizedBox(height: 16),

              // Teacher Info
              Row(
                children: [
                  CircleAvatar(
                    radius: 24,
                    backgroundColor: theme.colorScheme.primary.withOpacity(0.1),
                    backgroundImage: booking.teacher.profilePhoto != null
                        ? NetworkImage(booking.teacher.profilePhoto!)
                        : null,
                    child: booking.teacher.profilePhoto == null
                        ? Icon(
                            Icons.person,
                            color: theme.colorScheme.primary,
                            size: 28,
                          )
                        : null,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${booking.teacher.firstName} ${booking.teacher.lastName}',
                          style: textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          AppLocalizations.of(context)!.teacher,
                          style: textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onSurface.withOpacity(0.6),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Date and Time
              _buildInfoRow(
                context,
                icon: Icons.calendar_today,
                label: AppLocalizations.of(context)!.dateTime,
                value: '${booking.day} ${_formatTimeTo12Hour(booking.time)}',
              ),
              const SizedBox(height: 8),

              // Lesson Type
              _buildInfoRow(
                context,
                icon: booking.type == 'single' ? Icons.person : Icons.group,
                label: AppLocalizations.of(context)!.lessonType,
                value: booking.type == 'single'
                    ? AppLocalizations.of(context)!.individualLesson
                    : AppLocalizations.of(context)!.groupLesson,
              ),
              const SizedBox(height: 8),

              // Price
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primaryContainer.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.totalPrice,
                      style: textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      '${booking.price} ${AppLocalizations.of(context)!.currency}',
                      style: textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.primary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatTimeTo12Hour(String timeString) {
    try {
      final time = DateTime.parse('1970-01-01T$timeString');
      return DateFormat.jm().format(time); // Output: 6 PM
    } catch (e) {
      return timeString;
    }
  }

  Widget _buildStatusChip(BuildContext context) {
    final theme = Theme.of(context);
    Color chipColor;
    String statusText;

    switch (booking.status.toLowerCase()) {
      case 'pending_payment':
        chipColor = Colors.orange;
        statusText = AppLocalizations.of(context)!.statusPendingPayment;
        break;
      case 'confirmed':
        chipColor = Colors.green;
        statusText = AppLocalizations.of(context)!.statusConfirmed;
        break;
      case 'completed':
        chipColor = Colors.blue;
        statusText = AppLocalizations.of(
          context,
        )!.statusCompleted; // Updated key
        break;
      case 'cancelled':
        chipColor = Colors.red;
        statusText = AppLocalizations.of(
          context,
        )!.statusCancelled; // Updated key
        break;
      default:
        chipColor = Colors.grey;
        statusText = booking.status;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: chipColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: chipColor.withOpacity(0.3)),
      ),
      child: Text(
        statusText,
        style: theme.textTheme.bodySmall?.copyWith(
          color: chipColor,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildInfoRow(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String value,
  }) {
    final theme = Theme.of(context);

    return Row(
      children: [
        Icon(icon, size: 20, color: theme.colorScheme.primary),
        const SizedBox(width: 12),
        Expanded(
          child: RichText(
            text: TextSpan(
              style: theme.textTheme.bodyMedium,
              children: [
                TextSpan(
                  text: '$label: ',
                  style: TextStyle(
                    color: theme.colorScheme.onSurface.withOpacity(0.7),
                  ),
                ),
                TextSpan(
                  text: value,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  String _formatDateTime(String dateTimeString) {
    try {
      final dateTime = DateTime.parse(dateTimeString);
      final formatter = DateFormat(
        'EEEE, d MMMM yyyy - h:mm a',
      ); // Let default locale handle it
      return formatter.format(dateTime);
    } catch (e) {
      return dateTimeString;
    }
  }
}
