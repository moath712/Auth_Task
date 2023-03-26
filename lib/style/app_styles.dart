import 'package:flutter/material.dart';
import 'style.dart';

class AppStyles {
  static InputDecoration formStyle(
    String hint, {
    Widget? suffixIcon,
    Widget? prefixIcon,
    bool? showMaxLength = true,
  }) {
    return InputDecoration(
      isDense: true,
      // isCollapsed: true,
      contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
      labelStyle: Style.mainFont.titleSmall?.copyWith(),
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Style.text),
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Style.text),
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      border: const OutlineInputBorder(
        borderSide: BorderSide(color: Style.text),
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      errorBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.redAccent, width: 1),
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      errorStyle: Style.mainFont.bodySmall?.copyWith(color: Style.red),
      // fillColor: Style.field,
      suffixIcon: suffixIcon,
      counterText: showMaxLength == true ? null : '',
      prefixIcon: prefixIcon == null
          ? null
          : Padding(
              padding: const EdgeInsetsDirectional.only(end: 8),
              child: prefixIcon,
            ),
      // filled: true,
      hintStyle: Style.mainFont.bodySmall?.copyWith(color: Style.hints),
      hintText: hint,
    );
  }
}
