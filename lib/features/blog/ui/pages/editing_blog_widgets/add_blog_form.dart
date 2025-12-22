import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:haneen_site__api_dashboard/features/blog/providers/blog_model_providers/editing_blog_info_provider.dart';
import 'package:haneen_site__api_dashboard/features/blog/providers/ui_providers/content_input_provider.dart';

import 'package:haneen_site__api_dashboard/features/blog/providers/blog_model_providers/slug_provider.dart';
import 'package:haneen_site__api_dashboard/features/blog/ui/pages/editing_blog_widgets/buttons/blog_action_buttons.dart';
import 'package:haneen_site__api_dashboard/features/blog/ui/pages/editing_blog_widgets/fields/blog_content_field.dart';
import 'package:haneen_site__api_dashboard/features/blog/ui/pages/editing_blog_widgets/blog_header_section.dart';
import 'package:haneen_site__api_dashboard/features/blog/ui/pages/editing_blog_widgets/fields/blog_summary_field.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AddBlogForm extends HookConsumerWidget {
  const AddBlogForm({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final contentController = useTextEditingController();
    final summaryController = useTextEditingController();
    final formKey = useMemoized(() => GlobalKey<FormState>());
    final contentFocusNode = useFocusNode();
    final summaryFocusNode = useFocusNode();

    final title = ref.read(blogSlugProvider);

    final _blog = ref.watch(editingBlogInfoProvider);

    _blog.content.isEmpty ? null : contentController.text = _blog.content;
    _blog.summary.isEmpty ? null : summaryController.text = _blog.summary;

    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Form(
      key: formKey,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [colorScheme.surface, colorScheme.surface],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            spacing: 10,
            children: [
              // Header Section
              BlogHeaderSection(title: title),

              // Content Field with Character Counter
              BlogContentField(
                controller: contentController,
                focusNode: contentFocusNode,
                onChanged: (value) {
                  ref
                      .read(contentInputControllerProvider.notifier)
                      .addText(value);
                },
              ),

              // Summary Field
              BlogSummaryField(
                controller: summaryController,
                focusNode: summaryFocusNode,
              ),

              // Action Buttons
              BlogActionButtons(
                formKey: formKey,
                contentController: contentController,
                summaryController: summaryController,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
