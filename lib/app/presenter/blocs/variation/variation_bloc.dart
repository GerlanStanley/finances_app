import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/dtos/dtos.dart';
import '../../../domain/use_cases/use_cases.dart';

import 'variation.dart';

class VariationBloc extends Bloc<VariationEvent, VariationState> {
  final GetAllVariationsUseCase _getAllVariationsUseCase;

  VariationBloc(this._getAllVariationsUseCase)
      : super(InitialVariationState()) {
    //
    on<GetAllVariationsEvent>(_onGetAll);
  }

  Future<void> _onGetAll(
    GetAllVariationsEvent event,
    Emitter<VariationState> emit,
  ) async {
    emit(LoadingVariationState());

    var result = await _getAllVariationsUseCase(
      input: GetAllVariationsInputDto(symbol: event.symbol),
    );

    result.fold((left) {
      emit(FailureVariationState(error: left.message));
    }, (right) async {
      emit(SuccessVariationState(variations: right));
    });
  }
}
