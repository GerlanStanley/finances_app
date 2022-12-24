import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

import '../../../core/constants/constants.dart';

import '../../domain/entities/entities.dart';

import '../blocs/financial_asset/financial_asset.dart';
import '../blocs/variation/variation.dart';

class FinancialAssetAutoCompleteTextField extends StatelessWidget {
  final FocusNode focusNode;
  final TextEditingController textEditingController;
  final FinancialAssetBloc financialAssetBloc;
  final VariationBloc variationBloc;

  const FinancialAssetAutoCompleteTextField({
    Key? key,
    required this.focusNode,
    required this.textEditingController,
    required this.financialAssetBloc,
    required this.variationBloc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: financialAssetBloc,
      builder: (context, state) {
        return TypeAheadField<FinancialAssetEntity>(
          textFieldConfiguration: TextFieldConfiguration(
            focusNode: focusNode,
            autofocus: false,
            controller: textEditingController,
            style: DefaultTextStyle.of(context)
                .style
                .copyWith(fontStyle: FontStyle.italic),
            decoration: InputDecoration(
              labelText: "Pesquisar ativo",
              labelStyle: TextStyle(
                fontSize: 16,
                color: state is FailureFinancialAssetState
                    ? ColorsConstants.error
                    : ColorsConstants.primary,
                fontWeight: FontWeight.w600,
              ),
              errorText:
                  state is FailureFinancialAssetState ? state.error : null,
              errorMaxLines: 2,
              errorStyle: const TextStyle(
                color: ColorsConstants.error,
                fontSize: 12,
              ),
              disabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: ColorsConstants.primary,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(4),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: state is FailureFinancialAssetState
                      ? ColorsConstants.error
                      : ColorsConstants.primary,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(4),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: state is FailureFinancialAssetState
                      ? ColorsConstants.error
                      : ColorsConstants.primary,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(4),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: ColorsConstants.error,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(4),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: ColorsConstants.error,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(4),
              ),
              contentPadding: const EdgeInsets.only(
                top: 17,
                bottom: 17,
                left: 16,
                right: 16,
              ),
            ),
          ),
          suggestionsCallback: (text) async {
            if (text.length < 3) {
              return [];
            }

            financialAssetBloc.add(SearchFinancialAssetsEvent(text: text));

            List<FinancialAssetEntity> results = [];
            await for (var state in financialAssetBloc.stream) {
              if (state is SuccessFinancialAssetState) {
                results = state.financialAssets;
                break;
              }

              if (state is FailureFinancialAssetState) {
                break;
              }
            }

            return results;
          },
          itemBuilder: (context, suggestion) {
            return ListTile(
              leading: const Icon(Icons.query_stats),
              title: Text(suggestion.symbol),
              subtitle: Text(suggestion.longName ?? ""),
            );
          },
          onSuggestionSelected: (suggestion) {
            textEditingController.text = suggestion.symbol;
            financialAssetBloc.selectedFinancialAsset = suggestion;
            variationBloc.add(GetAllVariationsEvent(symbol: suggestion.symbol));
          },
          noItemsFoundBuilder: (context) {
            return Container(
              padding: const EdgeInsets.all(12),
              child: Text(
                textEditingController.text.length < 3
                    ? "Digite pelo menos 3 caracteres"
                    : "Nenhum item encontrado",
                style: const TextStyle(
                  color: ColorsConstants.error,
                  fontSize: 16,
                ),
              ),
            );
          },
        );
      },
    );
  }
}
