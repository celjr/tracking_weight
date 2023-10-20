import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tracking_weight/src/modules/weight/models/weight_model.dart';

class AddWeightWidget extends StatelessWidget {
  AddWeightWidget({super.key});
  final TextEditingController weightTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var widthScreen = MediaQuery.of(context).size.width;
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Row(
               children: [
                 Text(
                  'Adicione seu peso atual (kg):',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
            ),
               ],
             ),
            SizedBox(height: widthScreen * 0.05),
            TextFormField(
              controller:weightTextController ,
              keyboardType: TextInputType.number,
              inputFormatters: [
                LengthLimitingTextInputFormatter(7),
              ],
              decoration: const InputDecoration(
                  suffixText: 'Kg', border: OutlineInputBorder()),
            ),
            SizedBox(height: widthScreen * 0.05),
            ElevatedButton(
                onPressed: () {
                  if(weightTextController.text.isNotEmpty){
                     var weight = WeightModel(weight: double.parse(weightTextController.text) , date: DateTime.now());
                    Navigator.pop(context,weight) ;
                  }
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.save),
                    SizedBox(width: widthScreen * 0.02),
                    const Text('Adicionar',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w700))
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
