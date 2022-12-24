import 'package:dartz/dartz.dart';

import '../../../core/failures/failures.dart';

import '../dtos/dtos.dart';
import '../entities/entities.dart';
import '../failures/failures.dart';
import '../repositories/repositories.dart';

import 'use_cases.dart';

class SearchFinancialAssetsUseCaseImpl implements SearchFinancialAssetsUseCase {
  final FinancialAssetRepository _repository;

  SearchFinancialAssetsUseCaseImpl(this._repository);

  @override
  Future<Either<Failure, List<FinancialAssetEntity>>> call({
    required SearchFinancialAssetsInputDto input,
  }) async {
    if (input.text.trim().isEmpty) {
      return Left(EmptyTextSearchFinancialAssetsFailure(
        message: "Informe o texto da pesquisa",
      ));
    }

    return await _repository.getAll(input: input);
  }
}
