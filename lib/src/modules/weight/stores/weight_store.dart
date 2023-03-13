import 'package:flutter/widgets.dart';
import 'package:tracking_weight/src/modules/weight/models/weight_model.dart';
import 'package:tracking_weight/src/modules/weight/services/weight_service.dart';
import 'package:tracking_weight/src/modules/weight/states/weight_state.dart';

class WeightStore extends ValueNotifier<WeightState>{
  final WeightService weightService;
  WeightStore(this.weightService):super(InitialWeightState());

   fetchWeights() async {
    value = LoadingWeightState();
    try{
      final weights = await weightService.fetchWeights();
      value = SuccessWeightState(weights: weights);
    }catch(e){
      value = ErrorWeightState(message: e.toString());
    }
  }



}