import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:haneen_site__api_dashboard/features/application/models/app_model.dart';
import 'package:haneen_site__api_dashboard/features/application/providers/use_cases_provider/list_apps_provider.dart';
import 'package:haneen_site__api_dashboard/features/application/ui/widgets/app_card.dart';
import 'package:haneen_site__api_dashboard/features/home/ui/components/container_placeholder/container_dark_bk.dart.dart';

class AppsDashboardContainer extends ConsumerWidget {
  const AppsDashboardContainer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final apps = ref.watch(listAppsProvider);
    return ContainerDarkBk(
      child: Column(
        children: [
          Text("apps list", style: Theme.of(context).textTheme.titleLarge),
          Expanded(
            child: apps.when(
              data: (data) => ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  AppModel app = data[index];
                  return AppCard(app: app);
                },
              ),
              error: (error, stackTrace) => const Center(child: Text("error")),
              loading: () => const Center(child: CircularProgressIndicator()),
            ),
          ),
        ],
      ),
    );
  }
}
