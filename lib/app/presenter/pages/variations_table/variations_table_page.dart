import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../blocs/financial_asset/financial_asset.dart';
import '../../blocs/variation/variation.dart';
import '../../widgets/widgets.dart';

class VariationsTablePage extends StatefulWidget {
  const VariationsTablePage({Key? key}) : super(key: key);

  @override
  State<VariationsTablePage> createState() => _VariationsTablePageState();
}

class _VariationsTablePageState extends State<VariationsTablePage> {
  var financialAssetBloc = GetIt.I<FinancialAssetBloc>();
  var variationBloc = GetIt.I<VariationBloc>();

  final FocusNode focusNode = FocusNode();
  final TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.fromLTRB(16, 24, 16, 16),
            child: FinancialAssetAutoCompleteTextField(
              focusNode: focusNode,
              textEditingController: textEditingController,
              financialAssetBloc: financialAssetBloc,
              variationBloc: variationBloc,
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
