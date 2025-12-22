import 'package:haneen_site__api_dashboard/core/constants/api_constans.dart';
import 'package:haneen_site__api_dashboard/core/providers/dioProvider.dart';
import 'package:haneen_site__api_dashboard/core/services/file_picker_service.dart';
import 'package:haneen_site__api_dashboard/core/utils/add_to_formdata.dart';
import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class _UploadImageNotifier extends Notifier<AsyncValue<String>> {
  @override
  AsyncValue<String> build() {
    return const AsyncValue.data("");
  }

  Future<void> uploadImage(String slug, String apiRoute) async {
    state = const AsyncValue.loading();
    final files = await pickSingleFile();

    if (files.isEmpty) {
      state = const AsyncValue.data("No file selected");
      return;
    }

    final formData = await addFileToFormData(files);
    print("files: ${formData.files.toString()}");

    final dio = ref.read(dioProvider);
    state = await AsyncValue.guard(() async {
      final response = await dio.post(
        '$uploadFileDestination$apiRoute/$slug',
        data: formData,
        options: Options(headers: {"content-type": "multipart/form-data"}),
      );
      final data = response.data as List<dynamic>;
      final imageUrl = data[0]['url'] as String;

      print('Upload successful: $imageUrl');
      return imageUrl;
    });
  }
}

final uploadImageProvider =
    NotifierProvider<_UploadImageNotifier, AsyncValue<String>>(() {
      return _UploadImageNotifier();
    });
