import 'package:equatable/equatable.dart';

import '../../../domain/entities/entities.dart';

abstract class VariationState extends Equatable {
  const VariationState();
}

class InitialVariationState extends VariationState {
  @override
  List<Object> get props => [];
}

class LoadingVariationState extends VariationState {
  @override
  List<Object> get props => [];
}

class SuccessVariationState extends VariationState {
  final List<VariationEntity> variations;

  const SuccessVariationState({
    required this.variations,
  });

  @override
  List<Object> get props => [];
}

class FailureVariationState extends VariationState {
  final String error;

  const FailureVariationState({required this.error});

  @override
  List<Object> get props => [error];
}
