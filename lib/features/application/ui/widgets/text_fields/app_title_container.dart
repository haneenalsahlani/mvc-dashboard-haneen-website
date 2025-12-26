import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:haneen_site__api_dashboard/core/widgets/dark_container.dart';
import 'package:haneen_site__api_dashboard/features/application/providers/models_providers/app_provider.dart';
import 'package:haneen_site__api_dashboard/features/application/providers/use_cases_provider/upload_icon_use_case.dart';
import 'package:haneen_site__api_dashboard/features/application/ui/widgets/text_fields/app_icon_widget.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AppTitleContainer extends HookConsumerWidget {
  const AppTitleContainer({super.key});
  //TOdo
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appSlugController = useTextEditingController();

    final uploadImageIcon = ref.watch(uploadIconProvider);
    final _app = ref.watch(appProvider);

    return DarkContainer(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Icon holder with add photo button
          Stack(
            children: [
              _app.icon.isEmpty
                  ? Icon(
                      Icons.app_shortcut,
                      size: 40,
                      color: Theme.of(context).colorScheme.primary,
                    )
                  : AppIconWidget(app: _app),

              // Add photo button positioned on the icon
              Positioned(
                right: -8,
                bottom: -8,
                child: uploadImageIcon.isLoading
                    ? const CircularProgressIndicator(strokeWidth: 2)
                    : AddAppIconButton(slug: _app.slug),
              ),
            ],
          ),

          const Spacer(),

          // App slug text
          Text(_app.slug, style: Theme.of(context).textTheme.bodyLarge),

          // Edit name button
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text("Enter title"),
                    content: TextField(
                      controller: appSlugController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          context.pop();
                        },
                        child: const Text("Cancel"),
                      ),
                      TextButton(
                        onPressed: () {
                          ref
                              .read(appProvider.notifier)
                              .setSlugandDevelopmentStage(
                                appSlugController.text.trim().replaceAll(
                                  " ",
                                  "-",
                                ),
                              );
                          context.pop();
                        },
                        child: const Text("Save"),
                      ),
                    ],
                  );
                },
              );
            },
            icon: Icon(
              Icons.edit,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ],
      ),
    );
  }
}

class AddAppIconButton extends HookConsumerWidget {
  const AddAppIconButton({super.key, required String slug}) : _slug = slug;

  final String _slug;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IconButton(
      iconSize: 10,
      padding: EdgeInsets.zero,

      onPressed: () {
        if (_slug.trim().isEmpty) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text("Please enter a title")));
          return;
        }
        ref.read(uploadIconProvider.notifier).uploadIcon();
      },
      icon: Icon(
        Icons.add_a_photo,
        color: Theme.of(context).colorScheme.primary,
      ),
    );
  }
}
