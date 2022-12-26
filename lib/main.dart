import 'package:flutter/material.dart';

import 'app/presenter/pages/home/home_page.dart';
import 'core/constants/constants.dart';
import 'core/inject/inject.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Inject.initialize();

  runApp(MaterialApp(
    title: "Finances App",
    theme: ThemeConstants.dark,
    home: const HomePage(),
  ));
}
