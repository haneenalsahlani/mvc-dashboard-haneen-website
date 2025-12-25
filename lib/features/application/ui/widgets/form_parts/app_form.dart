import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:haneen_site__api_dashboard/core/router/route_names.dart';

import 'package:haneen_site__api_dashboard/features/application/providers/use_cases_provider/create_app_provider.dart';
import 'package:haneen_site__api_dashboard/features/application/ui/widgets/text_fields/app_dics_field.dart';

import 'package:haneen_site__api_dashboard/features/application/ui/widgets/text_fields/app_text_form_field.dart';
import 'package:haneen_site__api_dashboard/features/application/ui/widgets/text_fields/app_title_container.dart';
import 'package:haneen_site__api_dashboard/features/application/ui/widgets/text_fields/wide_app_text_form_field.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AppForm extends HookConsumerWidget {
  const AppForm({super.key, required this.allowedConstaints});

  final BoxConstraints allowedConstaints;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(createAppProvider, (previous, next) {
      // Only navigate when we have successful data that's not null
      if (next.hasValue && next.value != null) {
        context.go(homeRoute);
      }
      // Optionally handle errors
      if (next.hasError) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error: ${next.error}')));
      }
    });

    final createApp = ref.watch(createAppProvider);
    final formKey = GlobalKey<FormState>();
    final descriptionController = useTextEditingController();
    final hoursWorkedController = useTextEditingController();
    final effortLevelController = useTextEditingController();
    final githubLinkController = useTextEditingController();
    final liveLinkController = useTextEditingController();
    final priceController = useTextEditingController();
    return createApp.isLoading
        ? Center(child: CircularProgressIndicator())
        : Form(
            key: formKey,
            child: Column(
              spacing: 20,
              children: [
                AppTitleContainer(),

                AppDicsField(descriptionController: descriptionController),
                SizedBox(
                  height: allowedConstaints.maxHeight * 0.3,
                  width: allowedConstaints.maxWidth,
                  child: Wrap(
                    runSpacing: 20,
                    spacing: 20,
                    children: [
                      SmallAppTextFormField(
                        controller: hoursWorkedController,
                        label: "hours worked",
                      ),
                      SmallAppTextFormField(
                        controller: effortLevelController,
                        label: "effort level",
                      ),
                      WideAppTextFormField(
                        controller: githubLinkController,
                        label: "github link",
                      ),
                    ],
                  ),
                ),
                SizedBox(height: allowedConstaints.maxHeight * 0.1),
                SizedBox(
                  height: allowedConstaints.maxHeight * 0.1,
                  width: allowedConstaints.maxWidth,
                  child: Row(
                    mainAxisAlignment: .spaceEvenly,
                    crossAxisAlignment: .stretch,

                    children: [
                      OutlinedButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            ref
                                .read(createAppProvider.notifier)
                                .createApp(
                                  effortLevelController.text,
                                  hoursWorkedController.text,
                                  descriptionController.text,
                                  githubLinkController.text,
                                );
                            createApp.whenData((data) {
                              if (data != null) {
                                context.go(homeRoute);
                              }
                            });
                          }
                        },
                        child: Text("create app"),
                      ),
                      FilledButton(onPressed: () {}, child: Text("Cancel")),
                    ],
                  ),
                ),
              ],
            ),
          );
  }
}
