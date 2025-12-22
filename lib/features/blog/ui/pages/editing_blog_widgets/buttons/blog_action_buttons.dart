import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:haneen_site__api_dashboard/features/blog/ui/pages/editing_blog_widgets/buttons/blog_submit_button.dart';
import 'package:haneen_site__api_dashboard/features/blog/ui/pages/editing_blog_widgets/buttons/blog_upload_image_button.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';

class BlogActionButtons extends HookConsumerWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController contentController;
  final TextEditingController summaryController;

  const BlogActionButtons({
    required this.formKey,
    required this.contentController,
    required this.summaryController,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: [
        BlogSubmitButton(
          formKey: formKey,
          contentController: contentController,
          summaryController: summaryController,
        ),
        BlogUploadImageButton(contentController: contentController),
      ],
    );
  }
}
