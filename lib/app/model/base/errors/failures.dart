import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;
  final Map<String, dynamic> errors;

  const Failure(this.message, {this.errors = const {}});

  @override
  String toString() {
    return 'Failure{message: $message}';
  }
}

class CommonFailure extends Failure {
  const CommonFailure(super.message);

  @override
  List<Object?> get props => [message];
}

class CacheFailure extends Failure {
  const CacheFailure(super.message);

  @override
  List<Object?> get props => [message];
}

Failure handleFailure(Either<Failure, dynamic> resultEither) {
  return resultEither.fold((failure) => failure, (r) => null)!;
}

class DioInternalError extends Failure {
  const DioInternalError({required String message}) : super(message);

  @override
  List<Object?> get props => [message];
}

class DioNotFoundError extends Failure {
  const DioNotFoundError({required String message}) : super(message);

  @override
  List<Object?> get props => [message];
}

class TimeOutError extends Failure {
  const TimeOutError({required String message}) : super(message);

  @override
  List<Object?> get props => [message];
}

class CancelError extends Failure {
  const CancelError({required String message}) : super(message);

  @override
  List<Object?> get props => [message];
}

class DioContentNotFound extends Failure {
  const DioContentNotFound({required String message}) : super(message);

  @override
  List<Object?> get props => [message];
}

class DioBadRequest extends Failure {
  const DioBadRequest({required String message}) : super(message);

  @override
  List<Object?> get props => [message];
}

class DioUnAuthorized extends Failure {
  const DioUnAuthorized({required String message}) : super(message);

  @override
  List<Object?> get props => [message];
}

class ResourceAlreadyExists extends Failure {
  const ResourceAlreadyExists({required String message}) : super(message);

  @override
  List<Object?> get props => [message];
}

class UnprocessableEntity extends Failure {
  const UnprocessableEntity({
    required String message,
    Map<String, dynamic> errors = const {},
  }) : super(message, errors: errors);

  @override
  List<Object?> get props => [message, errors];
}

class ResultsNotFound extends Failure {
  const ResultsNotFound({required String message}) : super(message);

  @override
  List<Object?> get props => [message];
}

class DioDefaultFailure extends Failure {
  const DioDefaultFailure({required String message}) : super(message);

  @override
  List<Object?> get props => [message];
}

class ServiceUnavailableFailure extends Failure {
  const ServiceUnavailableFailure({required String message}) : super(message);

  @override
  List<Object?> get props => [message];
}

class NetworkFailure extends Failure {
  const NetworkFailure({required String message}) : super(message);

  @override
  List<Object?> get props => [message];
}

class ServerFailure extends Failure {
  const ServerFailure(super.message);

  @override
  List<Object?> get props => [message];
}

class UploadFileFailure extends Failure {
  const UploadFileFailure(super.message);

  @override
  List<Object?> get props => [message];
}
