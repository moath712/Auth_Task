import 'package:flutter/material.dart';
import 'package:flutter_auth_task/providers.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '/core/application.dart';
import 'package:dio/dio.dart';
import '../../style/style.dart';
import 'home_screen.dart';

class VerfyEmailScreen extends HookConsumerWidget {
  final String email;
  const VerfyEmailScreen({Key? key, required this.email}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final codeController = useTextEditingController();

    return Scaffold(
      appBar: AppBar(),
      body: Consumer(
        builder: (context, WidgetRef ref, child) {
          final twoFactor = ref.watch(verifyProvider).asData?.value;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 32),
                Text(
                  application.translate('verifyEmail'),
                  style: Style.mainFont.titleLarge,
                ),
                const SizedBox(height: 8),
                Text(
                  application.translate('verifyEmailDesc'),
                  style: Style.mainFont.bodySmall,
                ),
                Text(
                  email,
                  style: Style.mainFont.bodySmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                // ========= this is the pin code field ========= \\
                PinCodeTextField(
                  appContext: context,
                  pastedTextStyle: Style.mainFont.bodyMedium
                      ?.copyWith(color: Style.secondary),
                  length: 4,
                  obscureText: false,
                  obscuringCharacter: '•',
                  autoDismissKeyboard: true,
                  autoDisposeControllers: false,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  enablePinAutofill: true,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  textCapitalization: TextCapitalization.characters,
                  textStyle: Style.mainFont.titleSmall,
                  blinkWhenObscuring: true,
                  animationType: AnimationType.fade,
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(5),
                    inactiveColor: Style.lines,
                    activeColor: Style.lines,
                    selectedColor: Style.lines,
                    activeFillColor: Style.field,
                    inactiveFillColor: Style.field,
                    selectedFillColor: Style.field,
                    fieldWidth: 50,
                    fieldHeight: 50,
                  ),
                  cursorColor: Style.secondary,
                  animationDuration: const Duration(milliseconds: 300),
                  enableActiveFill: true,
                  controller: codeController,
                  keyboardType: TextInputType.text,
                  onCompleted: (v) async {
                    final success = await twoFactor?.login(
                      ref: ref,
                      token: ref.watch(twoFactorTokenProvider),
                      code: codeController.text,
                    );
                    if (success == true) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomeScreen()),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Invalid two factor code')),
                      );
                    }
                  },
                  onChanged: (value) {
                    debugPrint(value);
                  },
                  onAutoFillDisposeAction: AutofillContextAction.cancel,
                ),

                const SizedBox(height: 16),

                const Spacer(flex: 4),
              ],
            ),
          );
        },
      ),
    );
  }
}

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
      final refresh = responseData['refresh'];
      ref.read(accessProvider.notifier).state = access;
      print("access :  $access");
      print("refresh : $refresh");

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
