import 'package:flutter/material.dart';

class AppDicsField extends StatelessWidget {
  const AppDicsField({super.key, required this.descriptionController});

  final TextEditingController descriptionController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: descriptionController,
      decoration: InputDecoration(
        label: Text('App describtion'),
        contentPadding: EdgeInsets.all(10),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(
            width: 0.2,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ),
      minLines: 5,
      maxLines: 10,
      maxLength: 255,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter a describtion';
        }
        return null;
      },
    );
  }
}
