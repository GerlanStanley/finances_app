import '../../../../core/failures/failures.dart';
import '../../../../core/helpers/http/http.dart';

import '../../domain/dtos/dtos.dart';
import '../../domain/entities/entities.dart';
import '../../infra/data_sources/data_sources.dart';

import '../mappers/mappers.dart';

class FinancialAssetDataSourceImpl implements FinancialAssetDataSource {
  final HttpHelper _httpHelper;

  FinancialAssetDataSourceImpl(this._httpHelper);

  @override
  Future<List<FinancialAssetEntity>> getAll({
    required SearchFinancialAssetsInputDto input,
  }) async {
    try {
      Map response = await _httpHelper.get(
        "/v1/finance/search",
        queryParameters: {
          "q": input.text,
          "lang": "pt-BR"
        },
      );
      return FinancialAssetMapper.fromList(response["quotes"]);
    } on Failure {
      rethrow;
    } catch (e, stackTrace) {
      throw ParseFailure(
        message: "Erro ao mapear o json",
        stackTrace: stackTrace,
      );
    }
  }
}
