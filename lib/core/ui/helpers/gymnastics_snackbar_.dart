import 'package:flutter/material.dart';
import 'package:gymnastics_app/core/ui/styles/gymnastics_app_colors.dart';

showSnackbar(
    {required BuildContext context,
    required String text,
    bool isError = true}) {
  SnackBar snackBar = SnackBar(
    content: Text(text),
    backgroundColor: (isError)
        ? GymnasticsAppColors.redErro
        : GymnasticsAppColors.greenColor,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(16),
      ),
    ),
    duration: const Duration(seconds: 5),
    action: SnackBarAction(
      label: 'OK',
      textColor: GymnasticsAppColors.whiteColor,
      onPressed: () {
        // Navigator.pop(context);
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
      },
    ),
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
