import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'error_state.dart';
part 'error_cubit.freezed.dart';

class ErrorCubit extends Cubit<ErrorState> {
  ErrorCubit() : super(const ErrorState());

  void showInSnackBar(String? error) => emit(ErrorState.snackBarError(error));
  void showInDialog(String? error) => emit(ErrorState.dialogError(error));
}
