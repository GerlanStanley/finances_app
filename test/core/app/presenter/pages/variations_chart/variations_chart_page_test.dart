import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';

import 'package:finances_app/app/domain/entities/entities.dart';
import 'package:finances_app/app/presenter/blocs/financial_asset/financial_asset.dart';
import 'package:finances_app/app/presenter/blocs/variation/variation.dart';
import 'package:finances_app/app/presenter/pages/variations_chart/components/components.dart';
import 'package:finances_app/app/presenter/pages/variations_chart/variations_chart_page.dart';
import 'package:finances_app/app/presenter/widgets/widgets.dart';

class MockFinancialAssetBloc
    extends MockBloc<FinancialAssetEvent, FinancialAssetState>
    implements FinancialAssetBloc {}

class MockVariationBloc extends MockBloc<VariationEvent, VariationState>
    implements VariationBloc {}

void main() {
  late MockFinancialAssetBloc financialAssetBloc;
  late MockVariationBloc variationBloc;

  financialAssetBloc = MockFinancialAssetBloc();
  variationBloc = MockVariationBloc();

  GetIt.I.registerLazySingleton<FinancialAssetBloc>(
    () => financialAssetBloc,
  );

  GetIt.I.registerLazySingleton<VariationBloc>(
    () => variationBloc,
  );

  setUp(() {
    when(() => financialAssetBloc.selectedFinancialAsset)
        .thenAnswer((_) => FinancialAssetEntity(
              symbol: "Teste",
              longName: null,
              industry: null,
              sector: null,
            ));

    when(() => financialAssetBloc.state)
        .thenAnswer((_) => InitialFinancialAssetState());
  });

  tearDown(() {
    financialAssetBloc.close();
    variationBloc.close();
  });

  testWidgets(
    "Deve exibir o widget LoadWidget quando "
    "o estado do bloc for LoadingVariationState",
    (WidgetTester tester) async {
      when(() => variationBloc.state)
          .thenAnswer((_) => LoadingVariationState());

      await tester.pumpWidget(
        const MaterialApp(
          home: VariationsChartPage(),
        ),
      );

      final loadWidget = find.byType(LoadWidget);
      final failureWidget = find.byType(FailureWidget);
      final chartComponent = find.byType(ChartComponent);

      await tester.pump();

      expect(loadWidget, findsOneWidget);
      expect(failureWidget, findsNothing);
      expect(chartComponent, findsNothing);
    },
  );

  testWidgets(
    "Deve exibir o widget FailureWidget quando "
    "o estado do bloc for FailureVariationState",
    (WidgetTester tester) async {
      when(() => variationBloc.state)
          .thenAnswer((_) => const FailureVariationState(error: ""));

      await tester.pumpWidget(
        const MaterialApp(
          home: VariationsChartPage(),
        ),
      );

      final loadWidget = find.byType(LoadWidget);
      final failureWidget = find.byType(FailureWidget);
      final chartComponent = find.byType(ChartComponent);

      await tester.pump();

      expect(loadWidget, findsNothing);
      expect(failureWidget, findsOneWidget);
      expect(chartComponent, findsNothing);
    },
  );

  testWidgets(
    "Deve exibir o widget ChartComponent quando "
    "o estado do bloc for SuccessVariationState e a lista não for vazia",
    (WidgetTester tester) async {
      when(() => variationBloc.state).thenAnswer(
        (_) => SuccessVariationState(
          variations: [
            VariationEntity(date: DateTime.now(), value: 150),
          ],
        ),
      );

      await tester.pumpWidget(
        const MaterialApp(
          home: VariationsChartPage(),
        ),
      );

      final loadWidget = find.byType(LoadWidget);
      final failureWidget = find.byType(FailureWidget);
      final chartComponent = find.byType(ChartComponent);

      await tester.pump();

      expect(loadWidget, findsNothing);
      expect(failureWidget, findsNothing);
      expect(chartComponent, findsOneWidget);
    },
  );
}
