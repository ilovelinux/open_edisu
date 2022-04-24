part of 'halls_bloc.dart';

@freezed
class HallsState with _$HallsState {
  const factory HallsState(Halls halls) = Showing;
  const factory HallsState.loading() = Loading;
  const factory HallsState.error(String message) = ErrorDetails;
}
