import 'package:haneen_site__api_dashboard/core/constants/api_constans.dart';
import 'package:haneen_site__api_dashboard/core/providers/dioProvider.dart';
import 'package:haneen_site__api_dashboard/core/services/file_picker_service.dart';
import 'package:haneen_site__api_dashboard/core/utils/add_to_formdata.dart';
import 'package:dio/dio.dart';
import 'package:haneen_site__api_dashboard/features/application/providers/models_providers/app_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class _UploadAppFeatureNotifier extends Notifier<AsyncValue<List<String>>> {
  @override
  AsyncValue<List<String>> build() {
    return const AsyncValue.data([]);
  }

  Future<void> uploadAppFeatureImage() async {
    state = const AsyncValue.loading();
    final files = await pickMultiFile();

    if (files.isEmpty) {
      state = const AsyncValue.data([]);
      return;
    }

    final formData = await addFileToFormData(files);

    final dio = ref.read(dioProvider);
    String slug = ref.read(appProvider).slug;
    state = await AsyncValue.guard(() async {
      final response = await dio.post(
        '$uploadFileDestination$applicationApiRoute/$slug',
        data: formData,
        options: Options(headers: {"content-type": "multipart/form-data"}),
      );
      final data = response.data as List<dynamic>;
      final imageUrl = data.map((e) => e['url'] as String).toList();
      ref.read(appProvider.notifier).setFeatureImage(imageUrl);

      return imageUrl;
    });
  }
}

final uploadAppFeatureImageProvider =
    NotifierProvider<_UploadAppFeatureNotifier, AsyncValue<List<String>>>(() {
      return _UploadAppFeatureNotifier();
    });
