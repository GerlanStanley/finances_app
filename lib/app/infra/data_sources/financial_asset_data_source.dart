import '../../domain/dtos/dtos.dart';
import '../../domain/entities/entities.dart';

abstract class FinancialAssetDataSource {
  Future<List<FinancialAssetEntity>> getAll({
    required SearchFinancialAssetsInputDto input,
  });
}
