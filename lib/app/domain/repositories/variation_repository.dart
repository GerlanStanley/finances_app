import 'package:dartz/dartz.dart';

import '../../../core/failures/failures.dart';

import '../dtos/dtos.dart';
import '../entities/entities.dart';

abstract class VariationRepository {
  Future<Either<Failure, List<VariationEntity>>> getAll({
    required GetAllVariationsInputDto input,
  });
}