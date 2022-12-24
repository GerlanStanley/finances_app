import 'package:flutter/material.dart';

import 'app/presenter/pages/variations_table/variations_table_page.dart';
import 'core/constants/constants.dart';
import 'core/inject/inject.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Inject.initialize();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Finances App",
      theme: ThemeConstants.dark,
      initialRoute: RoutesConstants.table,
      routes: {
        RoutesConstants.table: (context) => const VariationsTablePage(),
        RoutesConstants.chart: (context) => const VariationsTablePage(),
      },
    );
  }
}
