part of 'edisu.dart';

@JsonSerializable(converters: [DateFormatConverter.dMy(), TimeOfDayConverter()])
class Booking {
  final int id;
  final String bookingId;
  final int seatNo;
  final String location;
  final DateTime date;
  final TimeOfDay startTime;
  final TimeOfDay endTime;
  final Uri qrCode;
  final String hallName;
  final int hallId;
  final String floorNo;
  final int bookingStatus; // 0 = Deleted; 1 = Coming(?); 2 = Confirmed
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

  bool isComing() =>
      DateTime.now().isBefore(toDateTime()) && bookingStatus == 1;

  bool isOnDay(DateTime day) => date.isBefore(day) && isComing();
}

typedef Bookings = List<Booking>;

@JsonSerializable()
class Hall {
  final int id;
  final String hname;
  final String hcode;
  final String hpassword;
  final int hmax;
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

@JsonSerializable()
class BookingsPerSeats {
  final TimeRange timeRange;
  final BookedSeatList seats;
  final DateTime date; // Not given by api

  const BookingsPerSeats({
    required this.timeRange,
    required this.seats,
    required this.date, //!!
  });

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

@JsonSerializable(converters: [TimeOfDayConverter()])
class Slot {
  final TimeOfDay begin;
  final TimeOfDay end;

  Slot(this.begin, this.end);
}

typedef Slots = List<Slot>;
