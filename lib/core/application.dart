import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sprintf/sprintf.dart';
import 'package:url_launcher/url_launcher.dart';

import '/core/managers/user_manager.dart';

import 'lang/app_localizations.dart';

final themeProvider = StateProvider<ThemeMode>((ref) => UserManager().appTheme);
final langProvider = StateProvider<Locale>((ref) => UserManager().appLang);

class Application {
  static final Application _application = Application._internal();
  factory Application() {
    return _application;
  }
  Application._internal();
  late AppLocalizations appTranslations;

  //function to be invoked when changing the language
  LocaleChangeCallback? onLocaleChanged;

  List<Function(AppLocalizations)> callbaks = <Function(AppLocalizations)>[];
  void notifyOnLocaleChanged(AppLocalizations appTranslations) {
    this.appTranslations = appTranslations;
    // Log.pr("notifyOnLocaleChanged ${appTranslations.currentLanguage}");
    for (final item in callbaks) {
      item(appTranslations);
    }
  }

  Future<void> setLanguage(int index, Reader read) async {
    UserManager()
        .setAppLanguage(AppLocalizations.supportedLanguagesCodes[index]);
    final newLang = AppLocalizations.supportedLocales().toList()[index];
    final appTranslations = await AppLocalizations.delegate.load(newLang);
    debugPrint("load Done");
    read(langProvider.notifier).state = newLang;
    application.notifyOnLocaleChanged(appTranslations);
  }

  String translate(String key, {List<dynamic>? args}) {
    final String str = appTranslations.translate(key);
    if (args != null) {
      return sprintf(str, args);
    }
    return str;
  }

  bool isLanguageLTR() {
    if (UserManager().appLang == const Locale('en')) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> setTheme(Reader read) async {
    final state = read(themeProvider);
    read(themeProvider.notifier).state =
        state == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    final newTheme = read(themeProvider);
    UserManager().setAppTheme(newTheme);
    // read(themeNotifierProvider.notifier).setTheme(Session.appTheme);
  }

  Future<void> launchLocation(String lat, String lng) async {
    final String googleMapsUrl = "comgooglemaps://?center=$lat,$lng";
    final String appleMapsUrl = "https://maps.apple.com/?q=$lat,$lng";

    if (await canLaunchUrl(Uri.parse(googleMapsUrl))) {
      await launchUrl(Uri.parse(googleMapsUrl));
      return;
    }
    if (await canLaunchUrl(Uri.parse(appleMapsUrl))) {
      await launchUrl(
        Uri.parse(appleMapsUrl),
      );
    } else {
      debugPrint('Could not launch location');
    }
  }


  Future<void> lunchPhone({required String phoneNumber}) async {
    final Uri params = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    final String url = params.toString();
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      debugPrint('Could not launch $url');
    }
  }

  Future<void> linkOnText(LinkableElement link) async {
    if (await canLaunchUrl(Uri.parse(link.url))) {
      await launchUrl(Uri.parse(link.url));
    } else {
      throw 'Could not launch $link';
    }
  }

  Future<void> launchEmail({required String email}) async {
    final Uri params = Uri(
      scheme: 'mailto',
      path: email,
    );
    final String url = params.toString();
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      debugPrint('Could not launch $url');
    }
  }

  void postDelayed({int milliseconds = 500, required VoidCallback callbak}) {
    Future.delayed(Duration(milliseconds: milliseconds), () {
      callbak();
    });
  }
}

Application application = Application();
typedef LocaleChangeCallback = void Function(Locale locale);
