import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:haneen_site__api_dashboard/core/router/route_names.dart';
import 'package:haneen_site__api_dashboard/features/project/providers/use_cases/check_project_slug_provider.dart';
import 'package:haneen_site__api_dashboard/features/project/providers/model_providers/editing_project_provider.dart';
import 'package:haneen_site__api_dashboard/features/project/ui/pages/progect_form_page.dart';
import 'package:haneen_site__api_dashboard/features/project/ui/pages/project_slug_checking_page.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/* 
 title: { type: DataTypes.STRING, allowNull: false },
  slug: { type: DataTypes.STRING, unique: true },
  description: DataTypes.TEXT,
  githubLink: DataTypes.STRING,
  iconUrl: DataTypes.STRING,
  price: DataTypes.STRING,
  liveDemoLink: DataTypes.STRING,
  features: DataTypes.ARRAY(DataTypes.STRING),

  thumbnailUrl: DataTypes.STRING,}

*/
class EditProjectScreen extends HookConsumerWidget {
  const EditProjectScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final editingProject = ref.watch(editingProjectProvider);
    final slugController = useTextEditingController();
    final formKey = GlobalKey<FormState>();

    _listenToProjectSlugChange(ref, context, slugController);

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              ref.read(editingProjectProvider.notifier).reset();
              context.go(homeRoute);
            },
          ),
        ],
        title: Text("Edit Project"),
      ),
      body: editingProject.slug.isEmpty
          ? projectSlugCheckingPage(slugController: slugController)
          : ProgectFormPage(formKey: formKey, editingProject: editingProject),
    );
  }

  void _listenToProjectSlugChange(
    WidgetRef ref,
    BuildContext context,
    TextEditingController slugController,
  ) {
    ref.listen(checkProjectSlugExistsProvider, (previous, next) {
      next.when(
        data: (data) {
          if (data != null) {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Project Exists'),
                content: const Text(
                  'A project with this slug already exists. Would you like to edit it instead?',
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('No'),
                  ),
                  TextButton(
                    onPressed: () {
                      ref
                          .read(editingProjectProvider.notifier)
                          .setProject(data);
                      Navigator.pop(context);
                    },
                    child: const Text('Yes'),
                  ),
                ],
              ),
            );
          }
        },
        error: (error, stackTrace) {
          if (error is DioException) {
            if (error.response?.statusCode == 404) {
              ref
                  .read(editingProjectProvider.notifier)
                  .editProject(slug: slugController.text.replaceAll(' ', '-'));
            } else {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(error.toString())));
            }
          }
        },
        loading: () {},
      );
    });
  }
}
