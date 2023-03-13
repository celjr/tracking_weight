import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tracking_weight/src/core/app_routes.dart';
import 'package:tracking_weight/src/core/widgets/add_weight_widget.dart';
import 'package:tracking_weight/src/modules/weight/states/weight_state.dart';
import 'package:tracking_weight/src/modules/weight/stores/weight_store.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

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
    } else if (state is ErrorWeightState) {
      child = Center(
        child: Text(state.message),
      );
    } else if (state is SuccessWeightState) {
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
    } else {
      child = Container();
    }

    return child;
  }
}
