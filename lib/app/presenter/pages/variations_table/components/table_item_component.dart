import 'package:flutter/material.dart';

import '../../../../../core/constants/constants.dart';
import '../../../../../core/utils/utils.dart';

import '../../../../domain/entities/entities.dart';

class TableItemComponent extends StatelessWidget {
  final int index;
  final bool last;
  final VariationEntity variation;
  final VariationEntity? previousVariation;
  final VariationEntity? firstVariation;

  const TableItemComponent({
    Key? key,
    required this.index,
    required this.last,
    required this.variation,
    required this.previousVariation,
    required this.firstVariation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColorsConstants.divider,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(last ? 4 : 0),
          bottomRight: Radius.circular(last ? 4 : 0),
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: ColorsConstants.background,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(last ? 4 : 0),
            bottomRight: Radius.circular(last ? 4 : 0),
          ),
        ),
        margin: const EdgeInsets.only(bottom: 1, left: 1, right: 1),
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
                      right:
                          BorderSide(color: ColorsConstants.divider, width: 1),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      index.toString(),
                      style: Theme.of(context).textTheme.bodyText2,
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
                      right:
                          BorderSide(color: ColorsConstants.divider, width: 1),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      DateTimeUtils.formattedDate(variation.date),
                      style: Theme.of(context).textTheme.bodyText2,
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
                      right:
                          BorderSide(color: ColorsConstants.divider, width: 1),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      PriceUtils.convert(variation.value),
                      style: Theme.of(context).textTheme.bodyText2,
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
                      right: BorderSide(
                        color: ColorsConstants.divider,
                        width: 1,
                      ),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      previousVariation != null
                          ? "${VariationPercentUtils.calculate(
                              previousVariation!.value,
                              variation.value,
                            ).toStringAsFixed(2)}%"
                          : "",
                      style: TextStyle(
                        fontSize:
                            Theme.of(context).textTheme.bodyText2!.fontSize,
                        fontWeight:
                            Theme.of(context).textTheme.bodyText2!.fontWeight,
                        color: previousVariation != null
                            ? VariationPercentUtils.calculate(
                                      previousVariation!.value,
                                      variation.value,
                                    ) >=
                                    0
                                ? ColorsConstants.success
                                : ColorsConstants.error
                            : null,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Center(
                  child: Text(
                    firstVariation != null
                        ? "${VariationPercentUtils.calculate(
                            firstVariation!.value,
                            variation.value,
                          ).toStringAsFixed(2)}%"
                        : "",
                    style: TextStyle(
                      fontSize: Theme.of(context).textTheme.bodyText2!.fontSize,
                      fontWeight:
                          Theme.of(context).textTheme.bodyText2!.fontWeight,
                      color: firstVariation != null
                          ? VariationPercentUtils.calculate(
                                    firstVariation!.value,
                                    variation.value,
                                  ) >=
                                  0
                              ? ColorsConstants.success
                              : ColorsConstants.error
                          : null,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
