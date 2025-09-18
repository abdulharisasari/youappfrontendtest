import 'package:dio/dio.dart';

class ApiProvider {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: "http://techtest.youapp.ai",
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ),
  );

  Dio get dio => _dio;
}
