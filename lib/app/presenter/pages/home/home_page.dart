import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/utils/utils.dart';

import '../variations_chart/variations_chart_page.dart';
import '../variations_table/variations_table_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const activityMethodChannel = MethodChannel(
    'platform_channel_events/activity',
  );

  @override
  void initState() {
    super.initState();
    _openActivity();
  }

  Future<void> _openActivity() async {
    try {
      final String result = await activityMethodChannel.invokeMethod("menu");

      if (mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
            result == RoutesConstants.table
                ? const VariationsTablePage()
                : const VariationsChartPage(),
          ),
        );
      }
    } catch (e) {
      printDebug("Erro ao abrir tela de menu: $e");
      _openActivity();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Container());
  }
}
