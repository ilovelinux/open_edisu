part of 'edisu.dart';

@JsonSerializable(converters: [DateFormatConverter.dMy(), TimeOfDayConverter()])
class Booking {
  final int id;
  final String bookingId;
  @JsonKey(fromJson: int.parse)
  final int seatNo;
  final String location;
  final DateTime date;
  final TimeOfDay startTime;
  final TimeOfDay endTime;
  final Uri qrCode;
  final String hallName;
  final int hallId;
  final String floorNo;
  final BookingStatus bookingStatus;
  final int seatStatus;

  const Booking({
    required this.id,
    required this.bookingId,
    required this.seatNo,
    required this.location,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.qrCode,
    required this.hallName,
    required this.hallId,
    required this.floorNo,
    required this.bookingStatus,
    required this.seatStatus,
  });

  factory Booking.fromJson(Map<String, dynamic> json) =>
      _$BookingFromJson(json);

  DateTime toDateTime() =>
      date.add(Duration(hours: startTime.hour, minutes: startTime.minute));

  bool isUpcoming() => bookingStatus.isUpcoming() || bookingStatus.isPending();
}

typedef Bookings = List<Booking>;

enum BookingStatus {
  @JsonValue(0)
  cancelled,
  @JsonValue(1)
  upcoming,
  @JsonValue(2)
  completed,
  @JsonValue(3)
  pending,
}

extension BookingStatusExtension on BookingStatus {
  bool isCancelled() => this == BookingStatus.cancelled;
  bool isUpcoming() => this == BookingStatus.upcoming;
  bool isCompleted() => this == BookingStatus.completed;
  bool isPending() => this == BookingStatus.pending;
}

@JsonSerializable()
class Hall {
  @JsonKey(fromJson: int.parse)
  final int id;
  final String hname;
  final String hcode;
  final String hpassword;
  @JsonKey(fromJson: int.parse)
  final int hmax;
  @JsonKey(fromJson: int.parse)
  final int husable;
  final String slotTime;
  final String closedFrom;
  final String closedUntil;
  final String floor;
  final String building;
  final String hstatus;

  const Hall({
    required this.id,
    required this.hname,
    required this.hcode,
    required this.hpassword,
    required this.hmax,
    required this.husable,
    required this.slotTime,
    required this.closedFrom,
    required this.closedUntil,
    required this.floor,
    required this.building,
    required this.hstatus,
  });

  factory Hall.fromJson(Map<String, dynamic> json) => _$HallFromJson(json);
}

typedef Halls = List<Hall>;

@JsonSerializable()
class HallMobile {
  final int id;
  final String name;
  final String location;
  final String lat;
  final String long;

  const HallMobile({
    required this.id,
    required this.name,
    required this.location,
    required this.lat,
    required this.long,
  });

  factory HallMobile.fromJson(Map<String, dynamic> json) =>
      _$HallMobileFromJson(json);
}

typedef HallsMobile = List<Hall>;

@JsonSerializable()
class Seats {
  final int seatId;
  final String seatName;
  final List<Seat> seat;

  const Seats({
    required this.seatId,
    required this.seatName,
    required this.seat,
  });

  factory Seats.fromJson(Map<String, dynamic> json) => _$SeatsFromJson(json);
}

@JsonSerializable(converters: [TimeOfDayConverter()])
class Seat {
  final String bookingStatus;
  final String? bookingId;
  final TimeOfDay? slotTime;

  const Seat({
    required this.bookingStatus,
    final this.bookingId,
    this.slotTime,
  });

  factory Seat.fromJson(Map<String, dynamic> json) => _$SeatFromJson(json);
}

typedef SeatsList = List<Seats>;

@JsonSerializable(converters: [TimeOfDayConverter()])
class BookingsPerSeats {
  final TimeOfDay? timeStart;
  final TimeOfDay? timeEnd;
  @JsonKey(defaultValue: [])
  final BookedSeatList seats;
  @JsonKey(ignore: true)
  late final DateTime date; // Not given by api

  BookingsPerSeats({
    required this.timeStart,
    required this.timeEnd,
    required this.seats,
  });

  TimeRange get timeRange =>
      TimeRange(timeStart: timeStart!, timeEnd: timeEnd!);

  factory BookingsPerSeats.fromJson(Map<String, dynamic> json) =>
      _$BookingsPerSeatsFromJson(json);

  List<TimeRange> get slots => List.unmodifiable(
        Iterable.generate(
          (timeRange.timeEnd.hour - timeRange.timeStart.hour) * 2 +
              (timeRange.timeEnd.minute - timeRange.timeStart.minute + 1) ~/ 30,
          (index) => TimeRange(
            timeStart: timeRange.timeStart,
            timeEnd: timeRange.timeStart.step(),
          ).step(steps: index),
        ),
      );

  List<TimeRange> get futureSlots => date.isBefore(DateTime.now())
      ? slots.where((e) => e.timeEnd > TimeOfDay.now()).toList()
      : slots;
}

@JsonSerializable()
class BookedSeat {
  final int id;
  final String seatNo;
  @JsonKey(defaultValue: [])
  final List<TimeRange> bookedTime;

  const BookedSeat({
    required this.id,
    required this.seatNo,
    required this.bookedTime,
  });

  factory BookedSeat.fromJson(Map<String, dynamic> json) =>
      _$BookedSeatFromJson(json);

  @override
  bool operator ==(Object? other) => other is BookedSeat && id == other.id;

  @override
  int get hashCode => id;

  bool isBusy(TimeRange slot) =>
      bookedTime.any((e) => slot.isAtTheSameMomentAs(e));
}

typedef BookedSeatList = List<BookedSeat>;

@JsonSerializable(converters: [TimeOfDayConverter()])
class TimeRange {
  final TimeOfDay timeStart;
  final TimeOfDay timeEnd;

  const TimeRange({required this.timeStart, required this.timeEnd});

  factory TimeRange.fromJson(Map<String, dynamic> json) =>
      _$TimeRangeFromJson(json);

  TimeOfDay get normalizedTimeEnd => timeStart < timeEnd
      ? timeEnd
      : TimeOfDay(hour: 24 + timeEnd.hour, minute: timeEnd.minute);

  TimeRange step({int steps = 1}) => TimeRange(
        timeStart: timeStart.step(steps: steps),
        timeEnd: timeEnd.step(steps: steps),
      );

  bool isAtTheSameMomentAs(TimeRange slot) =>
      (slot.timeStart <= timeStart &&
          slot.normalizedTimeEnd >= normalizedTimeEnd) ||
      (timeStart <= slot.timeStart &&
          normalizedTimeEnd >= slot.normalizedTimeEnd);
}

class Slot extends TimeRange {
  TimeOfDay get begin => timeStart;
  TimeOfDay get end => timeEnd;

  const Slot(begin, end) : super(timeStart: begin, timeEnd: end);
}

typedef Slots = List<Slot>;

const slotSeparator = Slot(
  TimeOfDay(hour: 99, minute: 99),
  TimeOfDay(hour: 99, minute: 99),
);

extension SlotsExtension on Slots {
  Slots get withSeparators {
    final Slots slots = Slots.from(this);

    for (int i = 1; i < slots.length; i++) {
      if (slots[i - 1].end != slots[i].begin) {
        slots.insert(i++, slotSeparator);
      }
    }

    return slots;
  }
}
