import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:haneen_site__api_dashboard/core/router/route_names.dart';
import 'package:haneen_site__api_dashboard/features/blog/providers/blog_model_providers/editing_blog_info_provider.dart';

import 'package:haneen_site__api_dashboard/features/blog/ui/editing/pages/edit_blog_form.dart';
import 'package:haneen_site__api_dashboard/features/blog/ui/editing/pages/listen_to_slug_validation.dart';
import 'package:haneen_site__api_dashboard/features/blog/ui/editing/pages/valadating_slug_page.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class EditBlogScreen extends HookConsumerWidget {
  const EditBlogScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    /// chicking slug availability
    final slugController = useTextEditingController();
    final slugNode = useFocusNode();
    listenToSlugValidation(context, ref, slugNode, slugController);

    ///

    final _editingBlog = ref.watch(editingBlogInfoProvider);
    final editMode = _editingBlog.id != null;

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              ref.read(editingBlogInfoProvider.notifier).reset();
              context.go(homeRoute);
            },
            icon: Icon(Icons.backspace),
          ),
        ],
        title: const Text('Edit Blog'),
      ),
      body: _editingBlog.slug == null
          ? valadatingSlugPage(
              slugController: slugController,
              slugNode: slugNode,
            )
          : EditBlogForm(),
    );
  }
}
