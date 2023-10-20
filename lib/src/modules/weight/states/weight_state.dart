// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:tracking_weight/src/modules/weight/models/weight_model.dart';

abstract class WeightState {
  final List<WeightModel> weights;
  WeightState({
    required this.weights,
  });

  InitialWeightState init()=> InitialWeightState();

  SuccessWeightState success({required List<WeightModel> weights}) =>
      SuccessWeightState(weights: weights);

  LoadingWeightState loading() => LoadingWeightState(weights: weights);

  ErrorWeightState error({required String message}) =>
      ErrorWeightState(weights: weights, message: message);
}

class InitialWeightState extends WeightState {
  InitialWeightState() : super(weights: []);
}

class SuccessWeightState extends WeightState {
  SuccessWeightState({
    required super.weights,
  });
}

class LoadingWeightState extends WeightState {
  LoadingWeightState({required super.weights});
}

class ErrorWeightState extends WeightState {
  final String message;
  ErrorWeightState({required this.message, required super.weights});
}
