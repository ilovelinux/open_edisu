import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';
import '../models/edisu.dart';
import '../utilities/dio.dart';
import '../utilities/inceptor.dart';

part 'halls_event.dart';
part 'halls_state.dart';
part 'halls_bloc.freezed.dart';

final log = Logger('HallsBloc');

class HallsBloc extends Bloc<HallsEvent, HallsState> {
  HallsBloc() : super(const HallsState.loading()) {
    on<_Update>((event, emit) async {
      emit(const HallsState.loading());
      try {
        emit(HallsState.success(await client.getHalls()));
      } catch (e, stackTrace) {
        emit(HallsState.error(getErrorString(e)));

        log.warning("Catched exception on Update", e, stackTrace);
      }
    });
  }
}
