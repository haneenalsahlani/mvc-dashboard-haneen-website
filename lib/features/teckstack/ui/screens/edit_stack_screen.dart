import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:haneen_site__api_dashboard/core/router/route_names.dart';

import 'package:haneen_site__api_dashboard/features/teckstack/providers/editing_tech_stack_provider.dart';
import 'package:haneen_site__api_dashboard/features/teckstack/providers/use_cases/create_tech_provider.dart';
import 'package:haneen_site__api_dashboard/features/teckstack/providers/use_cases/upload_tach_icon.dart';
import 'package:haneen_site__api_dashboard/features/teckstack/models/tech_stach_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class EditStackScreen extends HookConsumerWidget {
  const EditStackScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(uploadTechIconProvider, (previous, next) {
      if (next.hasError) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(next.error.toString())));
      }
    });

    ref.listen(createTechStackProvider, (previous, next) {
      if (next.hasError) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(next.error.toString())));
      } else if (next.hasValue && next.value != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Tech Stack created successfully")),
        );
        ref.read(editingTechStackProvider.notifier).clear();
        context.go(homeRoute);
      }
    });

    final uploadIcon = ref.watch(uploadTechIconProvider);
    final nameController = useTextEditingController();
    final descriptionController = useTextEditingController();
    final coursesLinkController = useTextEditingController();
    final proficiencyLevelController = useTextEditingController();

    final editingTechStack = ref.watch(editingTechStackProvider);

    final formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(title: const Text('Add Tech Stack')),
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Expanded(
                child: Row(
                  children: [
                    uploadIcon.isLoading
                        ? CircularProgressIndicator()
                        : IconButton.filledTonal(
                            onPressed: () {
                              if (nameController.text.isNotEmpty) {
                                ref
                                    .read(uploadTechIconProvider.notifier)
                                    .uploadIcon(
                                      nameController.text.replaceAll(" ", "-"),
                                    );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text("Please enter a name"),
                                  ),
                                );
                              }
                            },
                            icon: Icon(Icons.add_a_photo),
                          ),
                    editingTechStack.iconUrl.isNotEmpty
                        ? SvgPicture.network(
                            editingTechStack.iconUrl,
                            height: 100,
                            width: 100,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                Icon(Icons.error),
                          )
                        : Icon(Icons.broken_image),
                  ],
                ),
              ),
              TextFormField(
                readOnly: editingTechStack.iconUrl.isNotEmpty,
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Name'),
              ),
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
                controller: descriptionController,
                decoration: const InputDecoration(labelText: 'Description'),
              ),
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a courses link';
                  }
                  return null;
                },
                controller: coursesLinkController,
                decoration: const InputDecoration(labelText: 'courses link'),
              ),
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a proficiency level';
                  }
                  return null;
                },
                controller: proficiencyLevelController,
                decoration: const InputDecoration(
                  labelText: 'proficiency level',
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (formKey.currentState!.validate() &&
                      editingTechStack.iconUrl.isNotEmpty) {
                    ref
                        .read(createTechStackProvider.notifier)
                        .createTechStack(
                          TechStackModel(
                            slug: nameController.text.replaceAll(" ", "-"),
                            iconUrl: editingTechStack.iconUrl,
                            name: nameController.text,
                            description: descriptionController.text,
                            coursesLink: coursesLinkController.text,
                            proficiencyLevel:
                                int.tryParse(proficiencyLevelController.text) ??
                                0,
                          ),
                        );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Please upload an icon')),
                    );
                  }
                },
                child: const Text('Add Tech Stack'),
              ),
              const SizedBox(height: 20),
              const Divider(),
              const SizedBox(height: 20),
              const Text('Cancel'),
            ],
          ),
        ),
      ),
    );
  }
}
