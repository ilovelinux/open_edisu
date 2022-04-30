import 'dart:convert';

import 'package:intl/intl.dart';

import 'extensions/time.dart';
import 'constants/api.dart';
import '../models/edisu.dart';
import '../utilities/http.dart';
import '../utilities/constants/urls.dart' as urls;

Future<Bookings> getBookings() async {
  var response = await client
      .postAPI(urls.studentBookingList, body: {"date": "", "filter": "-1"});

  return response["slots"].map<Booking>((e) => Booking(e)).toList();
}

Future<Halls> getHalls({String type = "0"}) async {
  var response = await client.postAPI(urls.hallList, body: {"type": type});

  return response["data"]["list"].map<Hall>((e) => Hall(e)).toList();
}

Future<SeatsList> getSeats(Hall hall, {DateTime? date}) async {
  date ??= DateTime.now();

  var response = await client.postAPI(
    urls.seats,
    body: {
      "date": DateFormat("dd-MM-y").format(date),
      "hall": "${hall.hname} (${hall.id})",
    },
  );

  return response["seats"].map<Seats>((e) => Seats(e)).toList();
}

Future<Slots> getSlots(Hall hall, {DateTime? date}) async {
  date ??= DateTime.now();

  var response = await client.postAPI(
    urls.slots,
    body: {
      "date": DateFormat("y-MM-dd").format(date),
      "hall": "${hall.hname} (${hall.id})",
    },
  );

  return response["data"]["list"].map<Slot>((e) => Slot(e)).toList();
}

Future<BookingsPerSeats> getBookingsPerSeat(Hall hall, {DateTime? date}) async {
  date ??= DateTime.now();

  final response = await client.postAPIRaw(
    urls.bookingsPerSeat,
    headers: {
      "Content-Type": "application/json",

      // This is needed but maybe it shouldn't be hardcoded
      "Accept-Language": "it",
    },
    body: jsonEncode({
      "hall_id": hall.id.toString(),
      "date": DateFormat("dd-MM-y").format(date),
    }),
  );

  final message = response["message"] ?? response["messsage"];
  if (message != "success") {
    throw ApiException(response["status"], message, response["error"]);
  }

  return BookingsPerSeats(response["result"], date);
}

Future<void> customSlotBook({
  required Hall hall,
  required DateTime date,
  required int seatID,
  required TimeRange slot,
}) async =>
    await client.postAPIRaw(
      urls.customSlotBook,
      headers: {
        "Content-Type": "application/json",

        // This is needed but maybe it shouldn't be hardcoded
        "Accept-Language": "it",
      },
      body: jsonEncode({
        "hall_id": hall.id.toString(),
        "date": DateFormat("dd-MM-y").format(date),
        "start_time": slot.timeStart.to24hours(),
        "end_time": slot.timeEnd.to24hours(),
        "seat_id": seatID.toString(),
      }),
    );

Future<void> bookingCancel(int bookingID) async => await client
    .postAPIRaw(urls.bookingCancel, body: {"booking_id": bookingID.toString()});
