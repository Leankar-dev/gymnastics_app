import 'package:flutter/material.dart';
import 'package:gymnastics_app/core/services/firebase/firebase_store/firebase_store_service.dart';
import 'package:gymnastics_app/core/ui/styles/gymnastics_app_colors.dart';
import 'package:gymnastics_app/core/ui/widgets/gymnastics_textform_field_widget.dart';
import 'package:gymnastics_app/src/models/exercise_model.dart';
import 'package:gymnastics_app/src/models/feeling_model.dart';
import 'package:uuid/uuid.dart';

class ExerciseModal extends StatefulWidget {
  final ExerciseModel? exerciseModel;
  const ExerciseModal({
    super.key,
    this.exerciseModel,
  });

  @override
  State<ExerciseModal> createState() => _ExerciseModalState();
}

class _ExerciseModalState extends State<ExerciseModal> {
  final _nameEC = TextEditingController();
  final _trainigEC = TextEditingController();
  final _annotationEC = TextEditingController();
  final _feelingEC = TextEditingController();
  bool isLoading = false;

  final ExerciseService _exerciseService = ExerciseService();

  @override
  void dispose() {
    _nameEC.dispose();
    _trainigEC.dispose();
    _annotationEC.dispose();
    _feelingEC.dispose();
    super.dispose();
  }

  @override
  void initState() {
    if (widget.exerciseModel != null) {
      _nameEC.text = widget.exerciseModel!.name;
      _trainigEC.text = widget.exerciseModel!.training;
      _annotationEC.text = widget.exerciseModel!.howTodo;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      height: MediaQuery.of(context).size.height * 0.9,
      child: Form(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                        (widget.exerciseModel != null)
                            ? 'Editar ${widget.exerciseModel!.name}'
                            : '     Adicionar Exercicio',
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: GymnasticsAppColors.whiteColor,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.close,
                        color: GymnasticsAppColors.whiteColor,
                      ),
                    ),
                  ],
                ),
                const Divider(),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 16),
                    GymnasticsTextformFieldWidget(
                      controller: _nameEC,
                      label: 'Qual o nome do exercicio?',
                      icon: const Icon(
                        Icons.abc,
                        color: GymnasticsAppColors.whiteColor,
                      ),
                    ),
                    const SizedBox(height: 16),
                    GymnasticsTextformFieldWidget(
                      controller: _trainigEC,
                      label: 'Qual treino pertence?',
                      icon: const Icon(
                        Icons.list_alt_rounded,
                        color: GymnasticsAppColors.whiteColor,
                      ),
                    ),
                    const SizedBox(height: 16),
                    GymnasticsTextformFieldWidget(
                      controller: _annotationEC,
                      label: 'Quais anotações tem?',
                      icon: const Icon(
                        Icons.notes_rounded,
                        color: GymnasticsAppColors.whiteColor,
                      ),
                    ),
                    Visibility(
                      visible: (widget.exerciseModel == null),
                      child: Column(
                        children: [
                          const SizedBox(height: 16),
                          GymnasticsTextformFieldWidget(
                            controller: _feelingEC,
                            label: 'Como está se sentindo?',
                            icon: const Icon(
                              Icons.emoji_emotions_rounded,
                              color: GymnasticsAppColors.whiteColor,
                            ),
                          ),
                          const Text(
                            'Este campo não é obrigatório o preenchimento.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: GymnasticsAppColors.whiteColor,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // const SizedBox(height: 16),
                  ],
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                sendClicked();
              },
              child: (isLoading)
                  ? const SizedBox(
                      height: 16,
                      width: 16,
                      child: CircularProgressIndicator(
                        color: GymnasticsAppColors.blueColorMedium,
                      ),
                    )
                  : Text(
                      (widget.exerciseModel != null)
                          ? 'Editar Exercício'
                          : 'Criar Exercício',
                    ),
            ),
          ],
        ),
      ),
    );
  }

  void sendClicked() {
    setState(() {
      isLoading = true;
    });
    // pegar os dados que estão  nos controladores
    String name = _nameEC.text;
    String training = _trainigEC.text;
    String annotation = _annotationEC.text;
    String feeling = _feelingEC.text;

    // criar exercicios á partir desses dados
    ExerciseModel exercise = ExerciseModel(
      // para gerar id  usar o pacote uuid
      id: const Uuid().v1(),
      name: name,
      training: training,
      howTodo: annotation,
    );

    if (widget.exerciseModel != null) {
      exercise.id = widget.exerciseModel!.id;
    }

    _exerciseService.addExercise(exercise).then(
      (value) {
        if (feeling != '') {
          FeelingModel feelingModel = FeelingModel(
            id: const Uuid().v1(),
            feeling: feeling,
            date: DateTime.now().toString(),
          );
          _exerciseService.addFeeling(exercise.id, feelingModel).then(
            (value) {
              setState(() {
                isLoading = false;
              });
              // para fechar o modal
              Navigator.pop(context);
            },
          );
        } else {
          Navigator.pop(context);
        }
      },
    );
  }
}
