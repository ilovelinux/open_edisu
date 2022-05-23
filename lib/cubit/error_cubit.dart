import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'error_state.dart';

class ErrorCubit extends Cubit<ErrorState> {
  ErrorCubit() : super(const InitialState());

  void showInSnackBar(String? error) => emit(SnackBarError(error));
  void showInDialog(String? error) => emit(DialogError(error));
}
