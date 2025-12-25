import 'package:flutter/material.dart';
import 'package:haneen_site__api_dashboard/features/project/providers/use_cases/check_project_slug_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class projectSlugCheckingPage extends ConsumerWidget {
  const projectSlugCheckingPage({super.key, required this.slugController});

  final TextEditingController slugController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: Column(
        spacing: 20,
        children: [
          TextField(
            controller: slugController,
            decoration: const InputDecoration(
              labelText: 'Project Slug',
              hintText: 'e.g. my-project-name',
              border: OutlineInputBorder(),

              prefixIcon: Icon(Icons.link),
            ),
            onSubmitted: (value) {},
          ),
          ElevatedButton(
            onPressed: () {
              if (slugController.text.isEmpty) {
                return;
              }
              ref
                  .read(checkProjectSlugExistsProvider.notifier)
                  .checkSlugExists(slugController.text);
            },
            child: Text("check if slug is available"),
          ),
        ],
      ),
    );
  }
}
