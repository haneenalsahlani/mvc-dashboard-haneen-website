import 'package:flutter/material.dart';
import 'package:haneen_site__api_dashboard/features/project/providers/use_cases/list_project_provider.dart';

import 'package:haneen_site__api_dashboard/features/project/ui/components/project_card.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ListProjectScreen extends ConsumerWidget {
  const ListProjectScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedProject = ref.watch(listProjectNotifierProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('List Project')),
      body: Center(
        child: selectedProject.when(
          data: (data) {
            if (data == null || data.isEmpty) {
              return const Text('No projects found');
            }
            return Wrap(
              children: List.generate(
                data.length,
                (index) => SizedBox(
                  width: 250,
                  child: ProjectCard(project: data[index], index: index),
                ),
              ),
            );
          },
          error: (error, stackTrace) {
            return Text(error.toString());
          },
          loading: () {
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
