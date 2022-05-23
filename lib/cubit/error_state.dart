part of 'error_cubit.dart';

@freezed
class ErrorState with _$ErrorState {
  const factory ErrorState() = InitialState;
  const factory ErrorState.dialogError(String? error) = DialogError;
  const factory ErrorState.snackBarError(String? error) = SnackBarError;
}
