class ResponseApi {
  final int code;
  final String message;
  final String? accessToken;

  ResponseApi({
    required this.code,
    required this.message,
    this.accessToken,
  });

  factory ResponseApi.fromJson(Map<String, dynamic> json, {required int statusCode}) {
    return ResponseApi(
      code: statusCode,
      message: json["message"] ?? "",
      accessToken: json["access_token"],
    );
  }
}
