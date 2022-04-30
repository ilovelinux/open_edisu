import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

import '../models/edisu.dart';
import '../utilities/api.dart';

part 'bookings_event.dart';
part 'bookings_state.dart';
part 'bookings_bloc.freezed.dart';

class BookingsBloc extends Bloc<BookingsEvent, BookingsState> {
  Bookings bookings = [];
  BookingsBloc() : super(const BookingsState.loading()) {
    on<UpdateRequested>((event, emit) async {
      emit(const BookingsState.loading());
      try {
        emit(BookingsState(bookings = await getBookings()));
      } catch (e) {
        emit(BookingsState.error(e.toString()));
      }
    });
  }
}
