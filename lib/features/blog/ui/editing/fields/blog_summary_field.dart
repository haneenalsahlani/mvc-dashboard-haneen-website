import 'package:flutter/material.dart';

class BlogSummaryField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;

  const BlogSummaryField({required this.controller, required this.focusNode});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: theme.colorScheme.outline, width: 0.2),
      ),
      padding: const EdgeInsets.all(4),
      child: TextFormField(
        controller: controller,
        focusNode: focusNode,
        decoration: InputDecoration(
          hintText: 'Brief summary of your post',
          border: InputBorder.none,
          contentPadding: const EdgeInsets.all(16),
        ),
      ),
    );
  }
}
