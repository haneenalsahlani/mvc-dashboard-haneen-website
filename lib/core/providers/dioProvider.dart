import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:haneen_site__api_dashboard/core/constants/api_constans.dart';
import 'package:haneen_site__api_dashboard/features/auth/repository/credentials_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final dioProvider = Provider<Dio>((ref) {
  final credentials = ref.watch(credentialsProvider);

  String? authHeader;
  credentials.whenData((value) {
    authHeader = 'Basic ${base64Encode(utf8.encode(value))}';
  });

  return Dio(
    BaseOptions(
      baseUrl: host,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      headers: {"Authorization": authHeader},
    ),
  );
});
