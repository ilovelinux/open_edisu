import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:open_edisu/cubit/page_cubit.dart';

void main() {
  group('PageCubit', () {
    blocTest<PageCubit, int>(
      'emits [] when nothing is called and initial status is 0',
      build: () => PageCubit(),
      expect: () => const <int>[],
      verify: (cubit) => expect(cubit.state, 0),
    );

    blocTest<PageCubit, int>(
      'emits [1, 3] when change(1) and change(3) are called sequently',
      build: () => PageCubit(),
      act: (cubit) => cubit
        ..change(1)
        ..change(3),
      expect: () => const <int>[1, 3],
    );
  });
}
