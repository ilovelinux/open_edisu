import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import '../models/edisu.dart';
import '../utilities/inceptor.dart';

part 'halls_event.dart';
part 'halls_state.dart';
part 'halls_bloc.freezed.dart';

class HallsBloc extends Bloc<HallsEvent, HallsState> {
  HallsBloc() : super(const HallsState.loading()) {
    on<HallsUpdateRequested>((event, emit) async {
      emit(const HallsState.loading());
      try {
        emit(HallsState(await client.getHalls()));
      } catch (e) {
        emit(HallsState.error(e.toString()));
        rethrow;
      }
    });
  }
}
