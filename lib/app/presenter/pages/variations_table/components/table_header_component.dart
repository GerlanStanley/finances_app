import 'package:flutter/material.dart';

import '../../../../../core/constants/constants.dart';

class TableHeaderComponent extends StatelessWidget {
  const TableHeaderComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: ColorsConstants.divider, width: 1),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(4),
          topRight: Radius.circular(4),
        ),
      ),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 1,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 8),
                decoration: const BoxDecoration(
                  border: Border(
                    right: BorderSide(color: ColorsConstants.divider, width: 1),
                  ),
                ),
                child: Center(
                  child: Text(
                    "Dia",
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 8),
                decoration: const BoxDecoration(
                  border: Border(
                    right: BorderSide(color: ColorsConstants.divider, width: 1),
                  ),
                ),
                child: Center(
                  child: Text(
                    "Data",
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 8),
                decoration: const BoxDecoration(
                  border: Border(
                    right: BorderSide(color: ColorsConstants.divider, width: 1),
                  ),
                ),
                child: Center(
                  child: Text(
                    "Valor",
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 8),
                decoration: const BoxDecoration(
                  border: Border(
                    right: BorderSide(color: ColorsConstants.divider, width: 1),
                  ),
                ),
                child: Center(
                  child: Text(
                    "D-1",
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Center(
                child: Text(
                  "1º D",
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
