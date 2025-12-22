import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:haneen_site__api_dashboard/core/constants/api_constans.dart';
import 'package:haneen_site__api_dashboard/core/providers/dioProvider.dart';
import 'package:haneen_site__api_dashboard/core/services/api_service.dart';
import 'package:haneen_site__api_dashboard/features/application/models/app_model.dart';
import 'package:haneen_site__api_dashboard/features/application/providers/models_providers/app_provider.dart';

class _CreateAppNotifier extends Notifier<AsyncValue<AppModel?>> {
  @override
  AsyncValue<AppModel?> build() {
    return AsyncValue<AppModel?>.data(null);
  }

  Future<void> createApp(
    String price,
    String effortLevel,
    String hoursWorked,
    String description,
    String githubLink,
    String liveLink,
  ) async {
    state = await AsyncValue.guard(() async {
      final dio = ref.read(dioProvider);
      var app = ref.read(appProvider);
      if (app.features.isEmpty ||
          app.slug.trim().isEmpty ||
          app.icon.trim().isEmpty) {
        throw Exception("please fill all fields");
      }
      app = app.copyWith(
        title: app.slug.replaceAll(" ", "-"),
        price: double.parse(price),
        effortLevel: effortLevel,
        hoursWorked: int.parse(hoursWorked),
        description: description,
        githubLink: githubLink,
        liveLink: liveLink,
      );

      ApiService apiService = ApiService(dio);

      final response = await apiService.handleRequest(
        () async => dio.post(applicationApiRoute, data: app.toJson()),
        parser: (data) => AppModel.fromJson(data),
        ref: ref,
      );
      return response;
    });
  }
}

final createAppProvider =
    NotifierProvider<_CreateAppNotifier, AsyncValue<AppModel?>>(
      () => _CreateAppNotifier(),
    );
