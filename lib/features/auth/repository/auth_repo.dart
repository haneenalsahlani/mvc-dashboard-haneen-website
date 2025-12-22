import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:haneen_site__api_dashboard/core/models/response_model.dart';
import 'package:haneen_site__api_dashboard/core/providers/dioProvider.dart';
import 'package:haneen_site__api_dashboard/core/services/api_service.dart';

// //////////////////////////////////////////////

// Define the AsyncNotifierProvider
final loginProvider = Provider<_LogIn>((ref) {
  return _LogIn(ref);
});

class _LogIn {
  final Ref ref;
  _LogIn(this.ref);

  Future<ResponseModel?> login(String credentials) async {
    String? authHeader;
    authHeader = 'Basic ${base64Encode(utf8.encode(credentials))}';
    final dio = ref.read(dioProvider);
    dio.options.headers = {"Authorization": authHeader};
    final ApiService apiService = ApiService(dio);

    final responseModel = await apiService.handleRequest(
      () => apiService.dio.get('/login'),
      parser: (data) => ResponseModel.fromJson(data, 200),
      ref: ref,
    );
    return responseModel;
  }
}
