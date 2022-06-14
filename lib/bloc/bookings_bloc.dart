import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:open_edisu/utilities/dio.dart';

import '../models/edisu.dart';
import '../utilities/inceptor.dart';

part 'bookings_event.dart';
part 'bookings_state.dart';
part 'bookings_bloc.freezed.dart';

class BookingsBloc extends Bloc<BookingsEvent, BookingsState> {
  Bookings bookings = [];

  BookingsBloc() : super(const BookingsState.loading()) {
    on<_Update>((event, emit) async {
      emit(const BookingsState.loading());
      try {
        emit(BookingsState.success(bookings = await client.getBookings()));
      } catch (e) {
        emit(BookingsState.error(getErrorString(e)));

        if (kDebugMode) {
          rethrow;
        }
      }
    });
  }
}
