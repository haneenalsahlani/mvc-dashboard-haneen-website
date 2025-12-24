import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:haneen_site__api_dashboard/core/router/route_names.dart';

class MainDashboardContainer extends StatelessWidget {
  const MainDashboardContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Theme.of(context).colorScheme.surfaceContainerHighest.withAlpha(50),
            Theme.of(context).colorScheme.surfaceContainerHigh.withAlpha(50),
            Theme.of(context).colorScheme.surfaceContainerHighest.withAlpha(50),
          ],
        ),
      ),
      child: Center(
        child: Column(
          spacing: 20,
          children: [
            Spacer(),
            TextButton.icon(
              onPressed: () {
                context.go(editBlogRoute);
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
                context.go(editAppRoute);
              },
              icon: Icon(Icons.add),
              label: Text("add app"),
            ),
            TextButton.icon(
              onPressed: () {
                context.go(editTechStackRoute);
              },
              icon: Icon(Icons.add),
              label: Text("add tech stack"),
            ),
            TextButton.icon(
              onPressed: () {
                context.go(editProjectRoute);
              },
              icon: Icon(Icons.add),
              label: Text("add project"),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
