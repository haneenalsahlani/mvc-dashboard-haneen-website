import 'package:flutter/material.dart';
import 'package:haneen_site__api_dashboard/features/home/providers/narorow_side_menu_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MainMenuDashboard extends ConsumerWidget {
  const MainMenuDashboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      spacing: 20,
      mainAxisAlignment: .center,
      crossAxisAlignment: .end,
      children: [Spacer(), ...icons, Spacer()],
    );
  }
}
