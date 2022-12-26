import 'dart:convert';

import 'package:finances_app/core/failures/failures.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:finances_app/app/domain/dtos/dtos.dart';
import 'package:finances_app/app/domain/entities/entities.dart';
import 'package:finances_app/app/external/data_sources/data_sources.dart';
import 'package:finances_app/core/helpers/http/http.dart';

class MockHttpHelper extends Mock implements HttpHelper {}

void main() {
  late MockHttpHelper httpHelper;
  late VariationDataSourceImpl dataSource;
  late GetAllVariationsInputDto input;

  setUp(() {
    httpHelper = MockHttpHelper();
    dataSource = VariationDataSourceImpl(httpHelper);
    input = const GetAllVariationsInputDto(symbol: "teste");

    registerFallbackValue(input);
  });

  test("Deve retornar uma List<VariationEntity>", () async {
    when(() => httpHelper.get(
          any(),
          queryParameters: any(named: "queryParameters"),
        )).thenAnswer((_) async => successJson);

    var result = await dataSource.getAll(input: input);

    expect(result, isA<List<VariationEntity>>());
  });

  test("Conferindo se está passando os params no queryParameters", () async {
    DateTime now = DateTime.now();
    var period1 =
        now.subtract(const Duration(days: 50)).millisecondsSinceEpoch ~/ 1000;
    var period2 = now.millisecondsSinceEpoch ~/ 1000;

    when(() => httpHelper.get(any(), queryParameters: {
          "interval": "1d",
          "period1": period1,
          "period2": period2,
        })).thenAnswer((_) async => successJson);

    var result = await dataSource.getAll(input: input);

    expect(result, isA<List<VariationEntity>>());
  });

  test("Deve lançar uma HttpFailure quando status diferente de 200", () async {
    when(() => httpHelper.get(
          any(),
          queryParameters: any(named: "queryParameters"),
        )).thenThrow(
      BadRequestHttpFailure(message: ""),
    );

    var result = dataSource.getAll(input: input);

    expect(result, throwsA(isA<HttpFailure>()));
  });

  test("Deve retornar um ParseJsonFailure quando não vier um json", () async {
    when(() => httpHelper.get(
          any(),
          queryParameters: any(named: "queryParameters"),
        )).thenThrow(Exception());

    var result = dataSource.getAll(input: input);

    expect(result, throwsA(isA<ParseFailure>()));
  });

  test(
    "Deve retornar um ParseJsonFailure quando não conseguir parsear a resposta",
    () async {
      when(() => httpHelper.get(
            any(),
            queryParameters: any(named: "queryParameters"),
          )).thenAnswer((_) async => invalidJson);

      var result = dataSource.getAll(input: input);

      expect(result, throwsA(isA<ParseFailure>()));
    },
  );
}

final successJson = jsonDecode(r'''
{
    "chart": {
        "result": [
            {
                "meta": {
                    "currency": "BRL",
                    "symbol": "PETR4.SA",
                    "exchangeName": "SAO",
                    "instrumentType": "EQUITY",
                    "firstTradeDate": 946900800,
                    "regularMarketTime": 1671829672,
                    "gmtoffset": -7200,
                    "timezone": "BRST",
                    "exchangeTimezoneName": "America/Sao_Paulo",
                    "regularMarketPrice": 25.12,
                    "chartPreviousClose": 23.33,
                    "priceHint": 2,
                    "currentTradingPeriod": {
                        "pre": {
                            "timezone": "BRST",
                            "start": 1671795900,
                            "end": 1671796800,
                            "gmtoffset": -7200
                        },
                        "regular": {
                            "timezone": "BRST",
                            "start": 1671796800,
                            "end": 1671822000,
                            "gmtoffset": -7200
                        },
                        "post": {
                            "timezone": "BRST",
                            "start": 1671822000,
                            "end": 1671825600,
                            "gmtoffset": -7200
                        }
                    },
                    "dataGranularity": "1d",
                    "range": "",
                    "validRanges": [
                        "1d",
                        "5d",
                        "1mo",
                        "3mo",
                        "6mo",
                        "1y",
                        "2y",
                        "5y",
                        "10y",
                        "ytd",
                        "max"
                    ]
                },
                "timestamp": [
                    1669204800,
                    1669291200,
                    1669377600,
                    1669636800,
                    1669723200,
                    1669809600,
                    1669896000,
                    1669982400,
                    1670241600,
                    1670328000,
                    1670414400,
                    1670500800,
                    1670587200,
                    1670846400,
                    1670932800,
                    1671019200,
                    1671105600,
                    1671192000,
                    1671451200,
                    1671537600,
                    1671624000,
                    1671710400
                ],
                "indicators": {
                    "quote": [
                        {
                            "open": [
                                23.0,
                                23.520000457763672,
                                24.260000228881836,
                                23.649999618530273,
                                24.600000381469727,
                                25.600000381469727,
                                26.579999923706055,
                                25.690000534057617,
                                26.0,
                                25.81999969482422,
                                25.34000015258789,
                                25.549999237060547,
                                24.989999771118164,
                                24.579999923706055,
                                24.100000381469727,
                                22.5,
                                21.0,
                                21.959999084472656,
                                22.100000381469727,
                                22.389999389648438,
                                23.5,
                                23.899999618530273
                            ],
                            "close": [
                                23.440000534057617,
                                24.25,
                                23.860000610351562,
                                24.360000610351562,
                                25.3799991607666,
                                26.65999984741211,
                                25.59000015258789,
                                25.90999984741211,
                                25.6200008392334,
                                25.639999389648438,
                                25.350000381469727,
                                24.780000686645508,
                                24.709999084472656,
                                23.90999984741211,
                                23.31999969482422,
                                21.469999313354492,
                                22.040000915527344,
                                22.049999237060547,
                                22.3799991607666,
                                23.06999969482422,
                                23.56999969482422,
                                23.989999771118164
                            ],
                            "volume": [
                                77317300,
                                94233800,
                                58635900,
                                56067400,
                                96151500,
                                120774700,
                                71259400,
                                66301000,
                                56065400,
                                74991200,
                                57008400,
                                55567700,
                                61586200,
                                111293100,
                                102533100,
                                319501600,
                                132385600,
                                90767300,
                                63074100,
                                71875500,
                                74252800,
                                81894800
                            ],
                            "high": [
                                23.649999618530273,
                                24.6299991607666,
                                24.329999923706055,
                                24.549999237060547,
                                25.8799991607666,
                                26.65999984741211,
                                26.790000915527344,
                                26.450000762939453,
                                26.579999923706055,
                                26.389999389648438,
                                26.06999969482422,
                                25.790000915527344,
                                25.049999237060547,
                                24.65999984741211,
                                24.200000762939453,
                                22.600000381469727,
                                22.3700008392334,
                                22.110000610351562,
                                22.510000228881836,
                                23.239999771118164,
                                23.719999313354492,
                                24.559999465942383
                            ],
                            "low": [
                                22.799999237060547,
                                23.25,
                                23.600000381469727,
                                23.540000915527344,
                                24.479999542236328,
                                25.5,
                                25.559999465942383,
                                25.309999465942383,
                                25.549999237060547,
                                25.420000076293945,
                                25.270000457763672,
                                24.639999389648438,
                                24.489999771118164,
                                23.1299991607666,
                                23.309999465942383,
                                20.770000457763672,
                                20.829999923706055,
                                21.510000228881836,
                                21.639999389648438,
                                22.209999084472656,
                                22.850000381469727,
                                23.700000762939453
                            ]
                        }
                    ],
                    "adjclose": [
                        {
                            "adjclose": [
                                23.440000534057617,
                                24.25,
                                23.860000610351562,
                                24.360000610351562,
                                25.3799991607666,
                                26.65999984741211,
                                25.59000015258789,
                                25.90999984741211,
                                25.6200008392334,
                                25.639999389648438,
                                25.350000381469727,
                                24.780000686645508,
                                24.709999084472656,
                                23.90999984741211,
                                23.31999969482422,
                                21.469999313354492,
                                22.040000915527344,
                                22.049999237060547,
                                22.3799991607666,
                                23.06999969482422,
                                23.56999969482422,
                                23.989999771118164
                            ]
                        }
                    ]
                }
            }
        ],
        "error": null
    }
}
''');

final invalidJson = jsonDecode(r'''
{
    "id": 37
}
''');
