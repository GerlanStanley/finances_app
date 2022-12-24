import 'package:flutter/material.dart';

import '../../domain/entities/entities.dart';

class FinancialAssetDataComponent extends StatelessWidget {
  final FinancialAssetEntity financialAsset;

  const FinancialAssetDataComponent({
    Key? key,
    required this.financialAsset,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20, left: 8, right: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            "Nome: ${financialAsset.longName ?? ""}",
            style: Theme.of(context).textTheme.subtitle2,
          ),
          Container(
            padding: const EdgeInsets.only(top: 4),
            child: Text(
              "Indústria: ${financialAsset.industry ?? ""}",
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
          Container(
            padding: const EdgeInsets.only(top: 4),
            child: Text(
              "Setor: ${financialAsset.sector ?? ""}",
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
        ],
      ),
    );
  }
}
