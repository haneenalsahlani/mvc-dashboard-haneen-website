import 'package:flutter/material.dart';
import 'package:haneen_site__api_dashboard/features/home/ui/components/container_placeholder/container_dark_bk.dart.dart';

class BlogDashboardContainer extends StatelessWidget {
  const BlogDashboardContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return ContainerDarkBk(
      child: Column(
        children: [
          Text("blog list", style: Theme.of(context).textTheme.titleLarge),
        ],
      ),
    );
  }
}
