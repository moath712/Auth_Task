import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_auth_task/core/application.dart';
import 'package:google_fonts/google_fonts.dart';

class Style {
  //themes
  static const Color primary = Color(0xff075995);
  static const Color secondary = Color(0xff009BA6);
  static const Color himamPrimary = Color(0xfffec958);
  static const Color himamSecondary = Color(0xff333333);
  static const Color background = Colors.white;
  static const Color darkNavyBlue = Color(0xff1F2F49);
  static const Color green = Color(0xff36B080);
  static const Color text = Color(0xff757575);
  static const Color darkText = Color(0xff545454);
  static const Color hints = Color(0xffB7B7B7);
  static const Color field = Color(0xffF1F1F1);
  static const Color red = Color(0xffFF7058);
  static const Color blue = Color(0xff75ADDF);
  static const Color linkBlue = Color(0xff407FFF);
  static const Color lines = Color(0xffEBEBEB);
  static const Color forGridOnly = Color(0xffE1E1E1);
  static const Color appBarTitle = Color(0xff1C1B1F);

  static late TextTheme mainFont;
  static late TextTheme secondaryFont;
  static late ThemeData mainTheme;

  static void _setTextTheme(BuildContext context) {
    mainFont = application.isLanguageLTR()
        ? GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
        : GoogleFonts.almaraiTextTheme(Theme.of(context).textTheme);
  }

  static ThemeData lightTheme(
    BuildContext context,
  ) {
    _setTextTheme(context);

    /// Controll the app bar theme from here
    final AppBarTheme appBarTheme = AppBarTheme(
      elevation: 0.0,
      centerTitle: true,
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
        statusBarBrightness: Brightness.light, // For iOS (dark icons)
      ),
      actionsIconTheme: const IconThemeData(color: appBarTitle),
      toolbarTextStyle: mainFont.titleMedium,
      titleTextStyle: mainFont.titleMedium
          ?.copyWith(color: appBarTitle, fontWeight: FontWeight.w600),
      color: background,
      iconTheme: const IconThemeData(color: appBarTitle),
    );

    /// Controll the main theme from here
    return mainTheme = ThemeData(
      // useMaterial3: true,
      appBarTheme: appBarTheme,
      brightness: Brightness.light,
      primaryColor: primary,
      textTheme: mainFont,
      scaffoldBackgroundColor: background,
      textSelectionTheme: TextSelectionThemeData(
        selectionColor: blue.withOpacity(0.5),
      ),
      colorScheme: ThemeData()
          .colorScheme
          .copyWith(
            primary: primary,
            primaryContainer: green,
            onPrimary: himamSecondary,
            secondary: secondary,
            secondaryContainer: himamPrimary,
            onSecondary: darkNavyBlue,
            background: background,
            brightness: Brightness.light,
            surface: Colors.white,
          )
          .copyWith(background: background),
    );
  }
}
