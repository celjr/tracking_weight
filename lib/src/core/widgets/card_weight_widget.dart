import 'package:flutter/material.dart';
import 'package:tracking_weight/src/core/utils/formatter_adapter.dart';
import 'package:tracking_weight/src/modules/weight/models/weight_model.dart';


class CardWeightWidget extends StatelessWidget {
  const CardWeightWidget({super.key, required this.weight, required this.onPressedDelete});
  final WeightModel weight;
  final VoidCallback onPressedDelete;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.sizeOf(context).width;
    return Container(
      width: screenWidth,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(screenWidth * 0.02),
          boxShadow: const [
            BoxShadow(blurRadius: 1, spreadRadius: 1, color: Colors.grey)
          ]),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          textBaseline: TextBaseline.alphabetic,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.baseline,
          children: [
            Text(
              '${weight.weight.toStringAsFixed(2)} Kg',
              style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 24),
            ),
            Text(FormatterAdapter.dateFormater(weight.date),
                style: TextStyle(
                    color: Theme.of(context).hintColor,
                    fontWeight: FontWeight.w400,
                    fontSize: 16)),
            GestureDetector(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          title: const Text('Deletar registro'),
                          content: const Text(
                              'Tem certeza que deseja deletar o resgitro?'),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text('Cancelar')),
                            ElevatedButton(
                                onPressed: onPressedDelete,
                                child: const Text('Sim')),
                          ],
                        ));
              },
              child: const Icon(
                Icons.delete,
                color: Colors.red,
              ),
            )
          ],
        ),
      ),
    );
  }
}
