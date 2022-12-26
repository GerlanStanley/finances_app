import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:finances_app/app/domain/dtos/dtos.dart';
import 'package:finances_app/app/domain/entities/entities.dart';
import 'package:finances_app/app/infra/data_sources/data_sources.dart';
import 'package:finances_app/app/infra/repositories/repositories.dart';
import 'package:finances_app/core/failures/failures.dart';

class MockVariationDataSource extends Mock implements VariationDataSource {}

void main() {
  late MockVariationDataSource dataSource;
  late VariationRepositoryImpl repository;
  late GetAllVariationsInputDto input;

  setUp(() {
    dataSource = MockVariationDataSource();
    repository = VariationRepositoryImpl(dataSource);
    input = const GetAllVariationsInputDto(symbol: "teste");
    registerFallbackValue(input);
  });

  test(
    "Deve retornar uma List<VariationEntity> quando o datasource retornar o objeto",
    () async {
      when(() => dataSource.getAll(input: any(named: "input")))
          .thenAnswer((_) async => []);

      var result = await repository.getAll(input: input);

      expect(result.fold(id, id), isA<List<VariationEntity>>());
    },
  );

  test(
    "Deve retornar um ParseDtoFailure quando lançar ParseDtoFailure",
    () async {
      when(() => dataSource.getAll(input: any(named: "input")))
          .thenThrow(Failure(message: ""));

      var result = await repository.getAll(input: input);

      expect(result.fold(id, id), isA<Failure>());
    },
  );
}
