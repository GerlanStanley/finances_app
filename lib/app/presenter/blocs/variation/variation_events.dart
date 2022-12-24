import 'package:equatable/equatable.dart';

abstract class VariationEvent extends Equatable {
  const VariationEvent();
}

class GetAllVariationsEvent extends VariationEvent {
  final String symbol;

  const GetAllVariationsEvent({required this.symbol});

  @override
  List<Object> get props => [symbol];
}
