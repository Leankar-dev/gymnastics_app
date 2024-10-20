import 'package:flutter/material.dart';
import 'package:gymnastics_app/core/modals/show_init_modal.dart';
import 'package:gymnastics_app/core/services/firebase/firebase_store/firebase_store_service.dart';
import 'package:gymnastics_app/core/ui/styles/gymnastics_app_colors.dart';
import 'package:gymnastics_app/src/features/exercise/exercise_page.dart';
import 'package:gymnastics_app/src/models/exercise_model.dart';

class GymnasticsInitListWidget extends StatelessWidget {
  final ExerciseModel exerciseModel;
  final ExerciseService service;

  const GymnasticsInitListWidget({
    super.key,
    required this.exerciseModel,
    required this.service,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ExercisePage(
              exerciseModel: exerciseModel,
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: GymnasticsAppColors.whiteColor,
          boxShadow: const [
            BoxShadow(
              blurRadius: 3,
              color: GymnasticsAppColors.blackSplash,
              spreadRadius: 1,
              offset: Offset(2, 2),
            ),
          ],
          borderRadius: BorderRadius.circular(16),
        ),
        height: 100,
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 30),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomRight,
              child: Container(
                decoration: const BoxDecoration(
                  color: GymnasticsAppColors.blueColorDark,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    bottomRight: Radius.circular(16),
                  ),
                ),
                height: 30,
                width: 150,
                child: Center(
                  child: Text(
                    exerciseModel.training,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: GymnasticsAppColors.whiteColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        // height: 200,
                        width: 200,
                        child: Text(
                          exerciseModel.name,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: GymnasticsAppColors.blueColorMedium,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () {
                              showInitModal(context, exercise: exerciseModel);
                            },
                            icon: const Icon(Icons.edit),
                          ),
                          IconButton(
                            onPressed: () {
                              SnackBar snackBar = SnackBar(
                                backgroundColor: GymnasticsAppColors.redColor,
                                content: Text(
                                    'Deseja remover ${exerciseModel.name}?'),
                                action: SnackBarAction(
                                  label: 'REMOVER',
                                  textColor: GymnasticsAppColors.whiteColor,
                                  onPressed: () {
                                    service.removeExercise(
                                        idExercise: exerciseModel.id);
                                  },
                                ),
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            },
                            icon: const Icon(
                              Icons.delete,
                              color: GymnasticsAppColors.redErro,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 150,
                        child: Text(
                          exerciseModel.howTodo,
                          overflow: TextOverflow.ellipsis,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );

    // *****     mudou do ListTile para o InkWell     *******
    // ListTile(
    //   title: Text(exerciseModel.name),
    //   subtitle: Text(exerciseModel.training),
    //   trailing: Row(
    //     mainAxisSize: MainAxisSize.min,
    //     children: [
    //       IconButton(
    //         onPressed: () {
    //           showInitModal(context, exercise: exerciseModel);
    //         },
    //         icon: const Icon(Icons.edit),
    //       ),
    //       IconButton(
    //         onPressed: () {
    //           SnackBar snackBar = SnackBar(
    //             backgroundColor: GymnasticsAppColors.redColor,
    //             content: Text('Deseja remover ${exerciseModel.name}?'),
    //             action: SnackBarAction(
    //               label: 'REMOVER',
    //               textColor: GymnasticsAppColors.whiteColor,
    //               onPressed: () {
    //                 service.removeExercise(idExercise: exerciseModel.id);
    //               },
    //             ),
    //           );
    //           ScaffoldMessenger.of(context).showSnackBar(snackBar);
    //         },
    //         icon: const Icon(Icons.delete),
    //       ),
    //     ],
    //   ),
    //   onTap: () {
    //     Navigator.push(
    //       context,
    //       MaterialPageRoute(
    //         builder: (context) => ExercisePage(
    //           exerciseModel: exerciseModel,
    //         ),
    //       ),
    //     );
    //   },
    // );
  }
}
