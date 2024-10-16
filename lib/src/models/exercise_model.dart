// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ExerciseModel {
  final String id;
  final String name;
  final String training;
  final String howTodo;
  final String? urlImage;

  ExerciseModel({
    required this.id,
    required this.name,
    required this.training,
    required this.howTodo,
    this.urlImage,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'training': training,
      'howTodo': howTodo,
      'urlImage': urlImage,
    };
  }

  factory ExerciseModel.fromMap(Map<String, dynamic> map) {
    return ExerciseModel(
      id: map['id'] as String,
      name: map['name'] as String,
      training: map['training'] as String,
      howTodo: map['howTodo'] as String,
      urlImage: map['urlImage'] != null ? map['urlImage'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ExerciseModel.fromJson(String source) =>
      ExerciseModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
