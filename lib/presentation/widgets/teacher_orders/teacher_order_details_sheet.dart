import 'package:geniuses_school/presentation/widgets/teacher_orders/models/order_request_model.dart';
import 'package:flutter/material.dart';

import '../../../l10n/app_localizations.dart';

class TeacherOrderDetailsSheet extends StatelessWidget {
  final OrderRequest order;
  final VoidCallback onAccept;
  final VoidCallback onDecline;

  const TeacherOrderDetailsSheet({
    super.key,
    required this.order,
    required this.onAccept,
    required this.onDecline,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.75,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        children: [
          _buildBottomSheetHeader(context, order),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildDetailSection(AppLocalizations.of(context)!.orderInfo, [
                    _buildDetailRow(
                      Icons.book,
                      AppLocalizations.of(context)!.subject,
                      order.subject,
                    ),
                    _buildDetailRow(
                      Icons.person,
                      AppLocalizations.of(context)!.student,
                      order.studentName,
                    ),
                    _buildDetailRow(
                      Icons.calendar_today,
                      AppLocalizations.of(context)!.date,
                      order.date,
                    ),
                    _buildDetailRow(
                      Icons.school,
                      AppLocalizations.of(context)!.level,
                      order.level,
                    ),
                    _buildDetailRow(
                      order.lessonType ==
                              AppLocalizations.of(context)!.lessonTypeOnline
                          ? Icons.videocam
                          : Icons.location_on,
                      AppLocalizations.of(context)!.lessonType,
                      order.lessonType,
                    ),
                    _buildDetailRow(
                      Icons.attach_money,
                      AppLocalizations.of(context)!.price,
                      '${order.price} ${AppLocalizations.of(context)!.perHour}',
                    ),
                  ]),
                  const SizedBox(height: 24),
                  _buildDetailSection(
                    AppLocalizations.of(context)!.description,
                    [
                      Text(
                        order.description,
                        style: const TextStyle(fontSize: 16, height: 1.6),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          if (order.status == RequestStatus.pending)
            _buildBottomSheetActions(context),
        ],
      ),
    );
  }

  Widget _buildBottomSheetHeader(BuildContext context, OrderRequest order) {
    final theme = Theme.of(context);
    final statusConfig = order.status.getConfig(context);

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: theme.primaryColor.withOpacity(0.05),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        children: [
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.3),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  AppLocalizations.of(context)!.orderDetails,
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: theme.primaryColor,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: statusConfig.backgroundColor,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: statusConfig.borderColor, width: 1),
                ),
                child: Text(
                  statusConfig.label,
                  style: TextStyle(
                    color: statusConfig.textColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
              ),
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.close),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDetailSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 16),
        ...children,
      ],
    );
  }

  Widget _buildDetailRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, size: 20, color: Colors.grey[700]),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                ),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomSheetActions(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.grey.withOpacity(0.2))),
      ),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: OutlinedButton.icon(
                onPressed: () {
                  Navigator.pop(context); // Close sheet then act
                  onDecline();
                },
                icon: const Icon(Icons.close_rounded, size: 18),
                label: Text(AppLocalizations.of(context)!.reject),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.red,
                  side: const BorderSide(color: Colors.red),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.pop(context); // Close sheet then act
                  onAccept();
                },
                icon: const Icon(Icons.check_rounded, size: 18),
                label: Text(AppLocalizations.of(context)!.accept),
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.primaryColor,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
