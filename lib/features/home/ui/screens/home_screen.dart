import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:haneen_site__api_dashboard/features/home/providers/narorow_side_menu_provider.dart';
import 'package:haneen_site__api_dashboard/features/home/ui/components/main_menu/main_menu_contaner.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mainMenu = ref.watch(activeMenuMemberProvider);
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SizedBox(
            height: constraints.maxHeight,
            width: constraints.maxWidth,
            child: Column(
              children: [
                SizedBox(
                  height: constraints.maxHeight * 0.1,
                  width: constraints.maxWidth,
                  child: MainMenuDashboard(),
                ),
                SizedBox(
                  height: constraints.maxHeight * 0.8,
                  width: constraints.maxWidth,
                  child: mainMenu.areaWidget,
                ),
                const Spacer(),
                OutlinedButton(onPressed: () {}, child: const Text("Logout")),
                const Spacer(),
              ],
            ),
          );
        },
      ),
    );
  }
}
