import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../blocs/financial_asset/financial_asset.dart';
import '../../blocs/variation/variation.dart';
import '../../widgets/widgets.dart';

import 'components/components.dart';

class VariationsChartPage extends StatefulWidget {
  const VariationsChartPage({Key? key}) : super(key: key);

  @override
  State<VariationsChartPage> createState() => _VariationsChartPageState();
}

class _VariationsChartPageState extends State<VariationsChartPage> {
  var financialAssetBloc = GetIt.I<FinancialAssetBloc>();
  var variationBloc = GetIt.I<VariationBloc>();

  final TextEditingController textEditingController = TextEditingController();
  final FocusNode focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.fromLTRB(8, 24, 8, 16),
            child: FinancialAssetAutoCompleteTextField(
              focusNode: focusNode,
              textEditingController: textEditingController,
              financialAssetBloc: financialAssetBloc,
              variationBloc: variationBloc,
            ),
          ),
          Expanded(
            child: BlocBuilder(
              bloc: variationBloc,
              builder: (context, state) {
                if (state is LoadingVariationState) {
                  return const LoadWidget();
                } else if (state is FailureVariationState) {
                  return FailureWidget(
                    message: state.error,
                    onPressed: () => variationBloc.add(
                      GetAllVariationsEvent(symbol: textEditingController.text),
                    ),
                  );
                } else if (state is SuccessVariationState) {
                  return SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        FinancialAssetDataComponent(
                          financialAsset:
                              financialAssetBloc.selectedFinancialAsset!,
                        ),
                        Container(
                          height: 400,
                          padding: const EdgeInsets.only(right: 20),
                          child: ChartComponent(variations: state.variations),
                        ),
                      ],
                    ),
                  );
                }
                return Container();
              },
            ),
          ),
        ],
      ),
    );
  }
}
