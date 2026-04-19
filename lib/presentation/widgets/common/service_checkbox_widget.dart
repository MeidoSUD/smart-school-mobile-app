
import 'package:flutter/material.dart';

class ServiceCheckboxWidget extends StatelessWidget {
  final String serviceName;
  final bool isChecked;
  final ValueChanged<bool?>? onChanged;
  const ServiceCheckboxWidget({super.key,
  required this.serviceName,
  required this.onChanged,
  this.isChecked = false
  
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: CheckboxListTile(
           activeColor: Theme.of(context).primaryColor,
           checkColor: Colors.white,
          title:  Text(serviceName),
          value: isChecked,
           controlAffinity: ListTileControlAffinity.leading,
          onChanged: onChanged,
        ),
      ),
    );
  }
}