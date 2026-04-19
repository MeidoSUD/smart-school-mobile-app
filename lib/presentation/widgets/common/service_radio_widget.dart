import 'package:flutter/material.dart';

class ServiceRadioWidget extends StatelessWidget {
  final String serviceName;
  final bool isSelected;
  final VoidCallback onTap;

  const ServiceRadioWidget({
    super.key,
    required this.serviceName,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: RadioListTile<bool>(
          activeColor: Theme.of(context).primaryColor,
          title: Text(serviceName),
          value: true,
          groupValue: isSelected ? true : null,
          toggleable: true,
          onChanged: (val) {
            onTap();
          },
          controlAffinity: ListTileControlAffinity.leading,
        ),
      ),
    );
  }
}
