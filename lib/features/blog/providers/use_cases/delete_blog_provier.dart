import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:haneen_site__api_dashboard/core/constants/api_constans.dart';
import 'package:haneen_site__api_dashboard/core/models/response_model.dart';
import 'package:haneen_site__api_dashboard/core/providers/dioProvider.dart';
import 'package:haneen_site__api_dashboard/core/services/api_service.dart';

final deleteBlogProvider = FutureProvider.family<ResponseModel?, int>((
  ref,
  id,
) async {
  final apiService = ApiService(ref.read(dioProvider));
  return apiService.handleRequest(
    () => apiService.dio.delete('$blogApiRoute/$id'),
    ref: ref,
    parser: (p1) => ResponseModel.fromJson(p1, 200),
  );
});
