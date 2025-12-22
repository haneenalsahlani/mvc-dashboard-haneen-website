import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:haneen_site__api_dashboard/core/constants/api_constans.dart';
import 'package:haneen_site__api_dashboard/core/providers/dioProvider.dart';
import 'package:haneen_site__api_dashboard/core/services/api_service.dart';
import 'package:haneen_site__api_dashboard/features/blog/models/blog_model.dart';

final listBlogProvider = FutureProvider.autoDispose<List<BlogModel>?>((ref) {
  final apiService = ApiService(ref.read(dioProvider));

  final response = apiService.handleRequest(
    () => apiService.dio.get(blogApiRoute),
    parser: (data) => (data as List).map((e) => BlogModel.fromJson(e)).toList(),
    ref: ref,
  );

  return response;
});
