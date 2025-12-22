import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:haneen_site__api_dashboard/core/widgets/dark_container.dart';
import 'package:haneen_site__api_dashboard/core/widgets/image_from_url_card.dart';
import 'package:haneen_site__api_dashboard/features/application/models/app_feature_model.dart';
import 'package:haneen_site__api_dashboard/features/application/providers/models_providers/app_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class EditAppFeatureCard extends HookConsumerWidget {
  const EditAppFeatureCard({
    super.key,
    required this.feature,
    required this.index,
    required this.height,
    required this.width,
  });

  final AppFeatureModel feature;
  final int index;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Each card has its own controllers
    final featureTitleController = useTextEditingController(
      text: feature.title,
    );
    final featureDescriptionController = useTextEditingController(
      text: feature.description,
    );

    return SizedBox(
      height: height,
      width: width,
      child: Column(
        children: [
          // Image Section - 60% of height
          SizedBox(
            height: height * 0.6,
            width: width,
            child: ImageFromUrlCard(imageUrl: feature.imageUrl),
          ),

          const SizedBox(height: 20),

          // Edit Section - 30% of height
          SizedBox(
            height: height * 0.3,
            width: width,
            child: Row(
              children: [
                // Left Side - Title and Buttons
                Expanded(
                  child: Column(
                    children: [
                      // Title TextField
                      Expanded(
                        flex: 2,
                        child: TextField(
                          controller: featureTitleController,
                          textAlign: TextAlign.center,
                          decoration: const InputDecoration(
                            labelText: 'Title',
                            border: OutlineInputBorder(),
                          ),
                          style: Theme.of(context).textTheme.bodyLarge
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                      ),

                      const SizedBox(height: 10),

                      // Buttons Row
                      Expanded(
                        flex: 1,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(right: 5),
                                child: FilledButton(
                                  onPressed: () {
                                    ref
                                        .read(appProvider.notifier)
                                        .removeFeature(
                                          index,
                                          imageUrl: feature.imageUrl,
                                        );
                                  },
                                  style: FilledButton.styleFrom(
                                    backgroundColor: Theme.of(
                                      context,
                                    ).colorScheme.error,
                                  ),
                                  child: const Text('Delete'),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 5),
                                child: FilledButton(
                                  onPressed: () {
                                    // Validation before update
                                    if (featureTitleController.text
                                        .trim()
                                        .isEmpty) {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                            'Title cannot be empty',
                                          ),
                                        ),
                                      );
                                      return;
                                    }

                                    ref
                                        .read(appProvider.notifier)
                                        .updateAppFeature(
                                          index,
                                          featureTitleController.text.trim(),
                                          featureDescriptionController.text
                                              .trim(),
                                        );

                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                          'Feature updated successfully',
                                        ),
                                        duration: Duration(seconds: 2),
                                      ),
                                    );
                                  },
                                  child: const Text('Update'),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(width: 10),

                // Right Side - Description
                Expanded(
                  child: TextField(
                    controller: featureDescriptionController,
                    textAlign: TextAlign.center,
                    maxLines: null,
                    expands: true,
                    decoration: const InputDecoration(
                      labelText: 'Description',
                      border: OutlineInputBorder(),
                      alignLabelWithHint: true,
                    ),
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
