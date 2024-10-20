import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gymnastics_app/core/modals/show_init_modal.dart';
import 'package:gymnastics_app/core/services/firebase/firebase_auth/auth_service.dart';
import 'package:gymnastics_app/core/services/firebase/firebase_store/firebase_store_service.dart';
import 'package:gymnastics_app/core/ui/styles/gymnastics_app_colors.dart';
import 'package:gymnastics_app/core/ui/widgets/gymnastics_init_list_widget.dart';
import 'package:gymnastics_app/src/models/exercise_model.dart';

class HomePage extends StatefulWidget {
  final User user;
  const HomePage({
    super.key,
    required this.user,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ExerciseService service = ExerciseService();
  bool isDecrescent = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GymnasticsAppColors.blueColor,
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: const Center(child: Text('Meus Exercícios')),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                isDecrescent = !isDecrescent;
              });
            },
            icon: const Icon(Icons.sort_by_alpha_rounded),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: const CircleAvatar(
                backgroundImage: AssetImage('assets/logo.png'),
              ),
              accountName: Text((widget.user.displayName != null)
                  ? widget.user.displayName!
                  : ''),
              accountEmail: Text(widget.user.email!),
            ),
            ListTile(
              title: const Text(
                'Deslogar',
              ),
              leading: const Icon(Icons.logout),
              onTap: () {
                AuthService().logout();
              },
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showInitModal(context);
        },
        child: const Icon(Icons.post_add_outlined),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: StreamBuilder(
          stream: service.connectStreamExercise(isDecrescent),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              if (snapshot.hasData &&
                  snapshot.data != null &&
                  snapshot.data!.docs.isNotEmpty) {
                List<ExerciseModel> listExercises = [];

                for (var doc in snapshot.data!.docs) {
                  listExercises.add(ExerciseModel.fromMap(doc.data()));
                }
                return ListView(
                  children: List.generate(
                    listExercises.length,
                    (index) {
                      ExerciseModel exerciseModel = listExercises[index];
                      return GymnasticsInitListWidget(
                        exerciseModel: exerciseModel,
                        service: service,
                      );
                    },
                  ),
                );
              } else {
                return const Center(
                  child:
                      Text('Ainda não possui exercicios. \n Vamos adicionar?'),
                );
              }
            }
          },
        ),
      ),
    );
  }
}
