import 'package:flutter/material.dart';
import 'package:gymnastics_app/core/modals/exercise_modal.dart';
import 'package:gymnastics_app/core/ui/styles/gymnastics_app_colors.dart';
import 'package:gymnastics_app/src/models/exercise_model.dart';

showInitModal(BuildContext context, {ExerciseModel? exercise}) {
  showModalBottomSheet(
    context: context,
    backgroundColor: GymnasticsAppColors.blueColorDark,
    isDismissible: false,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(32),
      ),
    ),
    builder: (context) {
      return ExerciseModal(
        exerciseModel: exercise,
      );
    },
  );
}
