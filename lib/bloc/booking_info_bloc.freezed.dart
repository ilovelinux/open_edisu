// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'booking_info_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$BookingInfoState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(BookingsPerSeats bookingsPerSeat) $default, {
    required TResult Function(List<Slot> slots, List<Seats> seats) alternative,
    required TResult Function() update,
    required TResult Function() loading,
    required TResult Function(String message) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult Function(BookingsPerSeats bookingsPerSeat)? $default, {
    TResult Function(List<Slot> slots, List<Seats> seats)? alternative,
    TResult Function()? update,
    TResult Function()? loading,
    TResult Function(String message)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(BookingsPerSeats bookingsPerSeat)? $default, {
    TResult Function(List<Slot> slots, List<Seats> seats)? alternative,
    TResult Function()? update,
    TResult Function()? loading,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(Showing value) $default, {
    required TResult Function(ShowingAlternative value) alternative,
    required TResult Function(Update value) update,
    required TResult Function(Loading value) loading,
    required TResult Function(ErrorDetails value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult Function(Showing value)? $default, {
    TResult Function(ShowingAlternative value)? alternative,
    TResult Function(Update value)? update,
    TResult Function(Loading value)? loading,
    TResult Function(ErrorDetails value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(Showing value)? $default, {
    TResult Function(ShowingAlternative value)? alternative,
    TResult Function(Update value)? update,
    TResult Function(Loading value)? loading,
    TResult Function(ErrorDetails value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BookingInfoStateCopyWith<$Res> {
  factory $BookingInfoStateCopyWith(
          BookingInfoState value, $Res Function(BookingInfoState) then) =
      _$BookingInfoStateCopyWithImpl<$Res>;
}

/// @nodoc
class _$BookingInfoStateCopyWithImpl<$Res>
    implements $BookingInfoStateCopyWith<$Res> {
  _$BookingInfoStateCopyWithImpl(this._value, this._then);

  final BookingInfoState _value;
  // ignore: unused_field
  final $Res Function(BookingInfoState) _then;
}

/// @nodoc
abstract class $ShowingCopyWith<$Res> {
  factory $ShowingCopyWith(Showing value, $Res Function(Showing) then) =
      _$ShowingCopyWithImpl<$Res>;
  $Res call({BookingsPerSeats bookingsPerSeat});
}

/// @nodoc
class _$ShowingCopyWithImpl<$Res> extends _$BookingInfoStateCopyWithImpl<$Res>
    implements $ShowingCopyWith<$Res> {
  _$ShowingCopyWithImpl(Showing _value, $Res Function(Showing) _then)
      : super(_value, (v) => _then(v as Showing));

  @override
  Showing get _value => super._value as Showing;

  @override
  $Res call({
    Object? bookingsPerSeat = freezed,
  }) {
    return _then(Showing(
      bookingsPerSeat == freezed
          ? _value.bookingsPerSeat
          : bookingsPerSeat // ignore: cast_nullable_to_non_nullable
              as BookingsPerSeats,
    ));
  }
}

/// @nodoc

class _$Showing with DiagnosticableTreeMixin implements Showing {
  const _$Showing(this.bookingsPerSeat);

  @override
  final BookingsPerSeats bookingsPerSeat;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'BookingInfoState(bookingsPerSeat: $bookingsPerSeat)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'BookingInfoState'))
      ..add(DiagnosticsProperty('bookingsPerSeat', bookingsPerSeat));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Showing &&
            const DeepCollectionEquality()
                .equals(other.bookingsPerSeat, bookingsPerSeat));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(bookingsPerSeat));

  @JsonKey(ignore: true)
  @override
  $ShowingCopyWith<Showing> get copyWith =>
      _$ShowingCopyWithImpl<Showing>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(BookingsPerSeats bookingsPerSeat) $default, {
    required TResult Function(List<Slot> slots, List<Seats> seats) alternative,
    required TResult Function() update,
    required TResult Function() loading,
    required TResult Function(String message) error,
  }) {
    return $default(bookingsPerSeat);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult Function(BookingsPerSeats bookingsPerSeat)? $default, {
    TResult Function(List<Slot> slots, List<Seats> seats)? alternative,
    TResult Function()? update,
    TResult Function()? loading,
    TResult Function(String message)? error,
  }) {
    return $default?.call(bookingsPerSeat);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(BookingsPerSeats bookingsPerSeat)? $default, {
    TResult Function(List<Slot> slots, List<Seats> seats)? alternative,
    TResult Function()? update,
    TResult Function()? loading,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(bookingsPerSeat);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(Showing value) $default, {
    required TResult Function(ShowingAlternative value) alternative,
    required TResult Function(Update value) update,
    required TResult Function(Loading value) loading,
    required TResult Function(ErrorDetails value) error,
  }) {
    return $default(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult Function(Showing value)? $default, {
    TResult Function(ShowingAlternative value)? alternative,
    TResult Function(Update value)? update,
    TResult Function(Loading value)? loading,
    TResult Function(ErrorDetails value)? error,
  }) {
    return $default?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(Showing value)? $default, {
    TResult Function(ShowingAlternative value)? alternative,
    TResult Function(Update value)? update,
    TResult Function(Loading value)? loading,
    TResult Function(ErrorDetails value)? error,
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(this);
    }
    return orElse();
  }
}

abstract class Showing implements BookingInfoState {
  const factory Showing(final BookingsPerSeats bookingsPerSeat) = _$Showing;

  BookingsPerSeats get bookingsPerSeat => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ShowingCopyWith<Showing> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ShowingAlternativeCopyWith<$Res> {
  factory $ShowingAlternativeCopyWith(
          ShowingAlternative value, $Res Function(ShowingAlternative) then) =
      _$ShowingAlternativeCopyWithImpl<$Res>;
  $Res call({List<Slot> slots, List<Seats> seats});
}

/// @nodoc
class _$ShowingAlternativeCopyWithImpl<$Res>
    extends _$BookingInfoStateCopyWithImpl<$Res>
    implements $ShowingAlternativeCopyWith<$Res> {
  _$ShowingAlternativeCopyWithImpl(
      ShowingAlternative _value, $Res Function(ShowingAlternative) _then)
      : super(_value, (v) => _then(v as ShowingAlternative));

  @override
  ShowingAlternative get _value => super._value as ShowingAlternative;

  @override
  $Res call({
    Object? slots = freezed,
    Object? seats = freezed,
  }) {
    return _then(ShowingAlternative(
      slots == freezed
          ? _value.slots
          : slots // ignore: cast_nullable_to_non_nullable
              as List<Slot>,
      seats == freezed
          ? _value.seats
          : seats // ignore: cast_nullable_to_non_nullable
              as List<Seats>,
    ));
  }
}

/// @nodoc

class _$ShowingAlternative
    with DiagnosticableTreeMixin
    implements ShowingAlternative {
  const _$ShowingAlternative(final List<Slot> slots, final List<Seats> seats)
      : _slots = slots,
        _seats = seats;

  final List<Slot> _slots;
  @override
  List<Slot> get slots {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_slots);
  }

  final List<Seats> _seats;
  @override
  List<Seats> get seats {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_seats);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'BookingInfoState.alternative(slots: $slots, seats: $seats)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'BookingInfoState.alternative'))
      ..add(DiagnosticsProperty('slots', slots))
      ..add(DiagnosticsProperty('seats', seats));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ShowingAlternative &&
            const DeepCollectionEquality().equals(other.slots, slots) &&
            const DeepCollectionEquality().equals(other.seats, seats));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(slots),
      const DeepCollectionEquality().hash(seats));

  @JsonKey(ignore: true)
  @override
  $ShowingAlternativeCopyWith<ShowingAlternative> get copyWith =>
      _$ShowingAlternativeCopyWithImpl<ShowingAlternative>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(BookingsPerSeats bookingsPerSeat) $default, {
    required TResult Function(List<Slot> slots, List<Seats> seats) alternative,
    required TResult Function() update,
    required TResult Function() loading,
    required TResult Function(String message) error,
  }) {
    return alternative(slots, seats);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult Function(BookingsPerSeats bookingsPerSeat)? $default, {
    TResult Function(List<Slot> slots, List<Seats> seats)? alternative,
    TResult Function()? update,
    TResult Function()? loading,
    TResult Function(String message)? error,
  }) {
    return alternative?.call(slots, seats);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(BookingsPerSeats bookingsPerSeat)? $default, {
    TResult Function(List<Slot> slots, List<Seats> seats)? alternative,
    TResult Function()? update,
    TResult Function()? loading,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (alternative != null) {
      return alternative(slots, seats);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(Showing value) $default, {
    required TResult Function(ShowingAlternative value) alternative,
    required TResult Function(Update value) update,
    required TResult Function(Loading value) loading,
    required TResult Function(ErrorDetails value) error,
  }) {
    return alternative(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult Function(Showing value)? $default, {
    TResult Function(ShowingAlternative value)? alternative,
    TResult Function(Update value)? update,
    TResult Function(Loading value)? loading,
    TResult Function(ErrorDetails value)? error,
  }) {
    return alternative?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(Showing value)? $default, {
    TResult Function(ShowingAlternative value)? alternative,
    TResult Function(Update value)? update,
    TResult Function(Loading value)? loading,
    TResult Function(ErrorDetails value)? error,
    required TResult orElse(),
  }) {
    if (alternative != null) {
      return alternative(this);
    }
    return orElse();
  }
}

abstract class ShowingAlternative implements BookingInfoState {
  const factory ShowingAlternative(
      final List<Slot> slots, final List<Seats> seats) = _$ShowingAlternative;

  List<Slot> get slots => throw _privateConstructorUsedError;
  List<Seats> get seats => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ShowingAlternativeCopyWith<ShowingAlternative> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UpdateCopyWith<$Res> {
  factory $UpdateCopyWith(Update value, $Res Function(Update) then) =
      _$UpdateCopyWithImpl<$Res>;
}

/// @nodoc
class _$UpdateCopyWithImpl<$Res> extends _$BookingInfoStateCopyWithImpl<$Res>
    implements $UpdateCopyWith<$Res> {
  _$UpdateCopyWithImpl(Update _value, $Res Function(Update) _then)
      : super(_value, (v) => _then(v as Update));

  @override
  Update get _value => super._value as Update;
}

/// @nodoc

class _$Update with DiagnosticableTreeMixin implements Update {
  const _$Update();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'BookingInfoState.update()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('type', 'BookingInfoState.update'));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is Update);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(BookingsPerSeats bookingsPerSeat) $default, {
    required TResult Function(List<Slot> slots, List<Seats> seats) alternative,
    required TResult Function() update,
    required TResult Function() loading,
    required TResult Function(String message) error,
  }) {
    return update();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult Function(BookingsPerSeats bookingsPerSeat)? $default, {
    TResult Function(List<Slot> slots, List<Seats> seats)? alternative,
    TResult Function()? update,
    TResult Function()? loading,
    TResult Function(String message)? error,
  }) {
    return update?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(BookingsPerSeats bookingsPerSeat)? $default, {
    TResult Function(List<Slot> slots, List<Seats> seats)? alternative,
    TResult Function()? update,
    TResult Function()? loading,
    TResult Function(String message)? error,
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
    TResult Function(Showing value) $default, {
    required TResult Function(ShowingAlternative value) alternative,
    required TResult Function(Update value) update,
    required TResult Function(Loading value) loading,
    required TResult Function(ErrorDetails value) error,
  }) {
    return update(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult Function(Showing value)? $default, {
    TResult Function(ShowingAlternative value)? alternative,
    TResult Function(Update value)? update,
    TResult Function(Loading value)? loading,
    TResult Function(ErrorDetails value)? error,
  }) {
    return update?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(Showing value)? $default, {
    TResult Function(ShowingAlternative value)? alternative,
    TResult Function(Update value)? update,
    TResult Function(Loading value)? loading,
    TResult Function(ErrorDetails value)? error,
    required TResult orElse(),
  }) {
    if (update != null) {
      return update(this);
    }
    return orElse();
  }
}

abstract class Update implements BookingInfoState {
  const factory Update() = _$Update;
}

/// @nodoc
abstract class $LoadingCopyWith<$Res> {
  factory $LoadingCopyWith(Loading value, $Res Function(Loading) then) =
      _$LoadingCopyWithImpl<$Res>;
}

/// @nodoc
class _$LoadingCopyWithImpl<$Res> extends _$BookingInfoStateCopyWithImpl<$Res>
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
    return 'BookingInfoState.loading()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('type', 'BookingInfoState.loading'));
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
    TResult Function(BookingsPerSeats bookingsPerSeat) $default, {
    required TResult Function(List<Slot> slots, List<Seats> seats) alternative,
    required TResult Function() update,
    required TResult Function() loading,
    required TResult Function(String message) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult Function(BookingsPerSeats bookingsPerSeat)? $default, {
    TResult Function(List<Slot> slots, List<Seats> seats)? alternative,
    TResult Function()? update,
    TResult Function()? loading,
    TResult Function(String message)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(BookingsPerSeats bookingsPerSeat)? $default, {
    TResult Function(List<Slot> slots, List<Seats> seats)? alternative,
    TResult Function()? update,
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
    required TResult Function(ShowingAlternative value) alternative,
    required TResult Function(Update value) update,
    required TResult Function(Loading value) loading,
    required TResult Function(ErrorDetails value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult Function(Showing value)? $default, {
    TResult Function(ShowingAlternative value)? alternative,
    TResult Function(Update value)? update,
    TResult Function(Loading value)? loading,
    TResult Function(ErrorDetails value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(Showing value)? $default, {
    TResult Function(ShowingAlternative value)? alternative,
    TResult Function(Update value)? update,
    TResult Function(Loading value)? loading,
    TResult Function(ErrorDetails value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class Loading implements BookingInfoState {
  const factory Loading() = _$Loading;
}

/// @nodoc
abstract class $ErrorDetailsCopyWith<$Res> {
  factory $ErrorDetailsCopyWith(
          ErrorDetails value, $Res Function(ErrorDetails) then) =
      _$ErrorDetailsCopyWithImpl<$Res>;
  $Res call({String message});
}

/// @nodoc
class _$ErrorDetailsCopyWithImpl<$Res>
    extends _$BookingInfoStateCopyWithImpl<$Res>
    implements $ErrorDetailsCopyWith<$Res> {
  _$ErrorDetailsCopyWithImpl(
      ErrorDetails _value, $Res Function(ErrorDetails) _then)
      : super(_value, (v) => _then(v as ErrorDetails));

  @override
  ErrorDetails get _value => super._value as ErrorDetails;

  @override
  $Res call({
    Object? message = freezed,
  }) {
    return _then(ErrorDetails(
      message == freezed
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$ErrorDetails with DiagnosticableTreeMixin implements ErrorDetails {
  const _$ErrorDetails(this.message);

  @override
  final String message;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'BookingInfoState.error(message: $message)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'BookingInfoState.error'))
      ..add(DiagnosticsProperty('message', message));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ErrorDetails &&
            const DeepCollectionEquality().equals(other.message, message));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(message));

  @JsonKey(ignore: true)
  @override
  $ErrorDetailsCopyWith<ErrorDetails> get copyWith =>
      _$ErrorDetailsCopyWithImpl<ErrorDetails>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(BookingsPerSeats bookingsPerSeat) $default, {
    required TResult Function(List<Slot> slots, List<Seats> seats) alternative,
    required TResult Function() update,
    required TResult Function() loading,
    required TResult Function(String message) error,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult Function(BookingsPerSeats bookingsPerSeat)? $default, {
    TResult Function(List<Slot> slots, List<Seats> seats)? alternative,
    TResult Function()? update,
    TResult Function()? loading,
    TResult Function(String message)? error,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(BookingsPerSeats bookingsPerSeat)? $default, {
    TResult Function(List<Slot> slots, List<Seats> seats)? alternative,
    TResult Function()? update,
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
    required TResult Function(ShowingAlternative value) alternative,
    required TResult Function(Update value) update,
    required TResult Function(Loading value) loading,
    required TResult Function(ErrorDetails value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult Function(Showing value)? $default, {
    TResult Function(ShowingAlternative value)? alternative,
    TResult Function(Update value)? update,
    TResult Function(Loading value)? loading,
    TResult Function(ErrorDetails value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(Showing value)? $default, {
    TResult Function(ShowingAlternative value)? alternative,
    TResult Function(Update value)? update,
    TResult Function(Loading value)? loading,
    TResult Function(ErrorDetails value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class ErrorDetails implements BookingInfoState {
  const factory ErrorDetails(final String message) = _$ErrorDetails;

  String get message => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ErrorDetailsCopyWith<ErrorDetails> get copyWith =>
      throw _privateConstructorUsedError;
}
