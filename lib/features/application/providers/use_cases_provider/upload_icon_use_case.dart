import 'package:haneen_site__api_dashboard/core/constants/api_constans.dart';
import 'package:haneen_site__api_dashboard/core/providers/dioProvider.dart';
import 'package:haneen_site__api_dashboard/core/services/file_picker_service.dart';
import 'package:haneen_site__api_dashboard/core/utils/add_to_formdata.dart';
import 'package:dio/dio.dart';
import 'package:haneen_site__api_dashboard/features/application/providers/models_providers/app_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class _UploadIconNotifier extends Notifier<AsyncValue<String>> {
  @override
  AsyncValue<String> build() {
    return const AsyncValue.data("");
  }

  Future<void> uploadIcon() async {
    state = const AsyncValue.loading();
    final files = await pickSingleSvg();

    if (files.isEmpty) {
      state = const AsyncValue.data("No file selected");
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
      final imageUrl = data[0]['url'] as String;
      ref.read(appProvider.notifier).setIconUrl(imageUrl);

      return imageUrl;
    });
  }
}

final uploadIconProvider =
    NotifierProvider<_UploadIconNotifier, AsyncValue<String>>(() {
      return _UploadIconNotifier();
    });
