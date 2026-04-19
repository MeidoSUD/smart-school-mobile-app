import 'package:geniuses_school/presentation/widgets/common/service_radio_widget.dart';
import 'package:flutter/material.dart';

import '../../../l10n/app_localizations.dart';

class TeacherServicesSelection extends StatelessWidget {
  final List<Map<String, dynamic>> services;
  final Map<String, dynamic>? selectedService;
  final Function(Map<String, dynamic>) onServiceSelected;

  const TeacherServicesSelection({
    super.key,
    required this.services,
    this.selectedService,
    required this.onServiceSelected,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.35,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            AppLocalizations.of(context)!.educationalServices,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.primaryColor,
            ),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: ListView.separated(
              scrollDirection: Axis.vertical,
              itemCount: services.length,
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (context, index) {
                final service = services[index];
                bool isSelected =
                    selectedService != null &&
                    selectedService!['service_id'] == service['service_id'];

                return ServiceRadioWidget(
                  serviceName: service['name'],
                  isSelected: isSelected,
                  onTap: () {
                    onServiceSelected(service);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
