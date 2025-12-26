import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:haneen_site__api_dashboard/core/constants/api_constans.dart';
import 'package:haneen_site__api_dashboard/core/providers/dioProvider.dart';
import 'package:haneen_site__api_dashboard/features/application/models/app_model.dart';

class _ListApp extends AsyncNotifier<List<AppModel>> {
  @override
  FutureOr<List<AppModel>> build() async {
    final dio = ref.read(dioProvider);
    final response = await dio.get(applicationApiRoute);

    if (response.statusCode == 200) {
      final data = response.data as List;
      return data.map((e) => AppModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load apps');
    }
  }

  Future<void> refreshApps() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final dio = ref.read(dioProvider);
      final response = await dio.get(applicationApiRoute);

      if (response.statusCode == 200) {
        final data = response.data as List;
        return data.map((e) => AppModel.fromJson(e)).toList();
      } else {
        throw Exception('Failed to load apps');
      }
    });
  }
}

final listAppsProvider = AsyncNotifierProvider<_ListApp, List<AppModel>>(
  () => _ListApp(),
);
