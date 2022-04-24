part of 'error_cubit.dart';

@immutable
class ErrorState {
  const ErrorState();
}

class InitialState extends ErrorState {
  const InitialState();
}

class SnackBarError extends ErrorState {
  const SnackBarError(this.message);

  final String? message;
}

class DialogError extends ErrorState {
  const DialogError(this.message);

  final String? message;
}
