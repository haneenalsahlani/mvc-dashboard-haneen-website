import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gpt_markdown/gpt_markdown.dart';
import 'package:haneen_site__api_dashboard/core/themes/styles/gpy_highliter.dart';
import 'package:haneen_site__api_dashboard/features/blog/providers/ui_providers/content_input_provider.dart';

class GptRender extends ConsumerWidget {
  const GptRender({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final contentController = ref.watch(contentInputControllerProvider);

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GptMarkdown(
          contentController,

          codeBuilder: KCodeBuilder,
          imageBuilder: KImageBuilder,
        ),
      ),
    );
  }
}
