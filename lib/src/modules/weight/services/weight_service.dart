// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tracking_weight/src/modules/weight/models/weight_model.dart';

class WeightService {
  WeightService();

  Future<List<WeightModel>> fetchWeights() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final result = sharedPreferences.getStringList('weights');
    if (result == null) {
      return [];
    } else {
      return result.map((e) => WeightModel.fromJson(e)).toList();
    }
  }

  Future<bool> saveWeights({required List<WeightModel> weights}) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.containsKey('weights')) {
      await sharedPreferences.remove('weights');
    }
    return await sharedPreferences.setStringList(
        'weights', weights.map((e) => e.toJson()).toList());
  }
}
