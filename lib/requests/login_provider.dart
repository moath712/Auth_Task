import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/retrofit.dart';

part 'login_provider.g.dart';

final twoFactorTokenProvider = StateProvider<String>((ref) => '');
final twoFactorProvider = FutureProvider<AuthService>((ref) async {
  return AuthService(Dio());
});

@RestApi(baseUrl: 'https://services.himam.com/api/auth')
abstract class AuthServiceApi {
  factory AuthServiceApi(Dio dio, {String baseUrl}) = _AuthServiceApi;

  @POST('/login')
  Future<LoginResponse> login(@Body() LoginRequest request);
}

class LoginRequest {
  final String email;
  final String password;
  final int clientOrganizationId;

  LoginRequest({
    required this.email,
    required this.password,
    required this.clientOrganizationId,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'clientOrganizationId': clientOrganizationId,
    };
  }
}

class LoginResponse {
  final String twoFactorToken;

  LoginResponse({required this.twoFactorToken});

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      twoFactorToken: json['twoFactorToken'],
    );
  }
}

class AuthService {
  final AuthServiceApi _api;

  AuthService(Dio dio) : _api = AuthServiceApi(dio);

  Future<bool> login(
      {required String email,
      required String password,
      required WidgetRef ref}) async {
    try {
      final response = await _api.login(LoginRequest(
        email: email,
        password: password,
        clientOrganizationId: 1,
      ));

      final token = response.twoFactorToken;

      ref.read(twoFactorTokenProvider.notifier).state = token;

      return true;
    } catch (e) {
      // Handle error response here
      debugPrint(e.toString());
      if (e is DioError) debugPrint(e.response.toString());
    }

    // Return false to indicate a failed login
    return false;
  }
}
