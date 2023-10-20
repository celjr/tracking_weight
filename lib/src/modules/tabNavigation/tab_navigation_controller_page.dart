import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tracking_weight/src/core/widgets/add_weight_widget.dart';
import 'package:tracking_weight/src/modules/home/page/home_page.dart';
import 'package:tracking_weight/src/modules/weight/page/weight_history_page.dart';
import 'package:tracking_weight/src/modules/weight/stores/weight_store.dart';

class TabNavigationController extends StatefulWidget {
  const TabNavigationController({super.key});

  @override
  State<TabNavigationController> createState() =>
      _TabNavigationControllerState();
}

class _TabNavigationControllerState extends State<TabNavigationController> {
  final List<Widget> _pages = [
    const HomePage(title: ''),
    const WeightHistoryPage(),
  ];

  int currentIndex = 0;

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
    // final state = store.value;
    // late Widget child;
    // if (state is LoadingWeightState) {
    //   child = const Center(
    //     child: CircularProgressIndicator(),
    //   );
    // } else if (state is ErrorWeightState) {
    //   child = Center(
    //     child: Text(state.message),
    //   );
    // } else if (state is SuccessWeightState) {
    //   if (state.weights.isEmpty) {
    //     child = const Center(
    //       child: Text('Você ainda não tem nenhum peso cadastrado'),
    //     );
    //   } else {
    //     child = ListView.builder(
    //       itemCount: state.weights.length,
    //       itemBuilder: (context, index) => Row(
    //         children: [
    //           const Icon(Icons.monitor_weight),
    //           Text(state.weights[index].weight.toStringAsFixed(2)),
    //           Expanded(child: Text(state.weights[index].date.toString())),
    //         ],
    //       ),
    //     );
    //   }
    // } else {
    //   child = Container();
    // }

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: _pages[currentIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (value) => changePage(value),
          items: const [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.home_rounded,
                  size: 40,
                ),
                label: 'home'),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.calendar_month_rounded,
                  size: 40,
                ),
                label: 'acompanhamento')
          ]),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          showDialog(context: context, builder: (context) => AddWeightWidget())
              .then((value) => store.saveWeights(value));
        },
      ),
    );
  }

  void changePage(int index) {
    setState(() {
      currentIndex = index;
    });
  }
}
