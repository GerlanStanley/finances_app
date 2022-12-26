import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:finances_app/app/domain/dtos/dtos.dart';
import 'package:finances_app/app/domain/entities/entities.dart';
import 'package:finances_app/app/domain/use_cases/use_cases.dart';
import 'package:finances_app/app/presenter/blocs/variation/variation.dart';
import 'package:finances_app/core/failures/failures.dart';

class MockGetAllVariationsUseCase extends Mock
    implements GetAllVariationsUseCase {}

void main() {
  late MockGetAllVariationsUseCase useCase;
  late VariationBloc bloc;
  late GetAllVariationsInputDto input;

  setUp(() {
    useCase = MockGetAllVariationsUseCase();
    bloc = VariationBloc(useCase);
    input = const GetAllVariationsInputDto(symbol: "teste");

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
        (_) async => const Right<Failure, List<VariationEntity>>([]),
      );
      return bloc;
    },
    act: (VariationBloc bloc) {
      bloc.add(const GetAllVariationsEvent(symbol: "teste"));
    },
    expect: () => [
      isA<LoadingVariationState>(),
      isA<SuccessVariationState>(),
    ],
  );

  blocTest(
    "Quando o useCase retornar uma falha o "
    "bloc deve iniciar carregando e terminar com falha",
    build: () {
      when(() => useCase.call(input: any(named: "input"))).thenAnswer(
        (_) async => Left<Failure, List<VariationEntity>>(
          Failure(message: ""),
        ),
      );
      return bloc;
    },
    act: (VariationBloc bloc) {
      bloc.add(const GetAllVariationsEvent(symbol: "teste"));
    },
    expect: () => [
      isA<LoadingVariationState>(),
      isA<FailureVariationState>(),
    ],
  );
}
