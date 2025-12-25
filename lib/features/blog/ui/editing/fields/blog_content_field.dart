import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:haneen_site__api_dashboard/core/themes/edit_text_field_theme.dart';

class BlogContentField extends HookWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final ValueChanged<String>? onChanged;

  const BlogContentField({
    required this.controller,
    required this.focusNode,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final charCount = useState(0);
    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: theme.colorScheme.outline.withOpacity(0.2),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.shadow.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Row(
              children: [
                Icon(
                  Icons.edit_note_rounded,
                  color: theme.colorScheme.primary,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  'Content',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: theme.colorScheme.primary,
                  ),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    '${charCount.value} characters',
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: theme.colorScheme.onPrimaryContainer,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
          TextFormField(
            controller: controller,
            focusNode: focusNode,
            style: KeditTextFieldTheme,
            minLines: 20,
            maxLines: 35,
            onChanged: (value) {
              charCount.value = value.length;
              onChanged?.call(value);
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter content';
              }
              return null;
            },
            decoration: InputDecoration(
              hintText:
                  'Write your blog content here... Supports markdown formatting.',
              border: InputBorder.none,
              contentPadding: const EdgeInsets.all(16),
              hintStyle: TextStyle(
                color: theme.colorScheme.onSurface.withOpacity(0.4),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
