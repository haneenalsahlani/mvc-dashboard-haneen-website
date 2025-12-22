import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:haneen_site__api_dashboard/core/router/route_names.dart';
import 'package:haneen_site__api_dashboard/features/blog/providers/blog_model_providers/slug_provider.dart';

import 'package:haneen_site__api_dashboard/features/blog/ui/components/edit_text_form_field.dart';

import 'package:haneen_site__api_dashboard/features/blog/ui/pages/editing_blog_widgets/gpt_render.dart';
import 'package:haneen_site__api_dashboard/features/blog/ui/pages/editing_blog_widgets/add_blog_form.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AddBlogScreen extends HookConsumerWidget {
  const AddBlogScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _slug = ref.watch(blogSlugProvider);

    TextEditingController sludC = useTextEditingController();
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.backspace),
            onPressed: () {
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
            child: _slug.isEmpty
                ? Center(
                    child: Column(
                      children: [
                        Spacer(),
                        EditTextFormField(controller: sludC, labelText: "slug"),
                        TextButton(
                          onPressed: () {
                            if (sludC.text.isNotEmpty) {
                              ref
                                  .read(blogSlugProvider.notifier)
                                  .addValue(sludC.text.replaceAll(" ", "-"));
                            }
                          },
                          child: Text("add slug please "),
                        ),
                        Spacer(),
                      ],
                    ),
                  )
                : Row(
                    children: [
                      SizedBox(
                        width: constraints.maxWidth * 0.5,
                        height: constraints.maxHeight,
                        child: AddBlogForm(),
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
