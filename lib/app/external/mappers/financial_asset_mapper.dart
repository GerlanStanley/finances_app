import '../../domain/entities/entities.dart';

class FinancialAssetMapper {
  static List<FinancialAssetEntity> fromList(List list) {
    return list.map((element) => fromJson(element)).toList();
  }

  static FinancialAssetEntity fromJson(Map json) {
    return FinancialAssetEntity(
      symbol: json["symbol"],
      longName: json.containsKey("longname") ? json["longname"] : null,
      sector: json.containsKey("sector") ? json["sector"] : null,
      industry: json.containsKey("industry") ? json["industry"] : null,
    );
  }
}
