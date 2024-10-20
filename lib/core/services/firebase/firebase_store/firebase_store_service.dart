// para usar o Firebase Cloud Firestore
// user no modal (showInitModal)

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gymnastics_app/src/models/exercise_model.dart';
import 'package:gymnastics_app/src/models/feeling_model.dart';

class ExerciseService {
  String userId;
  ExerciseService() : userId = FirebaseAuth.instance.currentUser!.uid;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addExercise(ExerciseModel exerciseModel) async {
    await _firestore
        .collection(userId)
        .doc(exerciseModel.id)
        .set(exerciseModel.toMap());
  }

  Future<void> addFeeling(String idExercise, FeelingModel feelingModel) async {
    await _firestore
        .collection(userId)
        .doc(idExercise)
        .collection('Feeling')
        .doc(feelingModel.id)
        .set(feelingModel.toMap());
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> connectStreamExercise(
      bool isDecrescent) {
    return _firestore
        .collection(userId)
        .orderBy('training', descending: isDecrescent)
        .snapshots();
  }

  Future<void> removeExercise({required String idExercise}) {
    return _firestore.collection(userId).doc(idExercise).delete();
  }
}
