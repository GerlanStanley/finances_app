import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

import '../../domain/entities/entities.dart';

import '../blocs/financial_asset/financial_asset.dart';

class FinancialAssetAutoCompleteTextField extends StatelessWidget {
  final FinancialAssetBloc financialAssetBloc;

  const FinancialAssetAutoCompleteTextField({
    Key? key,
    required this.financialAssetBloc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TypeAheadField<FinancialAssetEntity>(
      textFieldConfiguration: TextFieldConfiguration(
        autofocus: true,
        style: DefaultTextStyle.of(context)
            .style
            .copyWith(fontStyle: FontStyle.italic),
        decoration: const InputDecoration(border: OutlineInputBorder()),
      ),
      suggestionsCallback: (text) async {
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
          subtitle: Text('\$${suggestion.longName}'),
        );
      },
      onSuggestionSelected: (suggestion) {},
    );
  }
}
