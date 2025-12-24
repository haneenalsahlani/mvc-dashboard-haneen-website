import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:haneen_site__api_dashboard/features/home/ui/components/main_menu/menu_item_widget.dart';
import 'package:haneen_site__api_dashboard/features/home/ui/pages/work_area_containers/apps_dashboard_container.dart';
import 'package:haneen_site__api_dashboard/features/home/ui/pages/work_area_containers/main_dashboard_container.dart';

enum MenuItems {
  main(Icons.home, Icons.home_rounded, MainDashboardContainer()),
  app(Icons.apps, Icons.apps_rounded, AppsDashboardContainer());

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
    return MenuItems.main;
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
