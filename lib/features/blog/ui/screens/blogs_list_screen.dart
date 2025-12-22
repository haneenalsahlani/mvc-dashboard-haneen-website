import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:haneen_site__api_dashboard/core/router/route_names.dart';
import 'package:haneen_site__api_dashboard/features/blog/providers/ui_providers/content_input_provider.dart';
import 'package:haneen_site__api_dashboard/features/blog/providers/blog_model_providers/editing_blog_info_provider.dart';
import 'package:haneen_site__api_dashboard/features/blog/providers/blog_model_providers/slug_provider.dart';
import 'package:haneen_site__api_dashboard/features/blog/providers/use_cases/delete_blog_provier.dart';
import 'package:haneen_site__api_dashboard/features/blog/providers/use_cases/list_blog_provider.dart';

class BlogsListScreen extends ConsumerWidget {
  const BlogsListScreen({Key? key}) : super(key: key);

  Future<void> _deleteBlog(
    BuildContext context,
    WidgetRef ref,
    int blogId,
  ) async {
    // Show confirmation dialog
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Blog'),
        content: const Text('Are you sure you want to delete this blog?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirmed != true) return;

    // Trigger the delete provider
    final result = ref.watch(deleteBlogProvider(blogId));
    result.when(
      data: (data) {
        if (data != null && data.success == true) {
          if (context.mounted) {
            // Show success message
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Blog deleted successfully')),
            );

            // Refresh the blog list
          }
        }
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stackTrace) => ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error deleting blog $error'))),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listBlog = ref.watch(listBlogProvider);
    ref.refresh(listBlogProvider);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ref.read(blogSlugProvider.notifier).addValue("");
          ref
              .read(editingBlogInfoProvider.notifier)
              .changeBlog("0", '', "", "", "");
          context.go(addBlogRoute);
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: const Text('Blogs List'),
        actions: [
          IconButton(
            onPressed: () {
              context.go(homeRoute);
            },
            icon: const Icon(Icons.backspace),
          ),
        ],
      ),
      body: listBlog.when(
        data: (data) => data == null
            ? const Center(child: Text("No blogs found"))
            : ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  final blog = data[index];
                  return Card(
                    child: ListTile(
                      onTap: () {
                        ref
                            .read(editingBlogInfoProvider.notifier)
                            .changeBlog(
                              blog.id.toString(),
                              blog.title,
                              blog.summary,
                              blog.content,
                              blog.slug,
                            );
                        ref
                            .read(contentInputControllerProvider.notifier)
                            .addText(blog.content);
                        ref
                            .read(blogSlugProvider.notifier)
                            .addValue(blog.slug ?? "new slugggy");
                        context.go(addBlogRoute);
                      },
                      title: Text(blog.title),
                      subtitle: Text(blog.summary),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: blog.id != null
                            ? () => _deleteBlog(context, ref, blog.id!)
                            : null,
                      ),
                    ),
                  );
                },
              ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(child: Text(error.toString())),
      ),
    );
  }
}
