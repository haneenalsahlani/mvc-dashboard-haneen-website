import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:haneen_site__api_dashboard/core/router/route_names.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Expanded(
        child: Column(
          children: [
            const Spacer(),
            Text("some thing wrong hannped"),
            const Spacer(),
            OutlinedButton(
              onPressed: () {
                context.go(splashRoute);
              },
              child: const Text("Retry"),
            ),
          ],
        ),
      ),
    );
  }
}
