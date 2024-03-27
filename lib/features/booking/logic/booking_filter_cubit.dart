import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'booking_filter_state.dart';
part 'booking_filter_cubit.freezed.dart';

enum BookingFilters {
  showInactives,
}

final Map<BookingFilters, bool> _default = {
  for (var v in BookingFilters.values) v: false
};

class BookingFilterCubit extends Cubit<BookingFilterState> {
  BookingFilterCubit() : super(BookingFilterState.updated(_default));

  final Map<BookingFilters, bool> _filters = _default;

  void set(BookingFilters filter, bool value) => emit(
        BookingFilterState.updated(
          Map.from(_filters..update(filter, (_) => value)),
        ),
      );
}
