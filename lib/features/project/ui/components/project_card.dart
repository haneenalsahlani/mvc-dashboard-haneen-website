import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:haneen_site__api_dashboard/core/router/route_names.dart';
import 'package:haneen_site__api_dashboard/core/themes/color_scheme.dart';
import 'package:haneen_site__api_dashboard/features/project/models/project_model.dart';
import 'package:haneen_site__api_dashboard/features/project/providers/model_providers/project_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ProjectCard extends ConsumerWidget {
  const ProjectCard({super.key, required this.project, required this.index});

  final ProjectModel project;
  final int index;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).colorScheme.surfaceDim),
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.surfaceContainerHighest,
            Theme.of(context).colorScheme.surfaceContainerHigh.withAlpha(100),
          ],
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 10,
        children: [
          Text(
            project.title,
            style: GoogleFonts.roboto().copyWith(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            project.description,
            style: GoogleFonts.roboto().copyWith(fontSize: 14),
          ),
          for (var feature in project.features)
            Text(feature, style: GoogleFonts.roboto().copyWith(fontSize: 14)),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                onPressed: () {
                  ref.read(ProjectProvider.notifier).setProject(project);
                  context.go(editProjectRoute);
                },
                icon: Icon(Icons.edit),
                color: Theme.of(context).colorScheme.outline,
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.delete,
                  color: Theme.of(context).colorScheme.errorContainer,
                ),
              ),

              TextButton(
                onPressed: () {
                  ref.read(ProjectProvider.notifier).setProject(project);
                  context.go(editBlogRoute);
                },
                child: Text(
                  'Add Blog',
                  style: GoogleFonts.roboto().copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppColors.successA10,
                  ),
                ),
              ),
              OutlinedButton(
                onPressed: () {
                  ref.read(ProjectProvider.notifier).setProject(project);
                  context.go(editAppRoute);
                },
                child: Text('add app'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
