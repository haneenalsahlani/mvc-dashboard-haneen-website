import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:haneen_site__api_dashboard/features/blog/providers/blog_model_providers/editing_blog_info_provider.dart';

import 'package:haneen_site__api_dashboard/features/blog/ui/components/edit_text_form_field.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class BlogChangeSlugButton extends HookConsumerWidget {
  const BlogChangeSlugButton();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final slugController = useTextEditingController();
    final theme = Theme.of(context);

    return IconButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            title: Row(
              children: [
                Icon(Icons.link_rounded, color: theme.colorScheme.primary),
                const SizedBox(width: 12),
                const Text("Change Slug"),
              ],
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Enter new slug for your blog post URL",
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 16),
                EditTextFormField(
                  controller: slugController,
                  labelText: "Slug (e.g., my-awesome-post)",
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Cancel"),
              ),
              FilledButton.icon(
                onPressed: () {
                  ref
                      .read(editingBlogInfoProvider.notifier)
                      .changeBlog(
                        newSlug: slugController.text.replaceAll(" ", "-"),
                      );
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.check, size: 18),
                label: const Text("Update"),
              ),
            ],
          ),
        );
      },
      icon: Icon(
        Icons.edit_rounded,
        color: theme.colorScheme.onPrimaryContainer,
      ),
      tooltip: 'Change Slug',
      style: IconButton.styleFrom(backgroundColor: theme.colorScheme.surface),
    );
  }
}
