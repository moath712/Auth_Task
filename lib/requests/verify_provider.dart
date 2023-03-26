import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';

class TwoFactor {
  final Dio dio = Dio();

  Future<bool> login(
      {required String token,
      required String code,
      required WidgetRef ref}) async {
    try {
      final response = await dio
          .post('https://services.himam.com/api/auth/2fa', queryParameters: {
        'token': token,
        'code': code,
      });

      final responseData = response.data;

      final access = responseData['access'];

      ref.read(accessProvider.notifier).state = access;

      return true;
    } catch (e) {
      debugPrint(e.toString());
      if (e is DioError) debugPrint(e.response.toString());
    }
    return false;
  }
}

final accessProvider = StateProvider<String>((ref) => '');

final verifyProvider = FutureProvider<TwoFactor>((ref) async {
  return TwoFactor();
});
