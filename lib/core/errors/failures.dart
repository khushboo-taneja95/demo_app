import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  const Failure(this.message,{this.exception});
  final String message;
  final Exception? exception;
}

// General failures
class ServerFailure extends Failure {
  const ServerFailure(String message,{Exception? exception}) : super(message,exception: exception);

  @override
  List<Object?> get props => [message, exception];
}

//App Exception
class AppException extends Failure {
  const AppException(String message,{Exception? exception}) : super(message,exception: exception);

  @override
  List<Object?> get props => [message, exception];
}

// Database Exception
class DatabaseException extends Failure {
  const DatabaseException(String message,{Exception? exception}) : super(message,exception: exception);

  @override
  List<Object?> get props => [message, exception];
}