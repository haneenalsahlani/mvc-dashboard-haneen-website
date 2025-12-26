import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:haneen_site__api_dashboard/features/home/ui/components/main_menu/menu_item_widget.dart';
import 'package:haneen_site__api_dashboard/features/home/ui/pages/work_area_containers/apps_dashboard_container.dart';
import 'package:haneen_site__api_dashboard/features/home/ui/pages/work_area_containers/blog_dashboard_container.dart';
import 'package:haneen_site__api_dashboard/features/home/ui/pages/work_area_containers/files_dashboard_container.dart';
import 'package:haneen_site__api_dashboard/features/home/ui/pages/work_area_containers/projects_dashboard_container.dart';
import 'package:haneen_site__api_dashboard/features/home/ui/pages/work_area_containers/stack_dashboard_container.dart';
import 'package:haneen_site__api_dashboard/features/home/ui/pages/work_area_containers/topics_dashboard_container.dart';

enum MenuItems {
  files(Icons.folder, Icons.folder_rounded, FilesDashboardContainer()),
  blog(Icons.newspaper, Icons.newspaper_rounded, BlogDashboardContainer()),
  projects(
    Icons.add_to_drive,
    Icons.add_to_drive_rounded,
    ProjectsDashboardContainer(),
  ),
  topics(Icons.topic, Icons.topic_rounded, TopicsDashboardContainer()),
  stack(
    Icons.stacked_bar_chart,
    Icons.stacked_bar_chart_rounded,
    StackDashboardContainer(),
  );

  final IconData icon;
  final Widget areaWidget;
  final IconData outLied;

  const MenuItems(this.icon, this.outLied, this.areaWidget);
}

//////////////
///
///
///
////////////////////////

class ActiveMenuMember extends Notifier<MenuItems> {
  @override
  MenuItems build() {
    return MenuItems.files;
  }

  void toggle(MenuItems newItem) {
    state = newItem;
  }
}

final activeMenuMemberProvider = NotifierProvider<ActiveMenuMember, MenuItems>(
  () {
    return ActiveMenuMember();
  },
);

List<Widget> icons = MenuItems.values.map((menuItem) {
  return MenuItemWidget(item: menuItem);
}).toList();
