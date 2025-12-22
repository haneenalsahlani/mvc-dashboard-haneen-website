import 'package:flutter/material.dart';
import 'package:haneen_site__api_dashboard/features/blog/ui/components/edit_text_form_field.dart';

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
      child: EditTextFormField(
        controller: controller,
        labelText: 'Brief summary of your post',
        focusNode: focusNode,
      ),
    );
  }
}
