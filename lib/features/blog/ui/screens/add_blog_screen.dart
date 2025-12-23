import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:haneen_site__api_dashboard/core/router/route_names.dart';
import 'package:haneen_site__api_dashboard/features/blog/models/blog_model.dart';
import 'package:haneen_site__api_dashboard/features/blog/providers/blog_model_providers/editing_blog_info_provider.dart';
import 'package:haneen_site__api_dashboard/features/blog/providers/ui_providers/content_input_provider.dart';

import 'package:haneen_site__api_dashboard/features/blog/providers/use_cases/check_slug_exits.dart';

import 'package:haneen_site__api_dashboard/features/blog/ui/components/edit_text_form_field.dart';

import 'package:haneen_site__api_dashboard/features/blog/ui/pages/editing_blog_widgets/gpt_render.dart';
import 'package:haneen_site__api_dashboard/features/blog/ui/pages/editing_blog_widgets/add_blog_form.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AddBlogScreen extends HookConsumerWidget {
  const AddBlogScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final checkSlugExists = ref.watch(checkSlugExistsProvider);
    final slugController = useTextEditingController();
    final editingBlogInfo = ref.watch(editingBlogInfoProvider);

    ref.listen(checkSlugExistsProvider, (previous, next) {
      next.whenOrNull(
        data: (data) {
          if (data != null) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text("Slug is already exists")));
            ref
                .read(editingBlogInfoProvider.notifier)
                .changeBlog(
                  id: data.id.toString(),
                  newTitle: data.title,
                  newSlug: data.slug,
                  newContent: data.content,
                  newSummary: data.summary,
                );
          }
        },
        error: (error, stackTrace) {
          if (error is DioException) {
            if (error.response?.statusCode == 404) {
              ref
                  .read(editingBlogInfoProvider.notifier)
                  .changeBlog(
                    newSlug: slugController.text.replaceAll(" ", "-"),
                  );

              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text("Slug is available")));
            }
          } else {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(error.toString())));
          }
        },
        loading: () {
          debugPrint("loading");
        },
      );
    });

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              ref.read(editingBlogInfoProvider.notifier).reset();
              ref.read(checkSlugExistsProvider.notifier).reset();
              ref.read(contentInputControllerProvider.notifier).clear();
              context.go(blogsListRoute);
            },
          ),
        ],
        title: const Text("Add Blog"),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SizedBox(
            width: constraints.maxWidth,
            height: constraints.maxHeight,
            child: editingBlogInfo.slug == null
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        EditTextFormField(
                          controller: slugController,
                          labelText: "Slug",
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: checkSlugExists.isLoading
                              ? null
                              : () {
                                  final text = slugController.text.trim();
                                  if (text.isNotEmpty) {
                                    ref
                                        .read(checkSlugExistsProvider.notifier)
                                        .checkSlugExists(
                                          text.replaceAll(" ", "-"),
                                        );
                                  }
                                },
                          child: checkSlugExists.isLoading
                              ? const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(),
                                )
                              : const Text("Add Slug"),
                        ),
                      ],
                    ),
                  )
                : Row(
                    children: [
                      SizedBox(
                        width: constraints.maxWidth * 0.5,
                        height: constraints.maxHeight,
                        child: const AddBlogForm(),
                      ),
                      SizedBox(
                        width: constraints.maxWidth * 0.5,
                        height: constraints.maxHeight,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: gptRender(),
                        ),
                      ),
                    ],
                  ),
          );
        },
      ),
    );
  }
}
