import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tracking_weight/src/modules/weight/states/weight_state.dart';
import 'package:tracking_weight/src/modules/weight/stores/weight_store.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  


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
        var currentWeight = state.weights.last;
        child = Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                textBaseline: TextBaseline.alphabetic,
                crossAxisAlignment: CrossAxisAlignment.baseline,
                children: [
                  Text(
                    'Seu peso',
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 32,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width * 0.02,
                  ),
                  Text(
                    '(Ultima atualização: ${currentWeight.date.day}/${currentWeight.date.month}/${currentWeight.date.year})',
                    style: TextStyle(
                        fontSize: 10, color: Theme.of(context).hintColor),
                  ),
                ],
              ),
              Row(
                textBaseline: TextBaseline.alphabetic,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.baseline,
                children: [
                  Text(
                    currentWeight.weight.toString(),
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 80,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width * 0.02,
                  ),
                  Text(
                    'Kg',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 44,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
        // ListView.builder(
        //   itemCount: state.weights.length,
        //   itemBuilder: (context, index) => Row(
        //     children: [
        //       const Icon(Icons.monitor_weight),
        //       Text(state.weights[index].weight.toStringAsFixed(2)),
        //       Expanded(child: Text(state.weights[index].date.toString())),
        //     ],
        //   ),
        // );
      }
    } else {
      child = Container();
    }

    return child;
  }
}
