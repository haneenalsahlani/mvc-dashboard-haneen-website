import 'package:flutter/material.dart';
import 'package:haneen_site__api_dashboard/core/providers/loading_provider.dart';

import 'package:haneen_site__api_dashboard/features/auth/ui/pages/log_in_form.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';

class LoginScreen extends ConsumerWidget {
  LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SizedBox(
            height: constraints.maxHeight,
            width: constraints.maxWidth,
            child: LogInScreenForm(constraints: constraints),
          );
        },
      ),
    );
  }
}
