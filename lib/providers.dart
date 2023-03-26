import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final twoFactorTokenProvider = StateProvider<String>((ref) => '');

final twoFactorProvider = FutureProvider<AuthService>((ref) async {
  return AuthService();
});

class AuthService {
  Future<bool> login(
      {required String email,
      required String password,
      required WidgetRef ref}) async {
    try {
      final Dio dio = Dio();
      final response =
          await dio.post('https://services.himam.com/api/auth/login', data: {
        'email': email,
        'password': password,
        'clientOrganizationId': 1,
      });

      final responseData = response.data;
      final token = responseData['twoFactorToken'];

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
