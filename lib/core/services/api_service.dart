// api_service.dart
import 'package:dio/dio.dart';
import 'package:haneen_site__api_dashboard/core/providers/loading_provider.dart';
import 'package:haneen_site__api_dashboard/core/services/messanger_service.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ApiService {
  final Dio dio;
  final MessengerService _messenger = MessengerService();

  ApiService(this.dio);

  Future<T?> handleRequest<T>(
    Future<Response> Function() request, {
    required T Function(dynamic) parser,
    bool showErrorMessage = true,
    required Ref ref,
    // Optional flag to control message display
  }) async {
    try {
      final response = await request();

      if (response.data != null) {
        return parser(response.data);
      }

      return null;
    } on DioException catch (e) {
      final errorMessage = _handleDioError(e);
      if (showErrorMessage) {
        ref.read(loadingIndicatorProvider.notifier).setLoading(false);
        _messenger.showError(errorMessage);
      }
      return null;
    } catch (e) {
      final errorMessage = 'Unexpected error: $e';
      if (showErrorMessage) {
        ref.read(loadingIndicatorProvider.notifier).setLoading(false);
        _messenger.showError(errorMessage);
      }
      return null;
    }
  }

  String _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return 'Connection timeout. Please try again.';

      case DioExceptionType.connectionError:
        return 'please check if the host is live or you have a stable internet connection';

      case DioExceptionType.badResponse:
        return _handleStatusCode(
          error.response?.statusCode,
          error.response?.data,
        );

      case DioExceptionType.cancel:
        return 'Request was cancelled.';

      default:
        return 'Something went wrong. Please try again.';
    }
  }

  String _handleStatusCode(int? statusCode, dynamic responseData) {
    // Try to extract error message from response
    String? serverMessage;
    if (responseData is Map) {
      serverMessage =
          responseData['message'] ??
          responseData['error'] ??
          responseData['msg'];
    }

    switch (statusCode) {
      case 400:
        return serverMessage ?? 'Invalid request. Please check your input.';
      case 401:
        return serverMessage ?? 'Session expired. Please log in again.';
      case 403:
        return serverMessage ?? 'Access denied. You don\'t have permission.';
      case 404:
        return serverMessage ?? 'Resource not found.';
      case 422:
        return serverMessage ?? 'Validation failed. Please check your input.';
      case 429:
        return 'Too many requests. Please try again later.';
      case 500:
        return 'Server error. Please try again later.';
      case 503:
        return 'Service temporarily unavailable. Please try again.';
      default:
        return serverMessage ?? 'Error occurred (Code: $statusCode)';
    }
  }
}
