import 'package:flutter/material.dart';
import 'package:haneen_site__api_dashboard/features/application/providers/models_providers/app_provider.dart';
import 'package:haneen_site__api_dashboard/features/application/providers/use_cases_provider/upload_app_feature_images.dart';
import 'package:haneen_site__api_dashboard/features/application/ui/widgets/form_parts/edit_app_feature_card.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class EditAppFeaturesList extends HookConsumerWidget {
  const EditAppFeaturesList({
    super.key,
    required this.height,
    required this.width,
  });

  final double height;
  final double width;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appFeatures = ref.watch(appProvider).features;

    if (appFeatures.isEmpty) {
      return _addFeatureFloatingActionButton(
        height: height,
        width: width,
        child: Center(
          child: Text(
            'No features added yet',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
        ),
      );
    }

    return _addFeatureFloatingActionButton(
      height: height,
      width: width,
      child: ListView.builder(
        itemCount: appFeatures.length,

        itemBuilder: (context, index) {
          final feature = appFeatures[index];
          return EditAppFeatureCard(
            feature: feature,
            index: index,
            height: height,
            width: width,
          );
        },
      ),
    );
  }
}

class _addFeatureFloatingActionButton extends ConsumerWidget {
  const _addFeatureFloatingActionButton({
    required this.child,
    required this.height,
    required this.width,
  });

  final Widget child;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final app = ref.watch(appProvider);
    final result = ref.watch(uploadAppFeatureImageProvider);
    return SizedBox(
      height: height,
      width: width,
      child: Stack(
        children: [
          child,
          Positioned(
            bottom: 16,
            right: 16,
            child: result.isLoading
                ? const CircularProgressIndicator()
                : IconButton(
                    onPressed: () {
                      if (app.slug.isNotEmpty) {
                        ref
                            .read(uploadAppFeatureImageProvider.notifier)
                            .uploadAppFeatureImage();
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Please add an app first'),
                          ),
                        );
                      }
                    },
                    icon: Icon(
                      Icons.add,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
