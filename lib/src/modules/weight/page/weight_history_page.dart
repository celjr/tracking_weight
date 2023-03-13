import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tracking_weight/src/core/app_routes.dart';
import 'package:tracking_weight/src/modules/weight/states/weight_state.dart';
import 'package:tracking_weight/src/modules/weight/stores/weight_store.dart';

class WeightHistoryPage extends StatefulWidget {
  const WeightHistoryPage({super.key});

  @override
  State<WeightHistoryPage> createState() => _WeightHistoryPageState();
}

class _WeightHistoryPageState extends State<WeightHistoryPage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<WeightStore>().fetchWeights();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final store = context.watch<WeightStore>();
    final state = store.value;
    late Widget child;
    if (state is LoadingWeightState) {
      child = const Center(
        child: CircularProgressIndicator(),
      );
    }
    if (state is ErrorWeightState) {
      child = Center(
        child: Text(state.message),
      );
    }
    if (state is SuccessWeightState) {
      if (state.weights.isEmpty) {
        child = const Center(
          child: Text('Você ainda não tem nenhum peso cadastrado'),
        );
      } else {
        child = ListView.builder(
          itemCount: state.weights.length,
          itemBuilder: (context, index) => Row(
            children: [
              const Icon(Icons.monitor_weight),
              Text(state.weights[index].weight.toStringAsFixed(2)),
              Expanded(child: Text(state.weights[index].date.toString())),
            ],
          ),
        );
      }
    }
    return  child;
     
  }
}
