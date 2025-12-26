import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:haneen_site__api_dashboard/core/router/route_names.dart';
import 'package:haneen_site__api_dashboard/features/project/models/project_model.dart';
import 'package:haneen_site__api_dashboard/features/project/providers/model_providers/project_provider.dart';
import 'package:haneen_site__api_dashboard/features/project/providers/use_cases/create_project_provider.dart';
import 'package:haneen_site__api_dashboard/features/project/providers/use_cases/upload_project_icon.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ProgectFormPage extends HookConsumerWidget {
  const ProgectFormPage({
    super.key,
    required this.formKey,
    required this.editingProject,
  });

  final GlobalKey<FormState> formKey;
  final ProjectModel editingProject;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //buttons labels
    final submitButtonLabel = editingProject.id == 0
        ? 'Add Project'
        : 'Update Project';

    //text controllers

    final descriptionController = useTextEditingController();
    final githubLinkController = useTextEditingController();
    final priceController = useTextEditingController();
    final liveDemoLinkController = useTextEditingController();

    //assign values if not null
    if (editingProject.id != 0) {
      descriptionController.text = editingProject.description;
      githubLinkController.text = editingProject.githubLink;
      priceController.text = editingProject.price;
      liveDemoLinkController.text = editingProject.liveDemoLink;
    }

    //listen to upload icon state
    final uploadProjectIconSate = ref.watch(uploadProjectIconProvider);

    ref.listen(createProjectProvider, (previous, next) {
      next.whenData((value) {
        if (value != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Project created successfully')),
          );

          ref.read(ProjectProvider.notifier).reset();
          context.go(homeRoute);
        }
      });
    });
    ref.listen(uploadProjectIconProvider, (previous, next) {
      next.whenData((value) {
        if (value != null) {
          ref.read(ProjectProvider.notifier).editProject(iconUrl: value);
        }
      });
    });

    return Form(
      key: formKey,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: 400,
              child: Column(
                spacing: 20,
                children: [
                  Spacer(),
                  Text(
                    editingProject.title,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  TextFormField(
                    maxLines: 10,
                    minLines: 5,
                    maxLength: 500,
                    controller: descriptionController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.primary,
                          width: 0.2,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      labelText: 'Description',
                    ),
                  ),
                  TextFormField(
                    controller: githubLinkController,
                    decoration: const InputDecoration(labelText: 'Github Link'),
                  ),

                  TextFormField(
                    controller: priceController,
                    decoration: const InputDecoration(labelText: 'Price'),
                  ),
                  TextFormField(
                    controller: liveDemoLinkController,
                    decoration: const InputDecoration(
                      labelText: 'Live Demo Link',
                    ),
                  ),
                  Spacer(),
                ],
              ),
            ),
          ),
          Expanded(
            child: Column(
              spacing: 20,
              children: [
                Row(
                  children: [
                    editingProject.iconUrl.isNotEmpty
                        ? SvgPicture.network(editingProject.iconUrl, width: 100)
                        : const SizedBox(),
                    uploadProjectIconSate.isLoading
                        ? const CircularProgressIndicator()
                        : IconButton(
                            icon: const Icon(Icons.add_a_photo),
                            onPressed: () {
                              ref
                                  .read(uploadProjectIconProvider.notifier)
                                  .uploadImage(editingProject.slug);
                            },
                          ),
                  ],
                ),
                HookBuilder(
                  builder: (context) {
                    final featureController = useTextEditingController();
                    return Column(
                      spacing: 20,
                      crossAxisAlignment: .start,
                      mainAxisAlignment: .start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: featureController,
                                decoration: const InputDecoration(
                                  labelText: 'Add Feature',
                                ),
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.add),
                              onPressed: () {
                                if (featureController.text.isNotEmpty) {
                                  ref
                                      .read(ProjectProvider.notifier)
                                      .editProject(
                                        features: [
                                          ...editingProject.features,
                                          featureController.text,
                                        ],
                                      );

                                  featureController.clear();
                                }
                              },
                            ),
                          ],
                        ),
                        ...editingProject.features.map((feature) {
                          return Text(feature);
                        }),
                      ],
                    );
                  },
                ),
                Spacer(),
                FilledButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      ref
                          .read(ProjectProvider.notifier)
                          .editProject(
                            description: descriptionController.text,
                            githubLink: githubLinkController.text,
                            price: priceController.text,
                            liveDemoLink: liveDemoLinkController.text,
                            features: editingProject.features,
                          );

                      if (editingProject.id == 0) {
                        //craete new project
                        ref
                            .read(createProjectProvider.notifier)
                            .createProject();
                      } else {
                        //update project
                      }
                    }
                  },
                  child: Text(submitButtonLabel),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
