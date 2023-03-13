// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:tracking_weight/src/modules/weight/models/weight_model.dart';

abstract class WeightState {}

class InitialWeightState extends WeightState {}

class SuccessWeightState extends WeightState {
  final List<WeightModel> weights;
  SuccessWeightState({
    required this.weights,
  });
}

class LoadingWeightState extends WeightState {}

class ErrorWeightState extends WeightState {
  final String message;
  ErrorWeightState({
    required this.message,
  });
}
