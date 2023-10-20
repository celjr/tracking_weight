import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tracking_weight/src/core/widgets/card_weight_widget.dart';
import 'package:tracking_weight/src/core/widgets/weight_chart_widget.dart';
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
            itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CardWeightWidget(
                    weight: state.weights[index],
                    onPressedDelete: () {
                      store.removeWeights(state.weights[index]);
                      Navigator.pop(context);
                    },
                  ),
                ));
      }
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: Row(
            children: [
              Text(
                'Historico:',
                style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 32,
                    fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              IconButton(
                  onPressed: () {
                    store.saveHistoryInFile();
                  },
                  icon: const Icon(Icons.save))
            ],
          ),
        ),
        SizedBox(height: MediaQuery.sizeOf(context).width * 0.9, child: child),
        SizedBox(height: MediaQuery.sizeOf(context).width * 0.05),
        SizedBox(
            height: MediaQuery.sizeOf(context).width * 0.5,
            width: MediaQuery.sizeOf(context).width * 0.9,
            child: WeightChartWidget(weights: state.weights))
      ],
    );
  }
}
