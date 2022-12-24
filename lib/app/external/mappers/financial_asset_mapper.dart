import '../../domain/entities/entities.dart';

class FinancialAssetMapper {
  static List<FinancialAssetEntity> fromList(List list) {
    return list.map((element) => fromJson(element)).toList();
  }

  static FinancialAssetEntity fromJson(Map json) {
    return FinancialAssetEntity(
      symbol: json["symbol"],
      longName: json["longname"],
      sector: json["sector"],
      industry: json["industry"],
    );
  }
}
