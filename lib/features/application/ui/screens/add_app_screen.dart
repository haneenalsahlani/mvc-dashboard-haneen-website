import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:haneen_site__api_dashboard/core/router/route_names.dart';
import 'package:haneen_site__api_dashboard/features/application/providers/models_providers/app_provider.dart';
import 'package:haneen_site__api_dashboard/features/application/ui/widgets/form_parts/edit_app_features_list.dart';
import 'package:haneen_site__api_dashboard/features/application/ui/widgets/form_parts/app_form.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AddAppScreen extends HookConsumerWidget {
  const AddAppScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final developmentStageController = useTextEditingController();
    final app = ref.watch(appProvider);
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              context.go(homeRoute);
            },
          ),
        ],
        title: const Text('Add App'),
      ),
      body: app.slug.isEmpty
          ? Column(
              children: [
                TextField(
                  controller: developmentStageController,

                  decoration: const InputDecoration(
                    labelText: 'Development Stage',
                  ),
                ),
                OutlinedButton(
                  onPressed: () {
                    if (developmentStageController.text.isNotEmpty) {
                      ref
                          .read(appProvider.notifier)
                          .setSlugandDevelopmentStage(
                            developmentStageController.text,
                          );
                    }
                  },
                  child: Text('add app development stage'),
                ),
              ],
            )
          : LayoutBuilder(
              builder: (context, constraints) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: constraints.maxWidth,
                    height: constraints.maxHeight,
                    child: Row(
                      children: [
                        SizedBox(
                          width: constraints.maxWidth * 0.3,
                          height: constraints.maxHeight,
                          child: AppForm(
                            allowedConstaints: BoxConstraints(
                              maxWidth: constraints.maxWidth * 0.3,
                              maxHeight: constraints.maxHeight,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              EditAppFeaturesList(
                                height: constraints.maxHeight * 0.9,
                                width: constraints.maxWidth * 0.8,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
