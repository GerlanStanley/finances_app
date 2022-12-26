class FinancialAssetEntity {
  final String symbol;
  final String? longName;
  final String? sector;
  final String? industry;

  FinancialAssetEntity({
    required this.symbol,
    required this.longName,
    required this.sector,
    required this.industry,
  });
}
