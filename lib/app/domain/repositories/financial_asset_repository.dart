import 'package:dartz/dartz.dart';

import '../../../core/failures/failures.dart';

import '../dtos/dtos.dart';
import '../entities/entities.dart';

abstract class FinancialAssetRepository {
  Future<Either<Failure, List<FinancialAssetEntity>>> getAll({
    required SearchFinancialAssetsInputDto input,
  });
}