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
  late FinancialAssetDataSourceImpl dataSource;
  late SearchFinancialAssetsInputDto input;

  setUp(() {
    httpHelper = MockHttpHelper();
    dataSource = FinancialAssetDataSourceImpl(httpHelper);
    input = const SearchFinancialAssetsInputDto(text: "teste");

    registerFallbackValue(input);
  });

  test("Deve retornar uma List<FinancialAssetEntity>", () async {
    when(() => httpHelper.get(
          any(),
          queryParameters: any(named: "queryParameters"),
        )).thenAnswer((_) async => successJson);

    var result = await dataSource.getAll(input: input);

    expect(result, isA<List<FinancialAssetEntity>>());
  });

  test("Conferindo se está passando os params no queryParameters", () async {
    when(() => httpHelper.get(any(), queryParameters: {
          "q": input.text,
          "lang": "pt-BR",
        })).thenAnswer((_) async => successJson);

    var result = await dataSource.getAll(input: input);

    expect(result, isA<List<FinancialAssetEntity>>());
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
    "explains": [],
    "count": 10,
    "quotes": [
        {
            "exchange": "SAO",
            "shortname": "PETROBRAS   PN      N2",
            "quoteType": "EQUITY",
            "symbol": "PETR4.SA",
            "index": "quotes",
            "score": 20737.0,
            "typeDisp": "Equity",
            "longname": "Petróleo Brasileiro S.A. - Petrobras",
            "exchDisp": "São Paulo",
            "sector": "Energy",
            "industry": "Oil & Gas Integrated",
            "dispSecIndFlag": true,
            "isYahooFinance": true
        },
        {
            "exchange": "SAO",
            "shortname": "PETROBRAS   PN      N2",
            "quoteType": "EQUITY",
            "symbol": "PETR4F.SA",
            "index": "quotes",
            "score": 20008.0,
            "typeDisp": "Equity",
            "exchDisp": "São Paulo",
            "isYahooFinance": true
        }
    ],
    "news": [
        {
            "uuid": "6a03e0ad-f7aa-320d-8296-dec25fdd51a7",
            "title": "Dow Jones Futures: Market Rally Not Finished Yet; Tesla Shanghai Production Halted",
            "publisher": "Investor's Business Daily",
            "link": "https://finance.yahoo.com/m/6a03e0ad-f7aa-320d-8296-dec25fdd51a7/dow-jones-futures%3A-market.html",
            "providerPublishTime": 1671987572,
            "type": "STORY",
            "thumbnail": {
                "resolutions": [
                    {
                        "url": "https://s.yimg.com/uu/api/res/1.2/eOFqUGX_D9j0Rb730mS.Ag--~B/aD01MTA7dz0xMDAwO2FwcGlkPXl0YWNoeW9u/https://media.zenfs.com/en/ibd.com/1c65dcbe258ddb4288c0fef692b8542f",
                        "width": 1000,
                        "height": 510,
                        "tag": "original"
                    },
                    {
                        "url": "https://s.yimg.com/uu/api/res/1.2/bvsamERSlntgucqPg5Ih4w--~B/Zmk9ZmlsbDtoPTE0MDtweW9mZj0wO3c9MTQwO2FwcGlkPXl0YWNoeW9u/https://media.zenfs.com/en/ibd.com/1c65dcbe258ddb4288c0fef692b8542f",
                        "width": 140,
                        "height": 140,
                        "tag": "140x140"
                    }
                ]
            },
            "relatedTickers": [
                "^GSPC",
                "TSLA",
                "^DJI",
                "NVDA",
                "ENPH",
                "PI",
                "COMP"
            ]
        },
        {
            "uuid": "f84579e8-2e13-30ce-a677-b9cbb70ad091",
            "title": "President Biden Wants to Enact These 3 Social Security Changes in 2023: Will He Succeed?",
            "publisher": "Motley Fool",
            "link": "https://finance.yahoo.com/m/f84579e8-2e13-30ce-a677-b9cbb70ad091/president-biden-wants-to.html",
            "providerPublishTime": 1671987420,
            "type": "STORY",
            "thumbnail": {
                "resolutions": [
                    {
                        "url": "https://s.yimg.com/uu/api/res/1.2/3bknFHS756oOdpkYNklvmA--~B/aD0xNDE1O3c9MjExOTthcHBpZD15dGFjaHlvbg--/https://media.zenfs.com/en/motleyfool.com/46a604799d44bc79e9c141f15134970b",
                        "width": 2119,
                        "height": 1415,
                        "tag": "original"
                    },
                    {
                        "url": "https://s.yimg.com/uu/api/res/1.2/n_.AScrzA3JIzaE7jsyvLA--~B/Zmk9ZmlsbDtoPTE0MDtweW9mZj0wO3c9MTQwO2FwcGlkPXl0YWNoeW9u/https://media.zenfs.com/en/motleyfool.com/46a604799d44bc79e9c141f15134970b",
                        "width": 140,
                        "height": 140,
                        "tag": "140x140"
                    }
                ]
            }
        },
        {
            "uuid": "575d9fe0-dbb3-3a35-a9ef-6cd88814e08d",
            "title": "Winter Storm: Hydro-Québec Provides an Update on the Outages",
            "publisher": "CNW Group",
            "link": "https://finance.yahoo.com/news/winter-storm-hydro-qu-bec-163900524.html",
            "providerPublishTime": 1671986340,
            "type": "STORY",
            "thumbnail": {
                "resolutions": [
                    {
                        "url": "https://s.yimg.com/uu/api/res/1.2/Z4kZ.oOWN8GA5lFbGT3EBA--~B/aD0yMTA7dz00MDA7YXBwaWQ9eXRhY2h5b24-/https://media.zenfs.com/en/cnwgroup.com/72d0694a4e29bdcd3d9c0b0563f8e295",
                        "width": 400,
                        "height": 210,
                        "tag": "original"
                    },
                    {
                        "url": "https://s.yimg.com/uu/api/res/1.2/3W.K5J_H_IzxTYilBixsSw--~B/Zmk9ZmlsbDtoPTE0MDtweW9mZj0wO3c9MTQwO2FwcGlkPXl0YWNoeW9u/https://media.zenfs.com/en/cnwgroup.com/72d0694a4e29bdcd3d9c0b0563f8e295",
                        "width": 140,
                        "height": 140,
                        "tag": "140x140"
                    }
                ]
            }
        },
        {
            "uuid": "6a2ba5c3-d1ae-341d-b34d-b4bd8adaf240",
            "title": "Death toll rises in Buffalo as frigid cold freezes eastern U.S. on Christmas Day",
            "publisher": "Reuters",
            "link": "https://finance.yahoo.com/news/death-toll-rises-buffalo-frigid-163826548.html",
            "providerPublishTime": 1671986306,
            "type": "STORY"
        },
        {
            "uuid": "5aa81128-d7d7-36b8-8e1b-ccb1b7541e8f",
            "title": "UPDATE 1-Bloomberg has no interest in acquiring Dow Jones or Washington Post, spokesman says",
            "publisher": "Reuters",
            "link": "https://finance.yahoo.com/news/1-bloomberg-no-interest-acquiring-163621253.html",
            "providerPublishTime": 1671986181,
            "type": "STORY"
        },
        {
            "uuid": "ea798f10-31ab-333e-8006-f9258cf51a42",
            "title": "Racked Up Holiday Debt? How a Personal Loan Could Be Your Ticket to Making It Less Expensive",
            "publisher": "Motley Fool",
            "link": "https://finance.yahoo.com/m/ea798f10-31ab-333e-8006-f9258cf51a42/racked-up-holiday-debt%3F-how-a.html",
            "providerPublishTime": 1671985818,
            "type": "STORY",
            "thumbnail": {
                "resolutions": [
                    {
                        "url": "https://s.yimg.com/uu/api/res/1.2/7ayd0V62zHKsdfYqU4TN3g--~B/aD04MDA7dz0xMjAwO2FwcGlkPXl0YWNoeW9u/https://media.zenfs.com/en/motleyfool.com/76cca21c312885f8c254b0986e1d6a43",
                        "width": 1200,
                        "height": 800,
                        "tag": "original"
                    },
                    {
                        "url": "https://s.yimg.com/uu/api/res/1.2/FuDt2v6iSaMoWpaQxRetTg--~B/Zmk9ZmlsbDtoPTE0MDtweW9mZj0wO3c9MTQwO2FwcGlkPXl0YWNoeW9u/https://media.zenfs.com/en/motleyfool.com/76cca21c312885f8c254b0986e1d6a43",
                        "width": 140,
                        "height": 140,
                        "tag": "140x140"
                    }
                ]
            }
        },
        {
            "uuid": "b14a17ea-b07c-37ad-9d88-35da361f2438",
            "title": "One Company Dominates Wall Street on Oil Frenzy",
            "publisher": "TheStreet.com",
            "link": "https://finance.yahoo.com/m/b14a17ea-b07c-37ad-9d88-35da361f2438/one-company-dominates-wall.html",
            "providerPublishTime": 1671985500,
            "type": "STORY",
            "thumbnail": {
                "resolutions": [
                    {
                        "url": "https://s.yimg.com/uu/api/res/1.2/41yT0RPNb_Vqf8T.yfib6A--~B/aD0xMDgwO3c9MTkyMDthcHBpZD15dGFjaHlvbg--/https://media.zenfs.com/en/thestreet.com/af32a2d796bf7d8c499d2d103885ce5b",
                        "width": 1920,
                        "height": 1080,
                        "tag": "original"
                    },
                    {
                        "url": "https://s.yimg.com/uu/api/res/1.2/GfURJ.QnL_vax0u.GucZ_A--~B/Zmk9ZmlsbDtoPTE0MDtweW9mZj0wO3c9MTQwO2FwcGlkPXl0YWNoeW9u/https://media.zenfs.com/en/thestreet.com/af32a2d796bf7d8c499d2d103885ce5b",
                        "width": 140,
                        "height": 140,
                        "tag": "140x140"
                    }
                ]
            },
            "relatedTickers": [
                "CVX",
                "^DJI",
                "AMGN"
            ]
        },
        {
            "uuid": "b5c9b1d9-3a9c-3753-9a3b-19549657cd3e",
            "title": "Disney and Nike Share a Tough and Wild Story Together",
            "publisher": "TheStreet.com",
            "link": "https://finance.yahoo.com/m/b5c9b1d9-3a9c-3753-9a3b-19549657cd3e/disney-and-nike-share-a-tough.html",
            "providerPublishTime": 1671985140,
            "type": "STORY",
            "thumbnail": {
                "resolutions": [
                    {
                        "url": "https://s.yimg.com/uu/api/res/1.2/M442djzx7RY2x27OHh2gww--~B/aD0xMDgwO3c9MTkyMDthcHBpZD15dGFjaHlvbg--/https://media.zenfs.com/en/thestreet.com/739dc83fce2c23b4ae60f75b9ee40185",
                        "width": 1920,
                        "height": 1080,
                        "tag": "original"
                    },
                    {
                        "url": "https://s.yimg.com/uu/api/res/1.2/d6qAfOIPxigocGfleRM23A--~B/Zmk9ZmlsbDtoPTE0MDtweW9mZj0wO3c9MTQwO2FwcGlkPXl0YWNoeW9u/https://media.zenfs.com/en/thestreet.com/739dc83fce2c23b4ae60f75b9ee40185",
                        "width": 140,
                        "height": 140,
                        "tag": "140x140"
                    }
                ]
            },
            "relatedTickers": [
                "DIS",
                "^DJI"
            ]
        }
    ],
    "nav": [],
    "lists": [],
    "researchReports": [],
    "screenerFieldResults": [],
    "totalTime": 94,
    "timeTakenForQuotes": 470,
    "timeTakenForNews": 600,
    "timeTakenForAlgowatchlist": 400,
    "timeTakenForPredefinedScreener": 400,
    "timeTakenForCrunchbase": 0,
    "timeTakenForNav": 400,
    "timeTakenForResearchReports": 0,
    "timeTakenForScreenerField": 0,
    "timeTakenForCulturalAssets": 0
}
''');

final invalidJson = jsonDecode(r'''
{
    "id": 37
}
''');
