import 'package:flutter/material.dart';
import 'package:gymnastics_app/core/ui/styles/gymnastics_app_colors.dart';

InputDecoration getAuthenticationInputDecorationWidget(String label) {
  return InputDecoration(
    // label: Text(label),
    hintText: label,
    labelStyle:
        const TextStyle(fontSize: 15, color: GymnasticsAppColors.blackColor),
    fillColor: GymnasticsAppColors.whiteColor,
    filled: true,
    contentPadding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(64),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(64),
      borderSide: const BorderSide(
        color: GymnasticsAppColors.blackColor,
        width: 2,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(64),
      borderSide: const BorderSide(
        color: GymnasticsAppColors.blueColorDark,
        width: 4,
      ),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(64),
      borderSide: const BorderSide(
        color: GymnasticsAppColors.redErro,
        width: 2,
      ),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(64),
      borderSide: const BorderSide(
        color: GymnasticsAppColors.redErro,
        width: 4,
      ),
    ),
    // suffixIcon: obscureText
    // ? IconButton(
    //         onPressed: () {
    //           _obscureTextVN.value = !obscureTextVNValue;
    //         },
    //         icon: Icon(
    //           obscureTextVNValue ? Icons.lock : Icons.lock_open,
    //           color: context.primaryColor,
    //         ),
    //       )
    //     : null
  );
}
