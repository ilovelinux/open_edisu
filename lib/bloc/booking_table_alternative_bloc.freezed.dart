// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'booking_table_alternative_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$BookingTableAlternativeEventTearOff {
  const _$BookingTableAlternativeEventTearOff();

  SelectRequested call(Seat seat, int row) {
    return SelectRequested(
      seat,
      row,
    );
  }
}

/// @nodoc
const $BookingTableAlternativeEvent = _$BookingTableAlternativeEventTearOff();

/// @nodoc
mixin _$BookingTableAlternativeEvent {
  Seat get seat => throw _privateConstructorUsedError;
  int get row => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $BookingTableAlternativeEventCopyWith<BookingTableAlternativeEvent>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BookingTableAlternativeEventCopyWith<$Res> {
  factory $BookingTableAlternativeEventCopyWith(
          BookingTableAlternativeEvent value,
          $Res Function(BookingTableAlternativeEvent) then) =
      _$BookingTableAlternativeEventCopyWithImpl<$Res>;
  $Res call({Seat seat, int row});
}

/// @nodoc
class _$BookingTableAlternativeEventCopyWithImpl<$Res>
    implements $BookingTableAlternativeEventCopyWith<$Res> {
  _$BookingTableAlternativeEventCopyWithImpl(this._value, this._then);

  final BookingTableAlternativeEvent _value;
  // ignore: unused_field
  final $Res Function(BookingTableAlternativeEvent) _then;

  @override
  $Res call({
    Object? seat = freezed,
    Object? row = freezed,
  }) {
    return _then(_value.copyWith(
      seat: seat == freezed
          ? _value.seat
          : seat // ignore: cast_nullable_to_non_nullable
              as Seat,
      row: row == freezed
          ? _value.row
          : row // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
abstract class $SelectRequestedCopyWith<$Res>
    implements $BookingTableAlternativeEventCopyWith<$Res> {
  factory $SelectRequestedCopyWith(
          SelectRequested value, $Res Function(SelectRequested) then) =
      _$SelectRequestedCopyWithImpl<$Res>;
  @override
  $Res call({Seat seat, int row});
}

/// @nodoc
class _$SelectRequestedCopyWithImpl<$Res>
    extends _$BookingTableAlternativeEventCopyWithImpl<$Res>
    implements $SelectRequestedCopyWith<$Res> {
  _$SelectRequestedCopyWithImpl(
      SelectRequested _value, $Res Function(SelectRequested) _then)
      : super(_value, (v) => _then(v as SelectRequested));

  @override
  SelectRequested get _value => super._value as SelectRequested;

  @override
  $Res call({
    Object? seat = freezed,
    Object? row = freezed,
  }) {
    return _then(SelectRequested(
      seat == freezed
          ? _value.seat
          : seat // ignore: cast_nullable_to_non_nullable
              as Seat,
      row == freezed
          ? _value.row
          : row // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$SelectRequested
    with DiagnosticableTreeMixin
    implements SelectRequested {
  const _$SelectRequested(this.seat, this.row);

  @override
  final Seat seat;
  @override
  final int row;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'BookingTableAlternativeEvent(seat: $seat, row: $row)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'BookingTableAlternativeEvent'))
      ..add(DiagnosticsProperty('seat', seat))
      ..add(DiagnosticsProperty('row', row));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SelectRequested &&
            const DeepCollectionEquality().equals(other.seat, seat) &&
            const DeepCollectionEquality().equals(other.row, row));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(seat),
      const DeepCollectionEquality().hash(row));

  @JsonKey(ignore: true)
  @override
  $SelectRequestedCopyWith<SelectRequested> get copyWith =>
      _$SelectRequestedCopyWithImpl<SelectRequested>(this, _$identity);
}

abstract class SelectRequested implements BookingTableAlternativeEvent {
  const factory SelectRequested(Seat seat, int row) = _$SelectRequested;

  @override
  Seat get seat;
  @override
  int get row;
  @override
  @JsonKey(ignore: true)
  $SelectRequestedCopyWith<SelectRequested> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
class _$BookingTableAlternativeStateTearOff {
  const _$BookingTableAlternativeStateTearOff();

  Selected call(int row, TimeOfDay startTime, TimeOfDay endTime) {
    return Selected(
      row,
      startTime,
      endTime,
    );
  }

  Unselected unselected() {
    return const Unselected();
  }
}

/// @nodoc
const $BookingTableAlternativeState = _$BookingTableAlternativeStateTearOff();

/// @nodoc
mixin _$BookingTableAlternativeState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(int row, TimeOfDay startTime, TimeOfDay endTime)
        $default, {
    required TResult Function() unselected,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult Function(int row, TimeOfDay startTime, TimeOfDay endTime)?
        $default, {
    TResult Function()? unselected,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(int row, TimeOfDay startTime, TimeOfDay endTime)?
        $default, {
    TResult Function()? unselected,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(Selected value) $default, {
    required TResult Function(Unselected value) unselected,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult Function(Selected value)? $default, {
    TResult Function(Unselected value)? unselected,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(Selected value)? $default, {
    TResult Function(Unselected value)? unselected,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BookingTableAlternativeStateCopyWith<$Res> {
  factory $BookingTableAlternativeStateCopyWith(
          BookingTableAlternativeState value,
          $Res Function(BookingTableAlternativeState) then) =
      _$BookingTableAlternativeStateCopyWithImpl<$Res>;
}

/// @nodoc
class _$BookingTableAlternativeStateCopyWithImpl<$Res>
    implements $BookingTableAlternativeStateCopyWith<$Res> {
  _$BookingTableAlternativeStateCopyWithImpl(this._value, this._then);

  final BookingTableAlternativeState _value;
  // ignore: unused_field
  final $Res Function(BookingTableAlternativeState) _then;
}

/// @nodoc
abstract class $SelectedCopyWith<$Res> {
  factory $SelectedCopyWith(Selected value, $Res Function(Selected) then) =
      _$SelectedCopyWithImpl<$Res>;
  $Res call({int row, TimeOfDay startTime, TimeOfDay endTime});
}

/// @nodoc
class _$SelectedCopyWithImpl<$Res>
    extends _$BookingTableAlternativeStateCopyWithImpl<$Res>
    implements $SelectedCopyWith<$Res> {
  _$SelectedCopyWithImpl(Selected _value, $Res Function(Selected) _then)
      : super(_value, (v) => _then(v as Selected));

  @override
  Selected get _value => super._value as Selected;

  @override
  $Res call({
    Object? row = freezed,
    Object? startTime = freezed,
    Object? endTime = freezed,
  }) {
    return _then(Selected(
      row == freezed
          ? _value.row
          : row // ignore: cast_nullable_to_non_nullable
              as int,
      startTime == freezed
          ? _value.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as TimeOfDay,
      endTime == freezed
          ? _value.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as TimeOfDay,
    ));
  }
}

/// @nodoc

class _$Selected with DiagnosticableTreeMixin implements Selected {
  const _$Selected(this.row, this.startTime, this.endTime);

  @override
  final int row;
  @override
  final TimeOfDay startTime;
  @override
  final TimeOfDay endTime;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'BookingTableAlternativeState(row: $row, startTime: $startTime, endTime: $endTime)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'BookingTableAlternativeState'))
      ..add(DiagnosticsProperty('row', row))
      ..add(DiagnosticsProperty('startTime', startTime))
      ..add(DiagnosticsProperty('endTime', endTime));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Selected &&
            const DeepCollectionEquality().equals(other.row, row) &&
            const DeepCollectionEquality().equals(other.startTime, startTime) &&
            const DeepCollectionEquality().equals(other.endTime, endTime));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(row),
      const DeepCollectionEquality().hash(startTime),
      const DeepCollectionEquality().hash(endTime));

  @JsonKey(ignore: true)
  @override
  $SelectedCopyWith<Selected> get copyWith =>
      _$SelectedCopyWithImpl<Selected>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(int row, TimeOfDay startTime, TimeOfDay endTime)
        $default, {
    required TResult Function() unselected,
  }) {
    return $default(row, startTime, endTime);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult Function(int row, TimeOfDay startTime, TimeOfDay endTime)?
        $default, {
    TResult Function()? unselected,
  }) {
    return $default?.call(row, startTime, endTime);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(int row, TimeOfDay startTime, TimeOfDay endTime)?
        $default, {
    TResult Function()? unselected,
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(row, startTime, endTime);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(Selected value) $default, {
    required TResult Function(Unselected value) unselected,
  }) {
    return $default(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult Function(Selected value)? $default, {
    TResult Function(Unselected value)? unselected,
  }) {
    return $default?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(Selected value)? $default, {
    TResult Function(Unselected value)? unselected,
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(this);
    }
    return orElse();
  }
}

abstract class Selected implements BookingTableAlternativeState {
  const factory Selected(int row, TimeOfDay startTime, TimeOfDay endTime) =
      _$Selected;

  int get row;
  TimeOfDay get startTime;
  TimeOfDay get endTime;
  @JsonKey(ignore: true)
  $SelectedCopyWith<Selected> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UnselectedCopyWith<$Res> {
  factory $UnselectedCopyWith(
          Unselected value, $Res Function(Unselected) then) =
      _$UnselectedCopyWithImpl<$Res>;
}

/// @nodoc
class _$UnselectedCopyWithImpl<$Res>
    extends _$BookingTableAlternativeStateCopyWithImpl<$Res>
    implements $UnselectedCopyWith<$Res> {
  _$UnselectedCopyWithImpl(Unselected _value, $Res Function(Unselected) _then)
      : super(_value, (v) => _then(v as Unselected));

  @override
  Unselected get _value => super._value as Unselected;
}

/// @nodoc

class _$Unselected with DiagnosticableTreeMixin implements Unselected {
  const _$Unselected();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'BookingTableAlternativeState.unselected()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty(
          'type', 'BookingTableAlternativeState.unselected'));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is Unselected);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(int row, TimeOfDay startTime, TimeOfDay endTime)
        $default, {
    required TResult Function() unselected,
  }) {
    return unselected();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult Function(int row, TimeOfDay startTime, TimeOfDay endTime)?
        $default, {
    TResult Function()? unselected,
  }) {
    return unselected?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(int row, TimeOfDay startTime, TimeOfDay endTime)?
        $default, {
    TResult Function()? unselected,
    required TResult orElse(),
  }) {
    if (unselected != null) {
      return unselected();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(Selected value) $default, {
    required TResult Function(Unselected value) unselected,
  }) {
    return unselected(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult Function(Selected value)? $default, {
    TResult Function(Unselected value)? unselected,
  }) {
    return unselected?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(Selected value)? $default, {
    TResult Function(Unselected value)? unselected,
    required TResult orElse(),
  }) {
    if (unselected != null) {
      return unselected(this);
    }
    return orElse();
  }
}

abstract class Unselected implements BookingTableAlternativeState {
  const factory Unselected() = _$Unselected;
}
