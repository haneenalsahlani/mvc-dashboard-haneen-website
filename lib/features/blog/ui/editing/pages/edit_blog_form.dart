import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:haneen_site__api_dashboard/features/blog/providers/blog_model_providers/editing_blog_info_provider.dart';
import 'package:haneen_site__api_dashboard/features/blog/providers/ui_providers/content_input_provider.dart';
import 'package:haneen_site__api_dashboard/features/blog/ui/editing/fields/blog_content_field.dart';
import 'package:haneen_site__api_dashboard/features/blog/ui/editing/buttons/blog_submit_button.dart';
import 'package:haneen_site__api_dashboard/features/blog/ui/editing/fields/blog_summary_field.dart';
import 'package:haneen_site__api_dashboard/features/blog/ui/editing/buttons/blog_upload_image_button.dart';
import 'package:haneen_site__api_dashboard/features/blog/ui/editing/pages/gpt_render.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class EditBlogForm extends HookConsumerWidget {
  const EditBlogForm({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    /// input related varaiblees
    final _formKey = GlobalKey<FormState>();
    final _titleController = useTextEditingController();
    final _contentController = useTextEditingController();
    final _summaryController = useTextEditingController();
    final contentFocusNode = useFocusNode();
    final summaryFocusNode = useFocusNode();

    ////////////////////////////////////////////

    /////
    //
    final _editingBlog = ref.watch(BlogInfoProvider);

    final editMode = _editingBlog.id != 0;

    ///
    ///
    ///

    if (editMode) {
      _titleController.text = _editingBlog.title ?? "";
      _contentController.text = _editingBlog.content ?? "";
      _summaryController.text = _editingBlog.summary ?? "";
    }

    return LayoutBuilder(
      builder: (context, constraints) => Form(
        key: _formKey,
        child: Row(
          children: [
            SizedBox(
              width: constraints.maxWidth * 0.5,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    spacing: 20,
                    children: [
                      Row(
                        children: [
                          Text(
                            _editingBlog.slug ?? "",
                            style: Theme.of(context).textTheme.titleMedium
                                ?.copyWith(
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                          ),
                          Spacer(),
                          Icon(
                            Icons.note_alt,
                            color: Theme.of(context).colorScheme.primary,
                            size: 20,
                          ),
                        ],
                      ),

                      BlogContentField(
                        controller: _contentController,
                        focusNode: contentFocusNode,
                        onChanged: (value) {
                          ref
                              .read(contentInputControllerProvider.notifier)
                              .addText(value);
                        },
                      ),

                      BlogSummaryField(
                        focusNode: summaryFocusNode,
                        controller: _summaryController,
                      ),

                      Row(
                        mainAxisAlignment: .spaceBetween,
                        children: [
                          BlogSubmitButton(
                            formKey: _formKey,
                            contentController: _contentController,
                            summaryController: _summaryController,
                          ),

                          BlogUploadImageButton(
                            contentController: _contentController,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),

            Expanded(child: GptRender()),
          ],
        ),
      ),
    );
  }
}
