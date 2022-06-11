import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

import '../models/edisu.dart';
import '../utilities/inceptor.dart';

part 'bookings_event.dart';
part 'bookings_state.dart';
part 'bookings_bloc.freezed.dart';

class BookingsBloc extends Bloc<BookingsEvent, BookingsState> {
  Bookings bookings = [];

  BookingsBloc() : super(const BookingsState.loading()) {
    on<UpdateRequested>((event, emit) async {
      emit(const BookingsState.loading());
      try {
        emit(BookingsState(bookings = await client.getBookings()));
      } on DioError catch (e) {
        emit(BookingsState.error(e.error.toString()));
        rethrow;
      } catch (e) {
        emit(BookingsState.error(e.toString()));
        rethrow;
      }
    });
  }
}
