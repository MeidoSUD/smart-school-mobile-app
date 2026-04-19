import 'package:flutter/material.dart';

class LongTextFieldWidget extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final bool obscureText;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final void Function(String)? onSubmitted;
  final VoidCallback? suffixIconPressed; // 👈 new
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final int? maxLines;
  final int? maxLength;
  final bool enabled;

  const LongTextFieldWidget({
    super.key,
    required this.label,
    required this.controller,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.onChanged,
    this.onSubmitted,
    this.suffixIconPressed,
    this.prefixIcon,
    this.suffixIcon,
    this.maxLines = 1,
    this.maxLength,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.9,
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        maxLines: maxLines,
        maxLength: maxLength,
        onChanged: onChanged,
        onFieldSubmitted: onSubmitted,
        validator: validator,
        enabled: enabled,
        
        style: const TextStyle(fontSize: 16),
      
        decoration: InputDecoration(
          
         hintStyle: theme.textTheme.labelMedium,
          prefixIcon: prefixIcon != null ? Icon(prefixIcon , color: theme.primaryColor,) : null,
          suffixIcon: suffixIcon != null ? GestureDetector(
            onTap: suffixIconPressed,
            child: Icon(suffixIcon , color: theme.primaryColor,)) : null,
          filled: true,
          fillColor: theme.cardColor,
          hintText: label,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(12),  
          ),
          enabledBorder: OutlineInputBorder(
      
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: theme.primaryColor, width: 1),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.red),
          ),
        ),
      ),
    );
  }
}
