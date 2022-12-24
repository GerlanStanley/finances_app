import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../../domain/entities/entities.dart';
import '../../blocs/financial_asset/financial_asset.dart';
import '../../blocs/variation/variation.dart';
import '../../widgets/widgets.dart';

import 'components/components.dart';

class VariationsTablePage extends StatefulWidget {
  const VariationsTablePage({Key? key}) : super(key: key);

  @override
  State<VariationsTablePage> createState() => _VariationsTablePageState();
}

class _VariationsTablePageState extends State<VariationsTablePage> {
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
                  int index = 0;

                  return Column(
                    children: [
                      FinancialAssetDataComponent(
                        financialAsset:
                            financialAssetBloc.selectedFinancialAsset!,
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 8, right: 8),
                        child: const TableHeaderComponent(),
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Container(
                            margin: const EdgeInsets.only(
                              left: 8,
                              right: 8,
                              bottom: 16,
                            ),
                            child: Column(
                              children: state.variations.map((element) {
                                index++;
                                return TableItemComponent(
                                  index: index,
                                  last: index == state.variations.length,
                                  variation: element,
                                  previousVariation: index != 1
                                      ? state.variations[index - 2]
                                      : null,
                                  firstVariation:
                                      index != 1 ? state.variations[0] : null,
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ),
                    ],
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
