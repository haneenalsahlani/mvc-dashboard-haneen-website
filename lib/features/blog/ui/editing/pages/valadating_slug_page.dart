import 'package:flutter/material.dart';
import 'package:haneen_site__api_dashboard/features/blog/providers/use_cases/check_slug_exits.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class valadatingSlugPage extends ConsumerWidget {
  valadatingSlugPage({
    super.key,
    required this.slugController,
    required this.slugNode,
  });

  final TextEditingController slugController;
  final FocusNode slugNode;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: SizedBox(
        width: 200,
        child: Column(
          spacing: 20,
          children: [
            Spacer(),
            TextField(
              controller: slugController,
              focusNode: slugNode,
              decoration: InputDecoration(labelText: 'slug'),
            ),

            OutlinedButton(
              onPressed: () {
                ref.invalidate(checkSlugExistsProvider);
                ref
                    .read(checkSlugExistsProvider.notifier)
                    .checkSlugExists(slugController.text);
              },
              child: Text('check if avaible'),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
