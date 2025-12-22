import 'package:flutter/material.dart';
import 'package:haneen_site__api_dashboard/features/blog/ui/pages/editing_blog_widgets/buttons/blog_change_slug_button.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class BlogHeaderSection extends ConsumerWidget {
  final String title;

  const BlogHeaderSection({required this.title});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final formattedTitle = title.replaceAll("-", " ").toUpperCase();

    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [Colors.black26, Colors.black54]),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        spacing: 10,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: theme.colorScheme.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              Icons.article_outlined,
              color: theme.colorScheme.primary,
            ),
          ),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'CREATE NEW POST',
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.2,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  formattedTitle,
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
              ],
            ),
          ),
          BlogChangeSlugButton(),
        ],
      ),
    );
  }
}
