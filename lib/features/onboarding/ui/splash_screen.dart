import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:haneen_site__api_dashboard/core/router/route_names.dart';

import 'package:haneen_site__api_dashboard/features/auth/repository/credentials_provider.dart';
import 'package:haneen_site__api_dashboard/features/onboarding/pages/starting_page.dart';

class SplashScreen extends ConsumerWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authRepo = ref.watch(credentialsProvider);

    return Scaffold(
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return SizedBox(
            width: constraints.maxWidth,
            height: constraints.maxHeight,
            child: authRepo.when(
              data: (data) {
                return data.isEmpty
                    ? StartingPage(
                        constraints: constraints,
                        Destination: loginRoute,
                      )
                    : StartingPage(
                        constraints: constraints,
                        Destination: homeRoute,
                        data: data,
                      );
              },
              loading: () {
                return Center(
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: CircularProgressIndicator(),
                  ),
                );
              },

              error: (error, stackTrace) {
                return StartingPage(
                  constraints: constraints,
                  Destination: loginRoute,
                );
              },
            ),
          );
        },
      ),
    );
  }
}
