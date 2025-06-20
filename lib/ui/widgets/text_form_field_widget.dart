import 'package:flutter/material.dart';

import '../../core/theme/app_sizes.dart';

class KTextFormField extends StatelessWidget {
  final String labelText;
  final Widget? prefixIcon;
  final String? Function(String?)? validator;
  final TextEditingController controller;
  const KTextFormField({
    super.key,
    required this.labelText,
    required this.controller,
    this.prefixIcon,
    this.validator,
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
        decoration: InputDecoration(
          labelText: labelText,
          prefixIcon:
              prefixIcon, // Using the textField style from AppTextStyles;
        ),
      ),
    );
  }
}
