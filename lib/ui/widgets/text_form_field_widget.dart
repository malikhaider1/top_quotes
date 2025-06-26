import 'package:flutter/material.dart';

import '../../core/theme/app_sizes.dart';

class KTextFormField extends StatelessWidget {
  final String labelText;
  final Widget? prefixIcon;
  final String? Function(String?)? validator;
  final String? Function(String?)? onChanged;
  final String? Function(String?)? onFieldSubmitted;
  final TextEditingController controller;
  const KTextFormField({
    super.key,
    required this.labelText,
    required this.controller,
    this.prefixIcon,
    this.validator,
    this.onChanged,
    this.onFieldSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 2.0,
      borderRadius: radius24,
      child: TextFormField(
        controller: controller,
        validator: validator,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        onChanged: onChanged,
        onFieldSubmitted: onFieldSubmitted,
        decoration: InputDecoration(
          labelText: labelText,
          prefixIcon:
              prefixIcon, // Using the textField style from AppTextStyles;
        ),
      ),
    );
  }
}
