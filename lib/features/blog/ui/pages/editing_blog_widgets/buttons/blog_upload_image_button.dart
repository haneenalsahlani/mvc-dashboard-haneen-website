import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:haneen_site__api_dashboard/features/blog/providers/blog_model_providers/slug_provider.dart';
import 'package:haneen_site__api_dashboard/features/blog/providers/use_cases/add_blog_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class BlogUploadImageButton extends HookConsumerWidget {
  final TextEditingController contentController;

  const BlogUploadImageButton({required this.contentController});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isUploading = useState(false);
    final theme = Theme.of(context);

    return OutlinedButton.icon(
      onPressed: isUploading.value
          ? null
          : () => _handleUpload(context, ref, isUploading),
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        side: BorderSide(
          color: theme.colorScheme.primary.withOpacity(0.5),
          width: 1.5,
        ),
      ),
      icon: isUploading.value
          ? SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: theme.colorScheme.primary,
              ),
            )
          : const Icon(Icons.image_rounded),
      label: Text(
        isUploading.value ? 'Uploading...' : 'Add Image',
        style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
      ),
    );
  }

  Future<void> _handleUpload(
    BuildContext context,
    WidgetRef ref,
    ValueNotifier<bool> isUploading,
  ) async {
    isUploading.value = true;

    try {
      final viewModel = ref.read(addBlogViewModelProvider.notifier);
      final slug = ref.read(blogSlugProvider);

      final imageUrl = await viewModel.uploadImage(slug);

      if (imageUrl != null) {
        contentController.text += "\n![image]($imageUrl)\n";

        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Row(
                children: [
                  Icon(Icons.check_circle_rounded, color: Colors.white),
                  SizedBox(width: 12),
                  Text('Image uploaded and inserted successfully'),
                ],
              ),
              backgroundColor: Colors.green.shade600,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          );
        }
      }
    } catch (error) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                const Icon(Icons.error_rounded, color: Colors.white),
                const SizedBox(width: 12),
                Expanded(child: Text('Upload failed: $error')),
              ],
            ),
            backgroundColor: Colors.red.shade600,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        );
      }
    } finally {
      isUploading.value = false;
    }
  }
}
