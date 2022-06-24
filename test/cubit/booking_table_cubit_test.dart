import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:open_edisu/cubit/booking_table_cubit.dart';
import 'package:open_edisu/models/edisu.dart';
import 'package:open_edisu/utilities/extensions/time.dart';

generateSlot(TimeOfDay timeStart) =>
    TimeRange(timeStart: timeStart, timeEnd: timeStart.step());

// ignore: constant_identifier_names
const A123 = BookedSeat(
  id: 1123,
  seatNo: "A123",
  bookedTime: [
    TimeRange(
      timeStart: TimeOfDay(hour: 9, minute: 00),
      timeEnd: TimeOfDay(hour: 10, minute: 00),
    ),
    TimeRange(
      timeStart: TimeOfDay(hour: 12, minute: 30),
      timeEnd: TimeOfDay(hour: 13, minute: 00),
    ),
  ],
);

// ignore: constant_identifier_names
const B201 = BookedSeat(
  id: 2201,
  seatNo: "B201",
  bookedTime: [
    TimeRange(
      timeStart: TimeOfDay(hour: 9, minute: 00),
      timeEnd: TimeOfDay(hour: 10, minute: 00),
    ),
    TimeRange(
      timeStart: TimeOfDay(hour: 12, minute: 30),
      timeEnd: TimeOfDay(hour: 13, minute: 00),
    ),
  ],
);

void main() {
  // Those variables are always initialized in setUp
  late TimeRange slot1;
  late TimeRange slot2;
  late TimeRange slot3;

  group('BookingTableCubit', () {
    blocTest<BookingTableCubit, BookingTableState>(
      'initial state is unselected',
      build: () => BookingTableCubit(),
      expect: () => const [],
      verify: (cubit) =>
          expect(cubit.state, const BookingTableState.unselected()),
    );

    blocTest<BookingTableCubit, BookingTableState>(
      'emits selected slot clicking a free slot',
      setUp: () => slot1 = generateSlot(const TimeOfDay(hour: 11, minute: 30)),
      build: () => BookingTableCubit(),
      act: (cubit) => cubit.select(A123, slot1),
      expect: () => [BookingTableState.selected(A123, slot1)],
    );

    blocTest<BookingTableCubit, BookingTableState>(
      'emits selected slot clicking a free slot after a busy one',
      setUp: () => slot1 = A123.bookedTime[0].step(steps: 1),
      build: () => BookingTableCubit(),
      act: (cubit) => cubit.select(A123, slot1),
      expect: () => [BookingTableState.selected(A123, slot1)],
    );

    blocTest<BookingTableCubit, BookingTableState>(
      'emits selected slot clicking a free slot before a busy one',
      setUp: () => slot1 = A123.bookedTime[0].step(steps: -1),
      build: () => BookingTableCubit(),
      act: (cubit) => cubit.select(A123, slot1),
      expect: () => [BookingTableState.selected(A123, slot1)],
    );

    blocTest<BookingTableCubit, BookingTableState>(
      'donesn\'t emit anything clicking a busy slot',
      setUp: () => slot1 = A123.bookedTime[0],
      build: () => BookingTableCubit(),
      act: (cubit) => cubit.select(A123, slot1),
      expect: () => [],
    );

    blocTest<BookingTableCubit, BookingTableState>(
      'deselect slots when tapped again',
      setUp: () => slot1 = generateSlot(const TimeOfDay(hour: 11, minute: 30)),
      build: () => BookingTableCubit(),
      act: (cubit) => cubit
        ..select(A123, slot1)
        ..select(A123, slot1),
      expect: () => [
        BookingTableState.selected(A123, slot1),
        const BookingTableState.unselected(),
      ],
    );

    blocTest<BookingTableCubit, BookingTableState>(
      'emits selected slot with multiple slots',
      setUp: () {
        slot1 = generateSlot(const TimeOfDay(hour: 10, minute: 30));
        slot2 = generateSlot(const TimeOfDay(hour: 11, minute: 30));
        slot3 = TimeRange(timeStart: slot1.timeStart, timeEnd: slot2.timeEnd);
      },
      build: () => BookingTableCubit(),
      act: (cubit) => cubit
        ..select(A123, slot1)
        ..select(A123, slot2),
      expect: () => [
        BookingTableState.selected(A123, slot1),
        BookingTableState.selected(A123, slot3),
      ],
    );

    blocTest<BookingTableCubit, BookingTableState>(
      'doesn\'t emit anything when the second slot clicked is a busy slot',
      setUp: () {
        slot1 = generateSlot(const TimeOfDay(hour: 10, minute: 30));
        slot2 = A123.bookedTime[1];
      },
      build: () => BookingTableCubit(),
      act: (cubit) => cubit
        ..select(A123, slot1)
        ..select(A123, slot2),
      expect: () => [BookingTableState.selected(A123, slot1)],
    );

    blocTest<BookingTableCubit, BookingTableState>(
      'emits a state with only the second slot when there\'s'
      'a busy box in the middle of the selected slot range',
      setUp: () {
        slot1 = generateSlot(const TimeOfDay(hour: 10, minute: 30));
        // Busy slot at 12:30 - 13:00
        slot2 = generateSlot(const TimeOfDay(hour: 13, minute: 30));
      },
      build: () => BookingTableCubit(),
      act: (cubit) => cubit
        ..select(A123, slot1)
        ..select(A123, slot2),
      expect: () => [
        BookingTableState.selected(A123, slot1),
        BookingTableState.selected(A123, slot2),
      ],
    );

    blocTest<BookingTableCubit, BookingTableState>(
      'select only the second slot if this is before the selected slot',
      setUp: () {
        slot1 = generateSlot(const TimeOfDay(hour: 11, minute: 00));
        slot2 = generateSlot(const TimeOfDay(hour: 10, minute: 30));
      },
      build: () => BookingTableCubit(),
      act: (cubit) => cubit
        ..select(A123, slot1)
        ..select(A123, slot2),
      expect: () => [
        BookingTableState.selected(A123, slot1),
        BookingTableState.selected(A123, slot2),
      ],
    );

    blocTest<BookingTableCubit, BookingTableState>(
      'changes seat when the same slot in a differet seat is selected',
      setUp: () => slot1 = generateSlot(const TimeOfDay(hour: 10, minute: 30)),
      build: () => BookingTableCubit(),
      act: (cubit) => cubit
        ..select(A123, slot1)
        ..select(B201, slot1),
      expect: () => [
        BookingTableState.selected(A123, slot1),
        BookingTableState.selected(B201, slot1),
      ],
    );

    blocTest<BookingTableCubit, BookingTableState>(
      'changes seat when a different slot is in a differet seat is selected',
      setUp: () {
        slot1 = generateSlot(const TimeOfDay(hour: 10, minute: 30));
        slot2 = generateSlot(const TimeOfDay(hour: 11, minute: 30));
      },
      build: () => BookingTableCubit(),
      act: (cubit) => cubit
        ..select(A123, slot1)
        ..select(B201, slot2),
      expect: () => [
        BookingTableState.selected(A123, slot1),
        BookingTableState.selected(B201, slot2),
      ],
    );

    blocTest<BookingTableCubit, BookingTableState>(
      'doesn\'t change seat when a busy slot is in a differet seat is selected',
      setUp: () {
        slot1 = generateSlot(const TimeOfDay(hour: 10, minute: 30));
        slot2 = B201.bookedTime[0];
      },
      build: () => BookingTableCubit(),
      act: (cubit) => cubit
        ..select(A123, slot1)
        ..select(B201, slot2),
      expect: () => [BookingTableState.selected(A123, slot1)],
    );
  });
}
