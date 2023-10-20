import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tracking_weight/src/modules/tabNavigation/tab_navigation_controller_page.dart';

import 'package:tracking_weight/src/modules/weight/services/weight_service.dart';
import 'package:tracking_weight/src/modules/weight/stores/weight_store.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (context)=> WeightService()),
        ChangeNotifierProvider(create: (context)=>WeightStore(context.read()))
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          useMaterial3: true,
          colorSchemeSeed:  Colors.grey,
          
        ),
        home: TabNavigationController(),
        // routes: {
        //   AppRoutes.home():(context) => const HomePage(title: 'Home'),
        //   AppRoutes.weightHistory():(context) => const WeightHistoryPage()
        // },
        // initialRoute: '/',
      ),
    );
  }
}