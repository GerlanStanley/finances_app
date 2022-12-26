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

class MockFinancialAssetRepository extends Mock
    implements FinancialAssetRepository {}

void main() {
  late MockFinancialAssetRepository repository;
  late SearchFinancialAssetsUseCaseImpl useCase;

  setUp(() {
    repository = MockFinancialAssetRepository();
    useCase = SearchFinancialAssetsUseCaseImpl(repository);

    registerFallbackValue(const SearchFinancialAssetsInputDto(text: "Teste"));
  });

  test(
    "Deve retornar um Right(List<FinancialAssetEntity>) quando o repository "
    "retornar um Right(List<FinancialAssetEntity>)",
    () async {
      var input = const SearchFinancialAssetsInputDto(text: "Teste");
      when(() => repository.getAll(input: any(named: "input")))
          .thenAnswer((_) async {
        List<FinancialAssetEntity> items = [];
        for (int i = 0; i < 3; i++) {
          items.add(FinancialAssetEntity(
            symbol: faker.vehicle.model(),
            longName: faker.vehicle.model(),
            industry: faker.vehicle.model(),
            sector: faker.vehicle.model(),
          ));
        }

        return Right(items);
      });

      var result = await useCase(input: input);

      expect(result.fold(id, id), isA<List<FinancialAssetEntity>>());
    },
  );

  test(
    "Deve retornar um Left(EmptyTextSearchFinancialAssetsFailure) "
    "quando o texto for vazio",
    () async {
      var input = const SearchFinancialAssetsInputDto(text: "");

      var result = await useCase(input: input);

      expect(result.fold(id, id), isA<EmptyTextSearchFinancialAssetsFailure>());
    },
  );

  test(
    "Deve retornar um Left(Failure) quando o repository "
    "retornar um Left(Failure)",
    () async {
      var input = const SearchFinancialAssetsInputDto(text: "Teste");

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
