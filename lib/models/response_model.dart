class ApiResponse {
  String message;
  Map<String, dynamic> data;

  ApiResponse({required this.message, required this.data});

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(message: json['message'], data: json['data']);
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'data': data,
    };
  }
}
