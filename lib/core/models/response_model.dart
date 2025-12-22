class ResponseModel {
  final int statusCode;
  final String message;
  final bool success;

  ResponseModel({
    required this.statusCode,
    required this.message,
    required this.success,
  });

  factory ResponseModel.fromJson(Map<String, dynamic> json, int statusCode) {
    return ResponseModel(
      statusCode: statusCode,
      message: json['message'] as String,
      success: json['success'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {'statusCode': statusCode, 'message': message, 'success': success};
  }
}
