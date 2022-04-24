// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'bookings_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$BookingsEventTearOff {
  const _$BookingsEventTearOff();

  NewBookingRequested call(
      {required Hall hall,
      required int seatID,
      required DateTime date,
      required TimeRange slot}) {
    return NewBookingRequested(
      hall: hall,
      seatID: seatID,
      date: date,
      slot: slot,
    );
  }

  UpdateRequested update() {
    return const UpdateRequested();
  }

  DeleteRequested delete(Booking booking) {
    return DeleteRequested(
      booking,
    );
  }
}

/// @nodoc
const $BookingsEvent = _$BookingsEventTearOff();

/// @nodoc
mixin _$BookingsEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(Hall hall, int seatID, DateTime date, TimeRange slot)
        $default, {
    required TResult Function() update,
    required TResult Function(Booking booking) delete,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult Function(Hall hall, int seatID, DateTime date, TimeRange slot)?
        $default, {
    TResult Function()? update,
    TResult Function(Booking booking)? delete,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(Hall hall, int seatID, DateTime date, TimeRange slot)?
        $default, {
    TResult Function()? update,
    TResult Function(Booking booking)? delete,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(NewBookingRequested value) $default, {
    required TResult Function(UpdateRequested value) update,
    required TResult Function(DeleteRequested value) delete,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult Function(NewBookingRequested value)? $default, {
    TResult Function(UpdateRequested value)? update,
    TResult Function(DeleteRequested value)? delete,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(NewBookingRequested value)? $default, {
    TResult Function(UpdateRequested value)? update,
    TResult Function(DeleteRequested value)? delete,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BookingsEventCopyWith<$Res> {
  factory $BookingsEventCopyWith(
          BookingsEvent value, $Res Function(BookingsEvent) then) =
      _$BookingsEventCopyWithImpl<$Res>;
}

/// @nodoc
class _$BookingsEventCopyWithImpl<$Res>
    implements $BookingsEventCopyWith<$Res> {
  _$BookingsEventCopyWithImpl(this._value, this._then);

  final BookingsEvent _value;
  // ignore: unused_field
  final $Res Function(BookingsEvent) _then;
}

/// @nodoc
abstract class $NewBookingRequestedCopyWith<$Res> {
  factory $NewBookingRequestedCopyWith(
          NewBookingRequested value, $Res Function(NewBookingRequested) then) =
      _$NewBookingRequestedCopyWithImpl<$Res>;
  $Res call({Hall hall, int seatID, DateTime date, TimeRange slot});
}

/// @nodoc
class _$NewBookingRequestedCopyWithImpl<$Res>
    extends _$BookingsEventCopyWithImpl<$Res>
    implements $NewBookingRequestedCopyWith<$Res> {
  _$NewBookingRequestedCopyWithImpl(
      NewBookingRequested _value, $Res Function(NewBookingRequested) _then)
      : super(_value, (v) => _then(v as NewBookingRequested));

  @override
  NewBookingRequested get _value => super._value as NewBookingRequested;

  @override
  $Res call({
    Object? hall = freezed,
    Object? seatID = freezed,
    Object? date = freezed,
    Object? slot = freezed,
  }) {
    return _then(NewBookingRequested(
      hall: hall == freezed
          ? _value.hall
          : hall // ignore: cast_nullable_to_non_nullable
              as Hall,
      seatID: seatID == freezed
          ? _value.seatID
          : seatID // ignore: cast_nullable_to_non_nullable
              as int,
      date: date == freezed
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      slot: slot == freezed
          ? _value.slot
          : slot // ignore: cast_nullable_to_non_nullable
              as TimeRange,
    ));
  }
}

/// @nodoc

class _$NewBookingRequested
    with DiagnosticableTreeMixin
    implements NewBookingRequested {
  const _$NewBookingRequested(
      {required this.hall,
      required this.seatID,
      required this.date,
      required this.slot});

  @override
  final Hall hall;
  @override
  final int seatID;
  @override
  final DateTime date;
  @override
  final TimeRange slot;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'BookingsEvent(hall: $hall, seatID: $seatID, date: $date, slot: $slot)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'BookingsEvent'))
      ..add(DiagnosticsProperty('hall', hall))
      ..add(DiagnosticsProperty('seatID', seatID))
      ..add(DiagnosticsProperty('date', date))
      ..add(DiagnosticsProperty('slot', slot));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is NewBookingRequested &&
            const DeepCollectionEquality().equals(other.hall, hall) &&
            const DeepCollectionEquality().equals(other.seatID, seatID) &&
            const DeepCollectionEquality().equals(other.date, date) &&
            const DeepCollectionEquality().equals(other.slot, slot));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(hall),
      const DeepCollectionEquality().hash(seatID),
      const DeepCollectionEquality().hash(date),
      const DeepCollectionEquality().hash(slot));

  @JsonKey(ignore: true)
  @override
  $NewBookingRequestedCopyWith<NewBookingRequested> get copyWith =>
      _$NewBookingRequestedCopyWithImpl<NewBookingRequested>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(Hall hall, int seatID, DateTime date, TimeRange slot)
        $default, {
    required TResult Function() update,
    required TResult Function(Booking booking) delete,
  }) {
    return $default(hall, seatID, date, slot);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult Function(Hall hall, int seatID, DateTime date, TimeRange slot)?
        $default, {
    TResult Function()? update,
    TResult Function(Booking booking)? delete,
  }) {
    return $default?.call(hall, seatID, date, slot);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(Hall hall, int seatID, DateTime date, TimeRange slot)?
        $default, {
    TResult Function()? update,
    TResult Function(Booking booking)? delete,
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(hall, seatID, date, slot);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(NewBookingRequested value) $default, {
    required TResult Function(UpdateRequested value) update,
    required TResult Function(DeleteRequested value) delete,
  }) {
    return $default(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult Function(NewBookingRequested value)? $default, {
    TResult Function(UpdateRequested value)? update,
    TResult Function(DeleteRequested value)? delete,
  }) {
    return $default?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(NewBookingRequested value)? $default, {
    TResult Function(UpdateRequested value)? update,
    TResult Function(DeleteRequested value)? delete,
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(this);
    }
    return orElse();
  }
}

abstract class NewBookingRequested implements BookingsEvent {
  const factory NewBookingRequested(
      {required Hall hall,
      required int seatID,
      required DateTime date,
      required TimeRange slot}) = _$NewBookingRequested;

  Hall get hall;
  int get seatID;
  DateTime get date;
  TimeRange get slot;
  @JsonKey(ignore: true)
  $NewBookingRequestedCopyWith<NewBookingRequested> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UpdateRequestedCopyWith<$Res> {
  factory $UpdateRequestedCopyWith(
          UpdateRequested value, $Res Function(UpdateRequested) then) =
      _$UpdateRequestedCopyWithImpl<$Res>;
}

/// @nodoc
class _$UpdateRequestedCopyWithImpl<$Res>
    extends _$BookingsEventCopyWithImpl<$Res>
    implements $UpdateRequestedCopyWith<$Res> {
  _$UpdateRequestedCopyWithImpl(
      UpdateRequested _value, $Res Function(UpdateRequested) _then)
      : super(_value, (v) => _then(v as UpdateRequested));

  @override
  UpdateRequested get _value => super._value as UpdateRequested;
}

/// @nodoc

class _$UpdateRequested
    with DiagnosticableTreeMixin
    implements UpdateRequested {
  const _$UpdateRequested();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'BookingsEvent.update()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties..add(DiagnosticsProperty('type', 'BookingsEvent.update'));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is UpdateRequested);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(Hall hall, int seatID, DateTime date, TimeRange slot)
        $default, {
    required TResult Function() update,
    required TResult Function(Booking booking) delete,
  }) {
    return update();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult Function(Hall hall, int seatID, DateTime date, TimeRange slot)?
        $default, {
    TResult Function()? update,
    TResult Function(Booking booking)? delete,
  }) {
    return update?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(Hall hall, int seatID, DateTime date, TimeRange slot)?
        $default, {
    TResult Function()? update,
    TResult Function(Booking booking)? delete,
    required TResult orElse(),
  }) {
    if (update != null) {
      return update();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(NewBookingRequested value) $default, {
    required TResult Function(UpdateRequested value) update,
    required TResult Function(DeleteRequested value) delete,
  }) {
    return update(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult Function(NewBookingRequested value)? $default, {
    TResult Function(UpdateRequested value)? update,
    TResult Function(DeleteRequested value)? delete,
  }) {
    return update?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(NewBookingRequested value)? $default, {
    TResult Function(UpdateRequested value)? update,
    TResult Function(DeleteRequested value)? delete,
    required TResult orElse(),
  }) {
    if (update != null) {
      return update(this);
    }
    return orElse();
  }
}

abstract class UpdateRequested implements BookingsEvent {
  const factory UpdateRequested() = _$UpdateRequested;
}

/// @nodoc
abstract class $DeleteRequestedCopyWith<$Res> {
  factory $DeleteRequestedCopyWith(
          DeleteRequested value, $Res Function(DeleteRequested) then) =
      _$DeleteRequestedCopyWithImpl<$Res>;
  $Res call({Booking booking});
}

/// @nodoc
class _$DeleteRequestedCopyWithImpl<$Res>
    extends _$BookingsEventCopyWithImpl<$Res>
    implements $DeleteRequestedCopyWith<$Res> {
  _$DeleteRequestedCopyWithImpl(
      DeleteRequested _value, $Res Function(DeleteRequested) _then)
      : super(_value, (v) => _then(v as DeleteRequested));

  @override
  DeleteRequested get _value => super._value as DeleteRequested;

  @override
  $Res call({
    Object? booking = freezed,
  }) {
    return _then(DeleteRequested(
      booking == freezed
          ? _value.booking
          : booking // ignore: cast_nullable_to_non_nullable
              as Booking,
    ));
  }
}

/// @nodoc

class _$DeleteRequested
    with DiagnosticableTreeMixin
    implements DeleteRequested {
  const _$DeleteRequested(this.booking);

  @override
  final Booking booking;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'BookingsEvent.delete(booking: $booking)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'BookingsEvent.delete'))
      ..add(DiagnosticsProperty('booking', booking));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is DeleteRequested &&
            const DeepCollectionEquality().equals(other.booking, booking));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(booking));

  @JsonKey(ignore: true)
  @override
  $DeleteRequestedCopyWith<DeleteRequested> get copyWith =>
      _$DeleteRequestedCopyWithImpl<DeleteRequested>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(Hall hall, int seatID, DateTime date, TimeRange slot)
        $default, {
    required TResult Function() update,
    required TResult Function(Booking booking) delete,
  }) {
    return delete(booking);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult Function(Hall hall, int seatID, DateTime date, TimeRange slot)?
        $default, {
    TResult Function()? update,
    TResult Function(Booking booking)? delete,
  }) {
    return delete?.call(booking);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(Hall hall, int seatID, DateTime date, TimeRange slot)?
        $default, {
    TResult Function()? update,
    TResult Function(Booking booking)? delete,
    required TResult orElse(),
  }) {
    if (delete != null) {
      return delete(booking);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(NewBookingRequested value) $default, {
    required TResult Function(UpdateRequested value) update,
    required TResult Function(DeleteRequested value) delete,
  }) {
    return delete(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult Function(NewBookingRequested value)? $default, {
    TResult Function(UpdateRequested value)? update,
    TResult Function(DeleteRequested value)? delete,
  }) {
    return delete?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(NewBookingRequested value)? $default, {
    TResult Function(UpdateRequested value)? update,
    TResult Function(DeleteRequested value)? delete,
    required TResult orElse(),
  }) {
    if (delete != null) {
      return delete(this);
    }
    return orElse();
  }
}

abstract class DeleteRequested implements BookingsEvent {
  const factory DeleteRequested(Booking booking) = _$DeleteRequested;

  Booking get booking;
  @JsonKey(ignore: true)
  $DeleteRequestedCopyWith<DeleteRequested> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
class _$BookingsStateTearOff {
  const _$BookingsStateTearOff();

  Showing call(List<Booking> bookings) {
    return Showing(
      bookings,
    );
  }

  Loading loading() {
    return const Loading();
  }

  Error error(String message) {
    return Error(
      message,
    );
  }
}

/// @nodoc
const $BookingsState = _$BookingsStateTearOff();

/// @nodoc
mixin _$BookingsState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(List<Booking> bookings) $default, {
    required TResult Function() loading,
    required TResult Function(String message) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult Function(List<Booking> bookings)? $default, {
    TResult Function()? loading,
    TResult Function(String message)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(List<Booking> bookings)? $default, {
    TResult Function()? loading,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(Showing value) $default, {
    required TResult Function(Loading value) loading,
    required TResult Function(Error value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult Function(Showing value)? $default, {
    TResult Function(Loading value)? loading,
    TResult Function(Error value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(Showing value)? $default, {
    TResult Function(Loading value)? loading,
    TResult Function(Error value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BookingsStateCopyWith<$Res> {
  factory $BookingsStateCopyWith(
          BookingsState value, $Res Function(BookingsState) then) =
      _$BookingsStateCopyWithImpl<$Res>;
}

/// @nodoc
class _$BookingsStateCopyWithImpl<$Res>
    implements $BookingsStateCopyWith<$Res> {
  _$BookingsStateCopyWithImpl(this._value, this._then);

  final BookingsState _value;
  // ignore: unused_field
  final $Res Function(BookingsState) _then;
}

/// @nodoc
abstract class $ShowingCopyWith<$Res> {
  factory $ShowingCopyWith(Showing value, $Res Function(Showing) then) =
      _$ShowingCopyWithImpl<$Res>;
  $Res call({List<Booking> bookings});
}

/// @nodoc
class _$ShowingCopyWithImpl<$Res> extends _$BookingsStateCopyWithImpl<$Res>
    implements $ShowingCopyWith<$Res> {
  _$ShowingCopyWithImpl(Showing _value, $Res Function(Showing) _then)
      : super(_value, (v) => _then(v as Showing));

  @override
  Showing get _value => super._value as Showing;

  @override
  $Res call({
    Object? bookings = freezed,
  }) {
    return _then(Showing(
      bookings == freezed
          ? _value.bookings
          : bookings // ignore: cast_nullable_to_non_nullable
              as List<Booking>,
    ));
  }
}

/// @nodoc

class _$Showing with DiagnosticableTreeMixin implements Showing {
  const _$Showing(this.bookings);

  @override
  final List<Booking> bookings;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'BookingsState(bookings: $bookings)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'BookingsState'))
      ..add(DiagnosticsProperty('bookings', bookings));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Showing &&
            const DeepCollectionEquality().equals(other.bookings, bookings));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(bookings));

  @JsonKey(ignore: true)
  @override
  $ShowingCopyWith<Showing> get copyWith =>
      _$ShowingCopyWithImpl<Showing>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(List<Booking> bookings) $default, {
    required TResult Function() loading,
    required TResult Function(String message) error,
  }) {
    return $default(bookings);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult Function(List<Booking> bookings)? $default, {
    TResult Function()? loading,
    TResult Function(String message)? error,
  }) {
    return $default?.call(bookings);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(List<Booking> bookings)? $default, {
    TResult Function()? loading,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(bookings);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(Showing value) $default, {
    required TResult Function(Loading value) loading,
    required TResult Function(Error value) error,
  }) {
    return $default(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult Function(Showing value)? $default, {
    TResult Function(Loading value)? loading,
    TResult Function(Error value)? error,
  }) {
    return $default?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(Showing value)? $default, {
    TResult Function(Loading value)? loading,
    TResult Function(Error value)? error,
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(this);
    }
    return orElse();
  }
}

abstract class Showing implements BookingsState {
  const factory Showing(List<Booking> bookings) = _$Showing;

  List<Booking> get bookings;
  @JsonKey(ignore: true)
  $ShowingCopyWith<Showing> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LoadingCopyWith<$Res> {
  factory $LoadingCopyWith(Loading value, $Res Function(Loading) then) =
      _$LoadingCopyWithImpl<$Res>;
}

/// @nodoc
class _$LoadingCopyWithImpl<$Res> extends _$BookingsStateCopyWithImpl<$Res>
    implements $LoadingCopyWith<$Res> {
  _$LoadingCopyWithImpl(Loading _value, $Res Function(Loading) _then)
      : super(_value, (v) => _then(v as Loading));

  @override
  Loading get _value => super._value as Loading;
}

/// @nodoc

class _$Loading with DiagnosticableTreeMixin implements Loading {
  const _$Loading();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'BookingsState.loading()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties..add(DiagnosticsProperty('type', 'BookingsState.loading'));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is Loading);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(List<Booking> bookings) $default, {
    required TResult Function() loading,
    required TResult Function(String message) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult Function(List<Booking> bookings)? $default, {
    TResult Function()? loading,
    TResult Function(String message)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(List<Booking> bookings)? $default, {
    TResult Function()? loading,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(Showing value) $default, {
    required TResult Function(Loading value) loading,
    required TResult Function(Error value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult Function(Showing value)? $default, {
    TResult Function(Loading value)? loading,
    TResult Function(Error value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(Showing value)? $default, {
    TResult Function(Loading value)? loading,
    TResult Function(Error value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class Loading implements BookingsState {
  const factory Loading() = _$Loading;
}

/// @nodoc
abstract class $ErrorCopyWith<$Res> {
  factory $ErrorCopyWith(Error value, $Res Function(Error) then) =
      _$ErrorCopyWithImpl<$Res>;
  $Res call({String message});
}

/// @nodoc
class _$ErrorCopyWithImpl<$Res> extends _$BookingsStateCopyWithImpl<$Res>
    implements $ErrorCopyWith<$Res> {
  _$ErrorCopyWithImpl(Error _value, $Res Function(Error) _then)
      : super(_value, (v) => _then(v as Error));

  @override
  Error get _value => super._value as Error;

  @override
  $Res call({
    Object? message = freezed,
  }) {
    return _then(Error(
      message == freezed
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$Error with DiagnosticableTreeMixin implements Error {
  const _$Error(this.message);

  @override
  final String message;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'BookingsState.error(message: $message)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'BookingsState.error'))
      ..add(DiagnosticsProperty('message', message));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Error &&
            const DeepCollectionEquality().equals(other.message, message));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(message));

  @JsonKey(ignore: true)
  @override
  $ErrorCopyWith<Error> get copyWith =>
      _$ErrorCopyWithImpl<Error>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(List<Booking> bookings) $default, {
    required TResult Function() loading,
    required TResult Function(String message) error,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult Function(List<Booking> bookings)? $default, {
    TResult Function()? loading,
    TResult Function(String message)? error,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(List<Booking> bookings)? $default, {
    TResult Function()? loading,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(Showing value) $default, {
    required TResult Function(Loading value) loading,
    required TResult Function(Error value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult Function(Showing value)? $default, {
    TResult Function(Loading value)? loading,
    TResult Function(Error value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(Showing value)? $default, {
    TResult Function(Loading value)? loading,
    TResult Function(Error value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class Error implements BookingsState {
  const factory Error(String message) = _$Error;

  String get message;
  @JsonKey(ignore: true)
  $ErrorCopyWith<Error> get copyWith => throw _privateConstructorUsedError;
}
