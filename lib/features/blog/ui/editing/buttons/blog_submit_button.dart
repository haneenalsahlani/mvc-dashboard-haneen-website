import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:haneen_site__api_dashboard/core/router/route_names.dart';
import 'package:haneen_site__api_dashboard/features/blog/models/blog_model.dart';
import 'package:haneen_site__api_dashboard/features/blog/providers/blog_model_providers/editing_blog_info_provider.dart';
import 'package:haneen_site__api_dashboard/features/blog/providers/ui_providers/content_input_provider.dart';
import 'package:haneen_site__api_dashboard/features/blog/providers/use_cases/add_blog_provider.dart';
import 'package:haneen_site__api_dashboard/features/blog/providers/use_cases/check_slug_exits.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class BlogSubmitButton extends ConsumerWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController contentController;
  final TextEditingController summaryController;

  const BlogSubmitButton({
    required this.formKey,
    required this.contentController,
    required this.summaryController,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String buttonLabel = 'Publishing...';
    String buttonProgressLabel = 'Publish Post';

    final state = ref.read(addBlogViewModelProvider);
    final _editingBlog = ref.read(editingBlogInfoProvider);
    bool editMode = _editingBlog.id != 0;

    if (editMode) {
      buttonProgressLabel = 'updating';
      buttonLabel = 'update';
    }

    return FilledButton.icon(
      onPressed: state.isLoading
          ? null
          : () => _handleSubmit(context, ref, editMode, _editingBlog),
      style: FilledButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 2,
      ),
      icon: state.isLoading
          ? const SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: Colors.white,
              ),
            )
          : const Icon(Icons.publish_rounded),
      label: Text(
        state.isLoading ? buttonProgressLabel : buttonLabel,
        style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
      ),
    );
  }

  Future<void> _handleSubmit(
    BuildContext context,
    WidgetRef ref,
    bool editMode,

    BlogModel _editingBlog,
  ) async {
    if (!formKey.currentState!.validate()) return;

    final viewModel = ref.read(addBlogViewModelProvider.notifier);

    final result = editMode
        ? await viewModel.updateBlog(
            BlogModel(
              id: _editingBlog.id,
              title: _editingBlog.title,
              content: contentController.text,
              summary: summaryController.text,
            ),
          )
        : await viewModel.submitBlog(
            BlogModel(
              title: _editingBlog.slug!.replaceAll("-", " "),
              content: contentController.text,
              summary: summaryController.text,
            ),
          );

    if (result != null && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const Icon(Icons.check_circle_rounded, color: Colors.white),
              const SizedBox(width: 12),
              Text('Blog published successfully! ID: $result'),
            ],
          ),
          backgroundColor: Colors.green.shade600,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          duration: const Duration(seconds: 3),
        ),
      );

      ref.read(editingBlogInfoProvider.notifier).reset();
      ref.read(checkSlugExistsProvider.notifier).reset();
      ref.read(contentInputControllerProvider.notifier).clear();
      context.go(blogsListRoute);
    }
  }
}
