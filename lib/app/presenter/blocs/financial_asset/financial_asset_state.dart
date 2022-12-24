import 'package:equatable/equatable.dart';

import '../../../domain/entities/entities.dart';

abstract class FinancialAssetState extends Equatable {
  const FinancialAssetState();
}

class InitialFinancialAssetState extends FinancialAssetState {
  @override
  List<Object> get props => [];
}

class LoadingFinancialAssetState extends FinancialAssetState {
  @override
  List<Object> get props => [];
}

class SuccessFinancialAssetState extends FinancialAssetState {
  final List<FinancialAssetEntity> platforms;

  const SuccessFinancialAssetState({
    required this.platforms,
  });

  @override
  List<Object> get props => [];
}

class FailureFinancialAssetState extends FinancialAssetState {
  final String error;

  const FailureFinancialAssetState({required this.error});

  @override
  List<Object> get props => [error];
}
