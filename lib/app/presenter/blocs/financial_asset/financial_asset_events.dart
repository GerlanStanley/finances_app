import 'package:equatable/equatable.dart';

abstract class FinancialAssetEvent extends Equatable {
  const FinancialAssetEvent();
}

class SearchFinancialAssetsEvent extends FinancialAssetEvent {
  final String text;

  const SearchFinancialAssetsEvent({required this.text});

  @override
  List<Object> get props => [text];
}
