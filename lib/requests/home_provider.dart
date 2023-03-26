import 'package:flutter_auth_task/requests/verify_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

final name2 = StateProvider<String>((ref) => '');

final nameProvider = FutureProvider<String>((ref) async {
  final access = ref.watch(accessProvider);
  final response = await http.get(
    Uri.parse('https://services.himam.com/api/auth'),
    headers: {'Authorization': 'Bearer $access'},
  );
  final json = jsonDecode(response.body);

  ref.read(name2.notifier).state = json['firstName'];
  return json['firstName'];
});
