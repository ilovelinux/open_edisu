import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:open_edisu/cubit/error_cubit.dart';

void main() {
  group('ErrorCubit', () {
    blocTest<ErrorCubit, ErrorState>(
      'emits [] when nothing is called and initial status is InitialState',
      build: () => ErrorCubit(),
      expect: () => const <ErrorState>[],
      verify: (cubit) => expect(cubit.state, const ErrorState()),
    );

    blocTest<ErrorCubit, ErrorState>(
      'emits [dialogError(err)] when showInDialog(message) is called',
      build: () => ErrorCubit(),
      act: (cubit) => cubit.showInDialog("Error!"),
      expect: () => const <ErrorState>[ErrorState.dialogError("Error!")],
    );

    blocTest<ErrorCubit, ErrorState>(
      'emits [snackBarError(message)] when showInStackBar(message) is called',
      build: () => ErrorCubit(),
      act: (cubit) => cubit.showInSnackBar("Error!"),
      expect: () => const <ErrorState>[ErrorState.snackBarError("Error!")],
    );
  });
}
