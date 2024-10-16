// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class FeelingModel {
  final String id;
  final String feeling;
  final String date;

  FeelingModel({
    required this.id,
    required this.feeling,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'feeling': feeling,
      'date': date,
    };
  }

  factory FeelingModel.fromMap(Map<String, dynamic> map) {
    return FeelingModel(
      id: map['id'] as String,
      feeling: map['feeling'] as String,
      date: map['date'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory FeelingModel.fromJson(String source) =>
      FeelingModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
