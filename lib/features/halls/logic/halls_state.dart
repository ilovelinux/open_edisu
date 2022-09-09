part of 'halls_bloc.dart';

@freezed
class HallsState with _$HallsState {
  const factory HallsState.loading() = _Loading;
  const factory HallsState.success(
    final Halls halls,
    final HallsMobile hallsMobile,
  ) = _Showing;
  const factory HallsState.error(final String message) = _Error;
}
