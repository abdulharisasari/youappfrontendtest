import 'package:dio/dio.dart';
import '../../core/utils.dart';
import '../models/profile_model.dart';
import '../providers/api_provider.dart';
import '../models/auth_model.dart';
import '../models/response_api.dart';

class UserRepository {
  final ApiProvider apiProvider;

  UserRepository(this.apiProvider);


  Future<ResponseApi> login(AuthRequest request) async {
    try {
      final response = await apiProvider.dio.post(
        "/api/login",
        data: request.toJson(),
      );
      
      return ResponseApi.fromJson(response.data, statusCode: response.statusCode ?? 0);
    } on DioException catch (e) {
      throw Exception(e.response?.data["message"] ?? "Login failed (code: ${e.response?.statusCode})");
    }
  }

  Future<ResponseApi> register(AuthRequest request) async {
    try {
      final response = await apiProvider.dio.post(
        "/api/register",
        data: request.toJson(),
      );
      return ResponseApi.fromJson(response.data, statusCode: response.statusCode ?? 0);
    } on DioException catch (e) {
      throw Exception(e.response?.data["message"] ?? "Register failed (code: ${e.response?.statusCode})");
    }
  }

  Future<ResponseApi> createProfile(ProfileRequest request) async {
    try {
      final response = await apiProvider.dio.post(
        "/api/createProfile",
        data: request.toJson(),
        options: Utils.headerToken(),
      );
      return ResponseApi.fromJson(response.data,statusCode: response.statusCode ?? 0);
    } on DioException catch (e) {
      throw Exception( e.response?.data["message"] ?? "Create profile failed (code: ${e.response?.statusCode})");
    }
  }

  Future<ProfileResponse> getProfile() async {
    try {
      final response = await apiProvider.dio.get(
        "/api/getProfile",
        options: Utils.headerToken(),
      );
      return ProfileResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception(e.response?.data["message"] ?? "Get profile failed (code: ${e.response?.statusCode})");
    }
  }


  Future<ResponseApi> updateProfile(ProfileRequest request) async {
    try {
      final response = await apiProvider.dio.put(
        "/api/updateProfile",
        data: request.toJson(),
        options: Utils.headerToken(),
      );
      return ResponseApi.fromJson(response.data, statusCode: response.statusCode ?? 0);
    } on DioException catch (e) {
      throw Exception(e.response?.data["message"] ?? "Update profile failed (code: ${e.response?.statusCode})");
    }
  }


}

