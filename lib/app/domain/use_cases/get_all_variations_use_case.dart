import 'package:dartz/dartz.dart';

import '../../../core/failures/failures.dart';

import '../dtos/dtos.dart';
import '../entities/entities.dart';

abstract class GetAllVariationsUseCase {
  Future<Either<Failure, List<VariationEntity>>> call({
    required GetAllVariationsInputDto input,
  });
}
