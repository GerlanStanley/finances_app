import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/dtos/dtos.dart';
import '../../../domain/use_cases/use_cases.dart';

import 'financial_asset.dart';

class PlatformsBloc extends Bloc<FinancialAssetEvent, FinancialAssetState> {
  final SearchFinancialAssetsUseCase _searchFinancialAssets;

  PlatformsBloc(this._searchFinancialAssets)
      : super(InitialFinancialAssetState()) {
    //
    on<SearchFinancialAssetsEvent>(_onSearch);
  }

  Future<void> _onSearch(
    SearchFinancialAssetsEvent event,
    Emitter<FinancialAssetState> emit,
  ) async {
    emit(LoadingFinancialAssetState());

    var result = await _searchFinancialAssets(
      input: SearchFinancialAssetsInputDto(text: event.text),
    );

    result.fold((left) {
      emit(FailureFinancialAssetState(error: left.message));
    }, (right) async {
      emit(SuccessFinancialAssetState(platforms: right));
    });
  }
}
