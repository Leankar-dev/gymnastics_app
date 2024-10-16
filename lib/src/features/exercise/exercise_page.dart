import 'package:flutter/material.dart';
import 'package:gymnastics_app/core/ui/styles/gymnastics_app_colors.dart';
import 'package:gymnastics_app/src/models/exercise_model.dart';
import 'package:gymnastics_app/src/models/feeling_model.dart';

class ExercisePage extends StatelessWidget {
  ExercisePage({super.key});

  // criar instancias dos models criados
  final ExerciseModel exerciseModel = ExerciseModel(
    id: '001',
    name: 'Remada Baixa Supinada',
    training: 'Treino A',
    howTodo: 'Segura com as duas mãos na barra, mantem a coluna reta...',
  );

  final List<FeelingModel> listFeeling = [
    FeelingModel(
      id: 'SE001',
      feeling: 'Pouca Ativação',
      date: '14/10/2024',
    ),
    FeelingModel(
      id: 'SE002',
      feeling: 'Senti alguma ativação',
      date: '15/10/2024',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        title: Column(
          children: [
            Text(
              exerciseModel.name,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
            Text(
              exerciseModel.training,
              style: const TextStyle(fontSize: 15),
            ),
          ],
        ),
        centerTitle: true,
        backgroundColor: GymnasticsAppColors.blueColorMedium,
        elevation: 0,
        toolbarHeight: 72,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(
              32,
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.sports_gymnastics),
      ),
      body: Container(
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: ListView(
          children: [
            SizedBox(
              height: 250,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text('Enviar Foto'),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text('Tirar Foto'),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Como fazer?',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            Text(
              exerciseModel.howTodo,
              style: const TextStyle(),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Divider(
                color: Colors.black,
              ),
            ),
            const Text(
              'Como estou me sentindo?',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(
                listFeeling.length,
                (index) {
                  FeelingModel feelingNow = listFeeling[index];
                  return ListTile(
                    dense: true,
                    contentPadding: EdgeInsets.zero,
                    title: Text(feelingNow.feeling),
                    subtitle: Text(feelingNow.date),
                    leading: const Icon(Icons.double_arrow),
                    trailing: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.delete_forever_outlined,
                        color: Colors.red,
                      ),
                    ),
                  );
                },
              ),
            ),
            const Divider(),
          ],
        ),
      ),
    );
  }
}
