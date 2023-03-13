import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class WeightModel {
  final double weight;
  final DateTime date;
  WeightModel({
    required this.weight,
    required this.date,
  });


  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'weight': weight,
      'date': date.millisecondsSinceEpoch,
    };
  }

  factory WeightModel.fromMap(Map<String, dynamic> map) {
    return WeightModel(
      weight: map['weight'] as double,
      date: DateTime.fromMillisecondsSinceEpoch(map['date'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory WeightModel.fromJson(String source) => WeightModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
