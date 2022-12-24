import '../../domain/dtos/dtos.dart';
import '../../domain/entities/entities.dart';

abstract class VariationDataSource {
  Future<List<VariationEntity>> getAll({
    required GetAllVariationsInputDto input,
  });
}
