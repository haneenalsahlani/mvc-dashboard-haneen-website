import 'package:flutter/material.dart';

class SmallAppTextFormField extends StatelessWidget {
  const SmallAppTextFormField({
    super.key,
    required this.controller,
    required this.label,
  });
  final TextEditingController controller;
  final String label;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: 150,
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(label: Text('App $label')),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter a $label';
          }
          return null;
        },
      ),
    );
  }
}
