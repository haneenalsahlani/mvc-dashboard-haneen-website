import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:haneen_site__api_dashboard/features/blog/providers/blog_model_providers/editing_blog_info_provider.dart';
import 'package:haneen_site__api_dashboard/features/blog/providers/use_cases/check_slug_exits.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void listenToSlugValidation(
  BuildContext context,
  WidgetRef ref,
  FocusNode slugNode,
  TextEditingController slugController,
) {
  ref.listen(checkSlugExistsProvider, (previous, next) {
    next.when(
      error: (error, stackTrace) {
        if (error is DioException) {
          if (error.response?.statusCode == 404) {
            ref
                .read(editingBlogInfoProvider.notifier)
                .changeBlog(newSlug: slugController.text.replaceAll(" ", "-"));
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text('Slug is  available')));
          }
        }
      },
      loading: () {},
      data: (value) {
        debugPrint(value.toString());
        if (value != null) {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text(
                  'do you want to edit this blog? or start another one?',
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      ref.invalidate(checkSlugExistsProvider);
                      Navigator.pop(context);
                      ref
                          .read(editingBlogInfoProvider.notifier)
                          .changeBlog(
                            id: value.id.toString(),
                            newSlug: value.slug,
                            newTitle: value.title,
                            newContent: value.content,
                            newSummary: value.summary,
                          );
                    },
                    child: Text('edit'),
                  ),
                  TextButton(
                    onPressed: () {
                      ref.invalidate(checkSlugExistsProvider);
                      slugNode.requestFocus();
                      Navigator.pop(context);
                    },
                    child: Text('new one'),
                  ),
                ],
              );
            },
          );
        }
      },
    );
  });
}
