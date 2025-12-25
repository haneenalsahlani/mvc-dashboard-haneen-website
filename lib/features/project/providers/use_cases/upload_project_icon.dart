import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:haneen_site__api_dashboard/core/constants/api_constans.dart';
import 'package:haneen_site__api_dashboard/core/providers/dioProvider.dart';
import 'package:haneen_site__api_dashboard/core/services/file_picker_service.dart';
import 'package:haneen_site__api_dashboard/core/utils/add_to_formdata.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class _uploadIcon extends AsyncNotifier<String?> {
  @override
  FutureOr<String?> build() async {
    return null;
  }

  Future<void> uploadImage(String slug) async {
    state = AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final files = await pickSingleFile();

      if (files.isEmpty) {
        debugPrint('No file selected');
        return null;
      }

      final formData = await addFileToFormData(files);
      debugPrint("files: ${formData.files.toString()}");

      final dio = ref.read(dioProvider);
      final response = await dio.post(
        '$uploadFileDestination/$projectApiRoute/$slug',
        data: formData,
        options: Options(headers: {"content-type": "multipart/form-data"}),
      );

      final data = response.data as List<dynamic>;
      final imageUrl = data[0]['url'] as String;

      debugPrint('Upload successful: $imageUrl');
      return imageUrl;
    });
  }
}

final uploadProjectIconProvider = AsyncNotifierProvider<_uploadIcon, String?>(
  () {
    return _uploadIcon();
  },
);
