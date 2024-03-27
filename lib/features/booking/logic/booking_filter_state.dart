part of 'booking_filter_cubit.dart';

@freezed
class BookingFilterState with _$BookingFilterState {
  const factory BookingFilterState.updated(Map<BookingFilters, bool> filters) =
      _Updated;
}
