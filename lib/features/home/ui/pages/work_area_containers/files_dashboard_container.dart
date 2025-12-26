import 'package:flutter/material.dart';
import 'package:haneen_site__api_dashboard/features/home/ui/components/container_placeholder/container_dark_bk.dart.dart';

class FilesDashboardContainer extends StatelessWidget {
  const FilesDashboardContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return ContainerDarkBk(
      child: Column(
        children: [
          Text("files list", style: Theme.of(context).textTheme.titleLarge),
        ],
      ),
    );
  }
}
