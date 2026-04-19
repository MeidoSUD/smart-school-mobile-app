import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OtpInputFields extends StatefulWidget {
  final List<TextEditingController> controllers;
  final List<FocusNode> focusNodes;
  final VoidCallback onCompleted;

  const OtpInputFields({
    super.key,
    required this.controllers,
    required this.focusNodes,
    required this.onCompleted,
  });

  @override
  State<OtpInputFields> createState() => _OtpInputFieldsState();
}

class _OtpInputFieldsState extends State<OtpInputFields> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(4, (index) => _buildOtpField(index, theme)),
      ),
    );
  }

  Widget _buildOtpField(int index, ThemeData theme) {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 0, end: 1),
      duration: Duration(milliseconds: 500 + (index * 100)),
      curve: Curves.easeOutBack,
      builder: (context, double value, child) {
        return Transform.scale(
          scale: value,
          child: Container(
            width: 60, // Slightly wider for 4 fields
            height: 70, // Slightly taller
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: widget.controllers[index].text.isNotEmpty
                    ? theme.primaryColor
                    : Colors.grey.shade300,
                width: 2,
              ),
              boxShadow: widget.controllers[index].text.isNotEmpty
                  ? [
                      BoxShadow(
                        color: theme.primaryColor.withOpacity(0.3),
                        blurRadius: 10,
                        spreadRadius: 1,
                      ),
                    ]
                  : [],
            ),
            child: TextField(
              controller: widget.controllers[index],
              focusNode: widget.focusNodes[index],
              autofocus: index == 0,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              autofillHints: const [AutofillHints.oneTimeCode],
              maxLength: 1,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: theme.primaryColor,
              ),
              decoration: const InputDecoration(
                counterText: '',
                border: InputBorder.none,
              ),
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              onChanged: (value) {
                setState(() {});

                if (value.isNotEmpty && index < 3) {
                  widget.focusNodes[index + 1].requestFocus();
                } else if (value.isEmpty && index > 0) {
                  widget.focusNodes[index - 1].requestFocus();
                }

                // Auto verify when all fields are filled
                if (index == 3 && value.isNotEmpty) {
                  final otp = widget.controllers.map((c) => c.text).join();
                  if (otp.length == 4) {
                    FocusScope.of(context).unfocus();
                    Future.delayed(
                      const Duration(milliseconds: 300),
                      widget.onCompleted,
                    );
                  }
                }
              },
            ),
          ),
        );
      },
    );
  }
}
