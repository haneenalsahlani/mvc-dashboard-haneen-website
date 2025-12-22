import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:haneen_site__api_dashboard/core/theme/edit_text_field_theme.dart';

class EditTextFormField extends StatelessWidget {
  const EditTextFormField({
    super.key,
    required this.controller,
    required this.labelText,
    this.focusNode,
  });

  final TextEditingController controller;
  final String labelText;
  final FocusNode? focusNode;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: KeditTextFieldTheme,
      controller: controller,
      focusNode: focusNode,
      decoration: InputDecoration(labelText: labelText),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter a $labelText';
        }
        return null;
      },
    );
  }
}
