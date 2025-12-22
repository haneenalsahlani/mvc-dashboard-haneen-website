import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:haneen_site__api_dashboard/core/router/route_names.dart';

class MainDashboardContainer extends StatelessWidget {
  const MainDashboardContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        spacing: 20,
        children: [
          Spacer(),
          TextButton.icon(
            onPressed: () {
              context.go(addBlogRoute);
            },
            icon: Icon(Icons.add),
            label: Text("Add Blog"),
          ),
          TextButton.icon(
            onPressed: () {
              context.go(blogsListRoute);
            },
            icon: Icon(Icons.list),
            label: Text("Blogs List"),
          ),
          TextButton.icon(
            onPressed: () {
              context.go(addAppRoute);
            },
            icon: Icon(Icons.add),
            label: Text("add app"),
          ),
          TextButton.icon(
            onPressed: () {
              context.go(addTechStackRoute);
            },
            icon: Icon(Icons.add),
            label: Text("add tech stack"),
          ),
          Spacer(),
        ],
      ),
    );
  }
}
