import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'error_state.dart';

class ErrorCubit extends Cubit<ErrorState> {
  ErrorCubit() : super(const InitialState());

  void showInSnackBar(String? error) => emit(SnackBarError(error));
  void showInDialog(String? error) => emit(DialogError(error));
}
