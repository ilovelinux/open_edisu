import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:open_edisu/network/verifycode/verifycode_response.dart';

import 'api.dart';
import 'bookingcancel/bookingcancel_request.dart';
import 'bookingsperseat/bookingsperseats_request.dart';
import 'custombooking/custombooking_request.dart';
import '../utilities/inceptor.dart';
import '../models/edisu.dart';

class Client {
  const Client(this._api);

  final RestClient _api;

  Future<User> signin(final String email, final String password) async {
    final response = await _api.signin(email, password);

    await flutterSecureStorage.write(key: 'token', value: response.token);
    return response.result.data;
  }

  Future<String> initialSignup(final String email) async {
    final response = await _api.initialSignup(email);
    return response.message;
  }

  Future<VerifyCodeResponse> verifyCode(
    final String email,
    final String token,
  ) =>
      _api.verifyCode(email, token);

  Future<Universities> master() async {
    final response = await _api.master();
    return response.result.universities;
  }

  Future<User> signup({
    required final String email,
    required final String token,
    required final String firstName,
    required final String lastName,
    required final String rollNo,
    required final int universityId,
    required final String password,
    required final String cpassword,
    required final bool isDisabled,
  }) async {
    final response = await _api.signup(
      email: email,
      token: token,
      firstName: firstName,
      lastName: lastName,
      rollNo: rollNo,
      universityId: universityId.toString(),
      password: password,
      cpassword: cpassword,
      isDisabled: isDisabled ? "1" : "0",
    );

    await flutterSecureStorage.write(key: 'token', value: response.token);
    return response.result.data;
  }

  Future<User> me() async {
    final response = await _api.me();
    return response.result.data;
  }

  Future<Bookings> getBookings({
    final String date = "",
    final String filter = "-1",
  }) async {
    final response = await _api.studentBookingList(date: date, filter: filter);

    return response.result!.slots;
  }

  Future<Halls> getHalls({final String type = "0"}) async {
    var response = await _api.hallList(type: type);

    return response.result.data.list;
  }

  Future<Slots> getSlots(final Hall hall, {DateTime? date}) async {
    date ??= DateTime.now();

    final response = await _api.slots(
      DateFormat('dd-MM-y').format(date),
      "${hall.hname} (${hall.id})",
    );

    return response.result.data.list;
  }

  Future<SeatsList> getSeats(final Hall hall, {DateTime? date}) async {
    date ??= DateTime.now();

    final response = await _api.seats(
      DateFormat('dd-MM-y').format(date),
      "${hall.hname} (${hall.id})",
    );

    return response.result.seats;
  }

  Future<BookingsPerSeats> getBookingsPerSeat(
    final Hall hall, {
    DateTime? date,
  }) async {
    date ??= DateTime.now();

    final response = await _api.bookingsperseat(
      BookingsPerSeatsRequest(date: date, hallId: hall.id.toString()),
    );

    if (response.message != "success") {
      throw ApiException(response.status, response.message, response.error);
    }

    return response.result..date = date;
  }

  Future customSlotBook({
    required final Hall hall,
    required final int seatID,
    required final DateTime date,
    required final TimeRange slot,
  }) =>
      _api.custombooking(CustomBookingRequest(
        hallId: hall.id,
        seatId: seatID,
        date: date,
        startTime: slot.timeStart,
        endTime: slot.timeEnd,
      ));

  Future bookingCancel(final int bookingID) =>
      _api.bookingcancel(BookingCancelRequest(bookingId: bookingID));

  Future logout() => flutterSecureStorage.delete(key: 'token');
}

class ApiException implements Exception {
  ApiException(this.status, this.message, this.error, [this.data]);

  // Used only for debugging purposes
  final Map? data;

  final int status;
  final String message;
  final String? error;

  @override
  String toString() => kDebugMode
      ? ["$status: $message", if (error != null) error].join(":")
      : message;
}
