import '../../../core/failures/failures.dart';

class EmptySymbolGetAllVariationsFailure extends Failure {
  EmptySymbolGetAllVariationsFailure({
    required String message,
    StackTrace? stackTrace,
  }) : super(message: message, stackTrace: stackTrace);
}
