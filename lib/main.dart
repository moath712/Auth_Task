import 'package:flutter/material.dart';
import 'package:flutter_auth_task/core/managers/user_manager.dart';
import 'package:flutter_auth_task/screens/login_screen.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'core/application.dart';
import 'core/lang/app_localizations.dart';
import 'style/style.dart';

Future<void> initApp() async {
  Paint.enableDithering = true;
  WidgetsFlutterBinding.ensureInitialized();
  await UserManager().initState();
  await UserManager().getAppLanguage();
  await UserManager().getAppTheme();
}

void main() async {
  await initApp();

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final local = ref.watch(langProvider);
        final theme = ref.watch(themeProvider);
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          locale: local,
          theme: Style.lightTheme(context),
          themeMode: theme,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales(),
          home: LoginScreen(),
        );
      },
    );
  }
}
