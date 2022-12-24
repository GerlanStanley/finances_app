import 'package:dartz/dartz.dart';

import '../../../core/failures/failures.dart';

import '../dtos/dtos.dart';
import '../entities/entities.dart';
import '../failures/failures.dart';
import '../repositories/repositories.dart';

import 'use_cases.dart';

class GetAllVariationsUseCaseImpl implements GetAllVariationsUseCase {
  final VariationRepository _repository;

  GetAllVariationsUseCaseImpl(this._repository);

  @override
  Future<Either<Failure, List<VariationEntity>>> call({
    required GetAllVariationsInputDto input,
  }) async {
    if (input.symbol.trim().isEmpty) {
      return Left(EmptySymbolGetAllVariationsFailure(
        message: "Informe o simbolo do ativo",
      ));
    }

    return await _repository.getAll(input: input);
  }
}
