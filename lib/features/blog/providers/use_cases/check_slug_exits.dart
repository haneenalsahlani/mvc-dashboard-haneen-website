import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:haneen_site__api_dashboard/core/constants/api_constans.dart';
import 'package:haneen_site__api_dashboard/core/providers/dioProvider.dart';
import 'package:haneen_site__api_dashboard/features/blog/models/blog_model.dart';

class _checkSlugExists extends Notifier<AsyncValue<BlogModel?>> {
  @override
  AsyncValue<BlogModel?> build() {
    return const AsyncValue.data(null);
  }

  Future<void> checkSlugExists(String slug) async {
    slug = slug.trim().replaceAll(' ', '-');
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final dio = ref.read(dioProvider);
      final response = await dio.get("$blogApiRoute/$slug");

      final result = BlogModel.fromJson(response.data);

      return result;
    });
  }

  void reset() {
    state = const AsyncValue.data(null);
  }
}

final checkSlugExistsProvider =
    NotifierProvider<_checkSlugExists, AsyncValue<BlogModel?>>(
      _checkSlugExists.new,
    );
