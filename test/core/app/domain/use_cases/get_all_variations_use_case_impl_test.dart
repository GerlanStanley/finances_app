import 'package:dartz/dartz.dart';
import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:finances_app/app/domain/repositories/repositories.dart';
import 'package:finances_app/app/domain/use_cases/use_cases.dart';
import 'package:finances_app/app/domain/dtos/dtos.dart';
import 'package:finances_app/app/domain/entities/entities.dart';
import 'package:finances_app/app/domain/failures/failures.dart';
import 'package:finances_app/core/failures/failures.dart';

class MockVariationRepository extends Mock implements VariationRepository {}

void main() {
  late MockVariationRepository repository;
  late GetAllVariationsUseCaseImpl useCase;

  setUp(() {
    repository = MockVariationRepository();
    useCase = GetAllVariationsUseCaseImpl(repository);

    registerFallbackValue(const GetAllVariationsInputDto(symbol: "Teste"));
  });

  test(
    "Deve retornar um Right(List<VariationEntity>) quando o repository "
    "retornar um Right(List<VariationEntity>)",
    () async {
      var input = const GetAllVariationsInputDto(symbol: "Teste");
      when(
        () => repository.getAll(input: any(named: "input")),
      ).thenAnswer((_) async {
        List<VariationEntity> items = [];
        for (int i = 0; i < 3; i++) {
          items.add(VariationEntity(
            date: faker.date.dateTime(),
            value: 1000,
          ));
        }

        return Right(items);
      });

      var result = await useCase(input: input);

      expect(result.fold(id, id), isA<List<VariationEntity>>());
    },
  );

  test(
    "Deve retornar um Left(EmptySymbolGetAllVariationsFailure) "
    "quando o texto for vazio",
    () async {
      var input = const GetAllVariationsInputDto(symbol: "");

      var result = await useCase(input: input);

      expect(result.fold(id, id), isA<EmptySymbolGetAllVariationsFailure>());
    },
  );

  test(
    "Deve retornar um Left(Failure) quando o repository "
    "retornar um Left(Failure)",
    () async {
      var input = const GetAllVariationsInputDto(symbol: "Teste");

      when(
        () => repository.getAll(input: any(named: "input")),
      ).thenAnswer((_) async {
        return Left(Failure(message: ""));
      });

      var result = await useCase(input: input);

      expect(result.fold(id, id), isA<Failure>());
    },
  );
}
