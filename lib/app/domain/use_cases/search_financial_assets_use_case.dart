import 'package:dartz/dartz.dart';

import '../../../core/failures/failures.dart';

import '../dtos/dtos.dart';
import '../entities/entities.dart';

abstract class SearchFinancialAssetsUseCase {
  Future<Either<Failure, List<FinancialAssetEntity>>> call({
    required SearchFinancialAssetsInputDto input,
  });
}
