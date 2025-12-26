import 'package:flutter/material.dart';
import 'package:haneen_site__api_dashboard/features/home/ui/components/container_placeholder/container_dark_bk.dart.dart';

class ProjectsDashboardContainer extends StatelessWidget {
  const ProjectsDashboardContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return ContainerDarkBk(
      child: Column(
        children: [
          Text("projects list", style: Theme.of(context).textTheme.titleLarge),
        ],
      ),
    );
  }
}
