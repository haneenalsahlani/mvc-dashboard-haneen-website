import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:haneen_site__api_dashboard/core/providers/loading_provider.dart';
import 'package:haneen_site__api_dashboard/core/router/route_names.dart';
import 'package:haneen_site__api_dashboard/features/auth/repository/auth_repo.dart';
import 'package:lottie/lottie.dart';

class StartingPage extends ConsumerWidget {
  const StartingPage({
    super.key,
    required this.constraints,
    required this.Destination,
    this.data,
  });
  final BoxConstraints constraints;

  final String Destination;
  final String? data;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = ref.watch(loadingIndicatorProvider);
    return isLoading
        ? Center(child: CircularProgressIndicator())
        : Row(
            children: [
              Spacer(),
              Expanded(
                child: Column(
                  children: [
                    Spacer(),
                    SizedBox(
                      width: constraints.maxWidth / 2,
                      height: constraints.maxHeight / 2,
                      child: Lottie.asset("assets/AnimatedDashboards.json"),
                    ),
                    FilledButton.tonalIcon(
                      onPressed: Destination == loginRoute
                          ? () {
                              context.go(Destination);
                            }
                          : () {
                              ref
                                  .read(loadingIndicatorProvider.notifier)
                                  .setLoading(true);
                              ref.read(loginProvider).login(data!).then((
                                value,
                              ) {
                                if (value != null) {
                                  ref
                                      .read(loadingIndicatorProvider.notifier)
                                      .setLoading(false);
                                  context.go(Destination);
                                }
                              });
                            },
                      label: Text("start"),
                    ),
                    Spacer(),
                  ],
                ),
              ),
              Spacer(),
            ],
          );
  }
}
