import '../../../../core/failures/failures.dart';
import '../../../../core/helpers/http/http.dart';

import '../../domain/dtos/dtos.dart';
import '../../domain/entities/entities.dart';
import '../../infra/data_sources/data_sources.dart';

import '../mappers/mappers.dart';

class VariationDataSourceImpl implements VariationDataSource {
  final HttpHelper _httpHelper;

  VariationDataSourceImpl(this._httpHelper);

  @override
  Future<List<VariationEntity>> getAll({
    required GetAllVariationsInputDto input,
  }) async {
    try {
      DateTime now = DateTime.now();
      var period1 = now.millisecondsSinceEpoch ~/ 1000;
      var period2 =
          now.subtract(const Duration(days: 30)).millisecondsSinceEpoch ~/ 1000;

      Map response = await _httpHelper.get(
        "/v8/finance/charts/${input.symbol}",
        queryParameters: {
          "interval": "1d",
          "period1": period1,
          "period2": period2,
        },
      );
      return VariationMapper.fromList(response["chart"]["result"]);
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
