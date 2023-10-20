import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:path_provider/path_provider.dart';

import 'package:tracking_weight/src/modules/weight/models/weight_model.dart';
import 'package:tracking_weight/src/modules/weight/services/weight_service.dart';
import 'package:tracking_weight/src/modules/weight/states/weight_state.dart';

class WeightStore extends ValueNotifier<WeightState> {
  final WeightService weightService;
  WeightStore(this.weightService) : super(InitialWeightState());

  fetchWeights() async {
    value = value.loading();
    try {
      final weights = await weightService.fetchWeights();
      value = value.success(weights: weights);
    } catch (e) {
      value = value.error(message: e.toString());
    }
  }

  saveWeights(WeightModel weight) async {
    value = value.loading();

    try {
      value.weights.add(weight);
      final result = await weightService.saveWeights(weights: value.weights);
      if (result) {
        value = value.success(weights: value.weights);
      } else {
        throw ('Não foi possivel salvar');
      }
    } catch (e) {
      value = value.error(message: e.toString());
    }
  }

  removeWeights(WeightModel weight) async {
    value = value.loading();

    try {
      value.weights.remove(weight);
      final result = await weightService.saveWeights(weights: value.weights);
      if (result) {
        value = value.success(weights: value.weights);
      } else {
        throw ('Não foi possivel salvar');
      }
    } catch (e) {
      value = value.error(message: e.toString());
    }
  }

  saveHistoryInFile() async {
    final file = await _localFile;
    print(file.path);
    // Write the file
    return file.writeAsString(value.weights.map((e) => e.toJson()).toString());
  }

  Future<String> get _localPath async {
    final directory = await getExternalStorageDirectory();
    print(directory!.path);
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;

    return File('$path/track_wight_history.txt');
  }

  sendBackUp() async {
   
  }
}
