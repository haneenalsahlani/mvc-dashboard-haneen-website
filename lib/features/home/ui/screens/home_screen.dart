import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:haneen_site__api_dashboard/core/router/route_names.dart';
import 'package:haneen_site__api_dashboard/features/home/providers/narorow_side_menu_provider.dart';
import 'package:haneen_site__api_dashboard/features/home/ui/components/main_menu/main_menu_contoaner.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mainMenu = ref.watch(activeMenuMemberProvider);

    return Scaffold(
      body: Row(
        children: [
          SizedBox(width: 40, child: MainMenuDashboard()),

          Expanded(
            child: Column(
              children: [
                Expanded(child: mainMenu.areaWidget),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      OutlinedButton(
                        onPressed: () {},
                        child: const Text("Logout"),
                      ),
                      const Spacer(),
                      OutlinedButton(
                        onPressed: () {
                          switch (mainMenu) {
                            case .files:
                              break;
                            case .blog:
                              context.go(editBlogRoute);
                              break;
                            case .projects:
                              context.go(editProjectRoute);
                              break;
                            case .topics:
                              context.go(editTopicRoute);
                              break;
                            case .stack:
                              context.go(editStackRoute);
                              break;
                          }
                        },
                        child: const Text("add new"),
                      ),
                    ],
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
