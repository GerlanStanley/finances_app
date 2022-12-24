import 'package:dartz/dartz.dart';

import '../../../core/failures/failure.dart';

import '../../domain/dtos/dtos.dart';
import '../../domain/entities/entities.dart';
import '../../domain/repositories/repositories.dart';

import '../data_sources/data_sources.dart';

class VariationRepositoryImpl implements VariationRepository {
  final VariationDataSource _dataSource;

  VariationRepositoryImpl(
    this._dataSource,
  );

  @override
  Future<Either<Failure, List<VariationEntity>>> getAll({
    required GetAllVariationsInputDto input,
  }) async {
    try {
      var result = await _dataSource.getAll(input: input);
      return Right(result);
    } on Failure catch (e) {
      return Left(e);
    }
  }
}
