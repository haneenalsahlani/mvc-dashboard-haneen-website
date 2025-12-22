// features/blog/viewmodels/add_blog_viewmodel.dart
import 'package:flutter/material.dart';
import 'package:haneen_site__api_dashboard/core/constants/api_constans.dart';
import 'package:haneen_site__api_dashboard/core/providers/dioProvider.dart';
import 'package:haneen_site__api_dashboard/core/services/api_service.dart';
import 'package:haneen_site__api_dashboard/core/services/file_picker_service.dart';
import 'package:haneen_site__api_dashboard/core/utils/add_to_formdata.dart';
import 'package:dio/dio.dart';
import 'package:haneen_site__api_dashboard/features/blog/models/blog_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AddBlogViewModel extends Notifier<AsyncValue<BlogModel?>> {
  @override
  build() {
    return AsyncValue.data(null);
  }

  Future<BlogModel?> submitBlog(BlogModel blog) async {
    ApiService _apiService = ApiService(ref.read(dioProvider));
    state = const AsyncValue.loading();

    state = await AsyncValue.guard(() async {
      final response = await _apiService.handleRequest(
        () => _apiService.dio.post(blogApiRoute, data: blog.toJson()),
        parser: (data) => BlogModel.fromJson(data),
        ref: ref,
      );

      return response;
    });

    return state.value;
  }

  Future<BlogModel?> updateBlog(BlogModel blog) async {
    ApiService _apiService = ApiService(ref.read(dioProvider));
    state = const AsyncValue.loading();

    state = await AsyncValue.guard(() async {
      final response = await _apiService.handleRequest(
        () => _apiService.dio.put(
          blogApiRoute + "/${blog.id}",
          data: blog.toJson(),
        ),
        parser: (data) => BlogModel.fromJson(data),
        ref: ref,
      );

      return response;
    });

    return state.value;
  }

  Future<String?> uploadImage(String slug) async {
    try {
      final files = await pickSingleFile();

      if (files.isEmpty) {
        debugPrint('No file selected');
        return null;
      }

      final formData = await addFileToFormData(files);
      debugPrint("files: ${formData.files.toString()}");

      final dio = ref.read(dioProvider);
      final response = await dio.post(
        '$uploadFileDestination/$blogApiRoute/$slug',
        data: formData,
        options: Options(headers: {"content-type": "multipart/form-data"}),
      );

      final data = response.data as List<dynamic>;
      final imageUrl = data[0]['url'] as String;

      debugPrint('Upload successful: $imageUrl');
      return imageUrl;
    } catch (error) {
      debugPrint('Upload error: $error');
      rethrow;
    }
  }
}

// Provider definition
final addBlogViewModelProvider =
    NotifierProvider<AddBlogViewModel, AsyncValue<BlogModel?>>(() {
      return AddBlogViewModel();
    });
