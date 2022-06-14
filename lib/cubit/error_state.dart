part of 'error_cubit.dart';

@freezed
class ErrorState with _$ErrorState {
  const factory ErrorState.initial() = _Initial;
  const factory ErrorState.dialogError(String? error) = _DialogError;
  const factory ErrorState.snackBarError(String? error) = _SnackBarError;
}
