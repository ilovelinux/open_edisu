// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'booking_table_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$BookingTableEvent {
  BookedSeat get seat => throw _privateConstructorUsedError;
  TimeRange get slot => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $BookingTableEventCopyWith<BookingTableEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BookingTableEventCopyWith<$Res> {
  factory $BookingTableEventCopyWith(
          BookingTableEvent value, $Res Function(BookingTableEvent) then) =
      _$BookingTableEventCopyWithImpl<$Res>;
  $Res call({BookedSeat seat, TimeRange slot});
}

/// @nodoc
class _$BookingTableEventCopyWithImpl<$Res>
    implements $BookingTableEventCopyWith<$Res> {
  _$BookingTableEventCopyWithImpl(this._value, this._then);

  final BookingTableEvent _value;
  // ignore: unused_field
  final $Res Function(BookingTableEvent) _then;

  @override
  $Res call({
    Object? seat = freezed,
    Object? slot = freezed,
  }) {
    return _then(_value.copyWith(
      seat: seat == freezed
          ? _value.seat
          : seat // ignore: cast_nullable_to_non_nullable
              as BookedSeat,
      slot: slot == freezed
          ? _value.slot
          : slot // ignore: cast_nullable_to_non_nullable
              as TimeRange,
    ));
  }
}

/// @nodoc
abstract class _$$SelectRequestedCopyWith<$Res>
    implements $BookingTableEventCopyWith<$Res> {
  factory _$$SelectRequestedCopyWith(
          _$SelectRequested value, $Res Function(_$SelectRequested) then) =
      __$$SelectRequestedCopyWithImpl<$Res>;
  @override
  $Res call({BookedSeat seat, TimeRange slot});
}

/// @nodoc
class __$$SelectRequestedCopyWithImpl<$Res>
    extends _$BookingTableEventCopyWithImpl<$Res>
    implements _$$SelectRequestedCopyWith<$Res> {
  __$$SelectRequestedCopyWithImpl(
      _$SelectRequested _value, $Res Function(_$SelectRequested) _then)
      : super(_value, (v) => _then(v as _$SelectRequested));

  @override
  _$SelectRequested get _value => super._value as _$SelectRequested;

  @override
  $Res call({
    Object? seat = freezed,
    Object? slot = freezed,
  }) {
    return _then(_$SelectRequested(
      seat == freezed
          ? _value.seat
          : seat // ignore: cast_nullable_to_non_nullable
              as BookedSeat,
      slot == freezed
          ? _value.slot
          : slot // ignore: cast_nullable_to_non_nullable
              as TimeRange,
    ));
  }
}

/// @nodoc

class _$SelectRequested
    with DiagnosticableTreeMixin
    implements SelectRequested {
  const _$SelectRequested(this.seat, this.slot);

  @override
  final BookedSeat seat;
  @override
  final TimeRange slot;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'BookingTableEvent(seat: $seat, slot: $slot)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'BookingTableEvent'))
      ..add(DiagnosticsProperty('seat', seat))
      ..add(DiagnosticsProperty('slot', slot));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SelectRequested &&
            const DeepCollectionEquality().equals(other.seat, seat) &&
            const DeepCollectionEquality().equals(other.slot, slot));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(seat),
      const DeepCollectionEquality().hash(slot));

  @JsonKey(ignore: true)
  @override
  _$$SelectRequestedCopyWith<_$SelectRequested> get copyWith =>
      __$$SelectRequestedCopyWithImpl<_$SelectRequested>(this, _$identity);
}

abstract class SelectRequested implements BookingTableEvent {
  const factory SelectRequested(final BookedSeat seat, final TimeRange slot) =
      _$SelectRequested;

  @override
  BookedSeat get seat => throw _privateConstructorUsedError;
  @override
  TimeRange get slot => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$SelectRequestedCopyWith<_$SelectRequested> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$BookingTableState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(BookedSeat seat, TimeRange slot) $default, {
    required TResult Function() unselected,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult Function(BookedSeat seat, TimeRange slot)? $default, {
    TResult Function()? unselected,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(BookedSeat seat, TimeRange slot)? $default, {
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
abstract class $BookingTableStateCopyWith<$Res> {
  factory $BookingTableStateCopyWith(
          BookingTableState value, $Res Function(BookingTableState) then) =
      _$BookingTableStateCopyWithImpl<$Res>;
}

/// @nodoc
class _$BookingTableStateCopyWithImpl<$Res>
    implements $BookingTableStateCopyWith<$Res> {
  _$BookingTableStateCopyWithImpl(this._value, this._then);

  final BookingTableState _value;
  // ignore: unused_field
  final $Res Function(BookingTableState) _then;
}

/// @nodoc
abstract class _$$SelectedCopyWith<$Res> {
  factory _$$SelectedCopyWith(
          _$Selected value, $Res Function(_$Selected) then) =
      __$$SelectedCopyWithImpl<$Res>;
  $Res call({BookedSeat seat, TimeRange slot});
}

/// @nodoc
class __$$SelectedCopyWithImpl<$Res>
    extends _$BookingTableStateCopyWithImpl<$Res>
    implements _$$SelectedCopyWith<$Res> {
  __$$SelectedCopyWithImpl(_$Selected _value, $Res Function(_$Selected) _then)
      : super(_value, (v) => _then(v as _$Selected));

  @override
  _$Selected get _value => super._value as _$Selected;

  @override
  $Res call({
    Object? seat = freezed,
    Object? slot = freezed,
  }) {
    return _then(_$Selected(
      seat == freezed
          ? _value.seat
          : seat // ignore: cast_nullable_to_non_nullable
              as BookedSeat,
      slot == freezed
          ? _value.slot
          : slot // ignore: cast_nullable_to_non_nullable
              as TimeRange,
    ));
  }
}

/// @nodoc

class _$Selected with DiagnosticableTreeMixin implements Selected {
  const _$Selected(this.seat, this.slot);

  @override
  final BookedSeat seat;
  @override
  final TimeRange slot;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'BookingTableState(seat: $seat, slot: $slot)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'BookingTableState'))
      ..add(DiagnosticsProperty('seat', seat))
      ..add(DiagnosticsProperty('slot', slot));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$Selected &&
            const DeepCollectionEquality().equals(other.seat, seat) &&
            const DeepCollectionEquality().equals(other.slot, slot));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(seat),
      const DeepCollectionEquality().hash(slot));

  @JsonKey(ignore: true)
  @override
  _$$SelectedCopyWith<_$Selected> get copyWith =>
      __$$SelectedCopyWithImpl<_$Selected>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(BookedSeat seat, TimeRange slot) $default, {
    required TResult Function() unselected,
  }) {
    return $default(seat, slot);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult Function(BookedSeat seat, TimeRange slot)? $default, {
    TResult Function()? unselected,
  }) {
    return $default?.call(seat, slot);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(BookedSeat seat, TimeRange slot)? $default, {
    TResult Function()? unselected,
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(seat, slot);
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

abstract class Selected implements BookingTableState {
  const factory Selected(final BookedSeat seat, final TimeRange slot) =
      _$Selected;

  BookedSeat get seat => throw _privateConstructorUsedError;
  TimeRange get slot => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  _$$SelectedCopyWith<_$Selected> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UnselectedCopyWith<$Res> {
  factory _$$UnselectedCopyWith(
          _$Unselected value, $Res Function(_$Unselected) then) =
      __$$UnselectedCopyWithImpl<$Res>;
}

/// @nodoc
class __$$UnselectedCopyWithImpl<$Res>
    extends _$BookingTableStateCopyWithImpl<$Res>
    implements _$$UnselectedCopyWith<$Res> {
  __$$UnselectedCopyWithImpl(
      _$Unselected _value, $Res Function(_$Unselected) _then)
      : super(_value, (v) => _then(v as _$Unselected));

  @override
  _$Unselected get _value => super._value as _$Unselected;
}

/// @nodoc

class _$Unselected with DiagnosticableTreeMixin implements Unselected {
  const _$Unselected();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'BookingTableState.unselected()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('type', 'BookingTableState.unselected'));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$Unselected);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(BookedSeat seat, TimeRange slot) $default, {
    required TResult Function() unselected,
  }) {
    return unselected();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult Function(BookedSeat seat, TimeRange slot)? $default, {
    TResult Function()? unselected,
  }) {
    return unselected?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(BookedSeat seat, TimeRange slot)? $default, {
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

abstract class Unselected implements BookingTableState {
  const factory Unselected() = _$Unselected;
}
