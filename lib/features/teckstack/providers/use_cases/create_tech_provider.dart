import 'package:haneen_site__api_dashboard/core/constants/api_constans.dart';
import 'package:haneen_site__api_dashboard/core/providers/dioProvider.dart';

import 'package:haneen_site__api_dashboard/features/teckstack/models/tech_stach_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class _createTechStackUseCase extends AsyncNotifier<TechStackModel?> {
  @override
  TechStackModel? build() {
    return null;
  }

  Future<TechStackModel?> createTechStack(TechStackModel techStack) async {
    state = await AsyncValue.guard(() async {
      final dio = ref.read(dioProvider);
      final response = await dio.post(
        techStackApiRoute,
        data: techStack.toJson(),
      );
      return TechStackModel.fromJson(response.data);
    });
  }
}

final createTechStackProvider =
    AsyncNotifierProvider<_createTechStackUseCase, TechStackModel?>(
      () => _createTechStackUseCase(),
    );
