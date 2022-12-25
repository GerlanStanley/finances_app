import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:finances_app/app/domain/dtos/dtos.dart';
import 'package:finances_app/app/domain/entities/entities.dart';
import 'package:finances_app/app/domain/use_cases/use_cases.dart';
import 'package:finances_app/app/presenter/blocs/financial_asset/financial_asset.dart';
import 'package:finances_app/core/failures/failures.dart';

class MockSearchFinancialAssetsUseCase extends Mock
    implements SearchFinancialAssetsUseCase {}

void main() {
  late MockSearchFinancialAssetsUseCase useCase;
  late FinancialAssetBloc bloc;
  late SearchFinancialAssetsInputDto input;

  setUp(() {
    useCase = MockSearchFinancialAssetsUseCase();
    bloc = FinancialAssetBloc(useCase);
    input = const SearchFinancialAssetsInputDto(text: "teste");

    registerFallbackValue(input);
  });

  tearDown(() {
    bloc.close();
  });

  blocTest(
    "Quando o useCase retornar um sucesso o "
    "bloc deve iniciar carregando e terminar com sucesso",
    build: () {
      when(() => useCase.call(input: any(named: "input"))).thenAnswer(
        (_) async => const Right<Failure, List<FinancialAssetEntity>>([]),
      );
      return bloc;
    },
    act: (FinancialAssetBloc bloc) {
      bloc.add(const SearchFinancialAssetsEvent(text: "teste"));
    },
    expect: () => [
      isA<LoadingFinancialAssetState>(),
      isA<SuccessFinancialAssetState>(),
    ],
  );

  blocTest(
    "Quando o useCase retornar uma falha o "
    "bloc deve iniciar carregando e terminar com falha",
    build: () {
      when(() => useCase.call(input: any(named: "input"))).thenAnswer(
        (_) async => Left<Failure, List<FinancialAssetEntity>>(
          Failure(message: ""),
        ),
      );
      return bloc;
    },
    act: (FinancialAssetBloc bloc) {
      bloc.add(const SearchFinancialAssetsEvent(text: "teste"));
    },
    expect: () => [
      isA<LoadingFinancialAssetState>(),
      isA<FailureFinancialAssetState>(),
    ],
  );
}
