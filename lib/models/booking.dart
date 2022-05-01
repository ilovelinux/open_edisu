part of 'edisu.dart';

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

  Booking(Map data)
      : id = data["id"],
        bookingId = data["booking_id"],
        seatNo = int.parse(data["seat_no"]),
        location = data["location"],
        date = DateFormat("d-M-y").parse(data["date"]),
        startTime = (data["start_time"] as String).parseTime(),
        endTime = (data["end_time"] as String).parseTime(),
        qrCode = Uri.parse(data["qr_code"]),
        hallName = data["hall_name"],
        hallId = data["hall_id"],
        floorNo = data["floor_no"],
        bookingStatus = data["booking_status"],
        seatStatus = data["seat_status"];

  DateTime toDateTime() =>
      date.add(Duration(hours: startTime.hour, minutes: startTime.minute));

  bool isComing() =>
      DateTime.now().isBefore(toDateTime()) && bookingStatus == 1;

  bool isOnDay(DateTime day) => date.isBefore(day) && isComing();
}

typedef Bookings = List<Booking>;

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

  Hall(Map<String, dynamic> data)
      : id = int.parse(data["id"]),
        hname = data["hname"],
        hcode = data["hcode"],
        hpassword = data["hpassword"],
        hmax = int.parse(data["hmax"]),
        husable = int.parse(data["husable"]),
        slotTime = data["slot_time"],
        closedFrom = data["closed_from"],
        closedUntil = data["closed_until"],
        floor = data["floor"],
        building = data["building"],
        hstatus = data["hstatus"];
}

typedef Halls = List<Hall>;

class Seats {
  final int seatId;
  final String seatName;
  final List<Seat> seat;

  Seats(Map<String, dynamic> data)
      : seatId = data["seat_id"],
        seatName = data["seat_name"],
        seat = data["seat"].map<Seat>((e) => Seat(e)).toList();
}

class Seat {
  final String bookingStatus;
  final String? bookingId;
  final TimeOfDay? slotTime;

  Seat(Map<String, dynamic> data)
      : bookingStatus = data["booking_status"],
        bookingId = data["booking_id"],
        slotTime = (data["slot_time"] as String?)?.parseTime();
}

typedef SeatsList = List<Seats>;

class BookingsPerSeats {
  final TimeRange timeRange;
  final BookedSeatList seats;

  final DateTime date; // Not given by api

  BookingsPerSeats(Map<String, dynamic> data, this.date)
      : timeRange = TimeRange.data(data),
        seats = data["seats"].map<BookedSeat>((e) => BookedSeat(e)).toList();

  List<TimeRange> get slots => List.generate(
        (timeRange.timeEnd.hour - timeRange.timeStart.hour) * 2 +
            (timeRange.timeEnd.minute - timeRange.timeStart.minute + 1) ~/ 30,
        (index) => TimeRange(timeRange.timeStart, timeRange.timeStart.step())
            .step(steps: index),
        growable: false,
      );

  List<TimeRange> get futureSlots => date.isBefore(DateTime.now())
      ? slots.where((e) => e.timeEnd > TimeOfDay.now()).toList()
      : slots;
}

class BookedSeat {
  final int id;
  final String seatNo;
  final List<TimeRange> bookedTime;

  BookedSeat(Map<String, dynamic> data)
      : id = data["id"],
        seatNo = data["seat_no"],
        bookedTime = (data["booked_time"] ?? [])
            .map<TimeRange>((e) => TimeRange.data(e))
            .toList();

  @override
  bool operator ==(Object? other) => other is BookedSeat && id == other.id;

  @override
  int get hashCode => id;

  bool isBusy(TimeRange slot) =>
      bookedTime.any((e) => slot.isAtTheSameMomentAs(e));
}

typedef BookedSeatList = List<BookedSeat>;

class TimeRange {
  TimeRange(this.timeStart, this.timeEnd);

  TimeRange.data(Map<String, dynamic> data)
      : timeStart = (data["time_start"] as String).parseTime(),
        timeEnd = (data["time_end"] as String).parseTime();

  final TimeOfDay timeStart;
  final TimeOfDay timeEnd;

  TimeOfDay get normalizedTimeEnd => timeStart < timeEnd
      ? timeEnd
      : TimeOfDay(hour: 24 + timeEnd.hour, minute: timeEnd.minute);

  TimeRange step({int steps = 1}) =>
      TimeRange(timeStart.step(steps: steps), timeEnd.step(steps: steps));

  bool isAtTheSameMomentAs(TimeRange slot) =>
      (slot.timeStart <= timeStart &&
          slot.normalizedTimeEnd >= normalizedTimeEnd) ||
      (timeStart <= slot.timeStart &&
          normalizedTimeEnd >= slot.normalizedTimeEnd);
}

class Slot {
  late final TimeOfDay begin;
  late final TimeOfDay end;

  Slot(String data) {
    final sData = data.split(' ');
    begin = sData[0].parseTime();
    end = sData[1].parseTime();
  }
}

typedef Slots = List<Slot>;
