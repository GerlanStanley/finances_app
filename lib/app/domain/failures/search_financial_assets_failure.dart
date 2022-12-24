import '../../../core/failures/failures.dart';

class EmptyTextSearchFinancialAssetsFailure extends Failure {
  EmptyTextSearchFinancialAssetsFailure({
    required String message,
    StackTrace? stackTrace,
  }) : super(message: message, stackTrace: stackTrace);
}
