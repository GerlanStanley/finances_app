import 'package:flutter/material.dart';

import 'core/constants/constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Game Lovers App",
      theme: ThemeConstants.dark,
      home: Container(),
    );
  }
}
