part of 'halls_bloc.dart';

@immutable
abstract class HallsEvent {
  const HallsEvent();
}

class HallsUpdateRequested extends HallsEvent {
  const HallsUpdateRequested();
}
