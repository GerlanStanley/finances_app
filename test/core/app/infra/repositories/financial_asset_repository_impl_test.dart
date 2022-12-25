import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:finances_app/app/domain/dtos/dtos.dart';
import 'package:finances_app/app/domain/entities/entities.dart';
import 'package:finances_app/app/infra/data_sources/data_sources.dart';
import 'package:finances_app/app/infra/repositories/repositories.dart';
import 'package:finances_app/core/failures/failures.dart';

class MockFinancialAssetDataSource extends Mock
    implements FinancialAssetDataSource {}

void main() {
  late MockFinancialAssetDataSource dataSource;
  late FinancialAssetRepositoryImpl repository;
  late SearchFinancialAssetsInputDto input;

  setUp(() {
    dataSource = MockFinancialAssetDataSource();
    repository = FinancialAssetRepositoryImpl(dataSource);
    input = const SearchFinancialAssetsInputDto(text: "teste");
    registerFallbackValue(input);
  });

  test(
    "Deve retornar uma List<FinancialAssetEntity> quando o datasource retornar o objeto",
    () async {
      when(() => dataSource.getAll(input: any(named: "input")))
          .thenAnswer((_) async => []);

      var result = await repository.getAll(input: input);

      expect(result.fold(id, id), isA<List<FinancialAssetEntity>>());
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
