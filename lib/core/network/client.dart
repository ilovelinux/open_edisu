import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

import 'package:open_edisu/features/auth/models/user.dart';
import 'package:open_edisu/features/booking/models/booking.dart';
import 'package:open_edisu/features/halls/models/halls.dart';
import 'package:open_edisu/features/settings/models/settings.dart';
import 'package:open_edisu/core/utilities/inceptor.dart';
import 'package:open_edisu/core/network/api.dart';
import 'package:open_edisu/core/network/models.dart';

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
    final response = await _api.me(
      (await defaultCacheOptions)
          .copyWith(policy: CachePolicy.refreshForceCache)
          .toOptions(),
    );
    return response.result.data;
  }

  Future<Bookings> getBookings({
    final String date = "",
    final String filter = "-1",
  }) async {
    final response = await _api.studentBookingList(
      date: date,
      filter: filter,
      options: (await defaultCacheOptions)
          .copyWith(policy: CachePolicy.refreshForceCache)
          .toOptions(),
    );

    return response.result!.slots;
  }

  Future<Halls> getHalls({final String type = "0"}) async {
    var response = await _api.hallList(
      type: type,
      options: (await defaultCacheOptions)
          .copyWith(policy: CachePolicy.refreshForceCache)
          .toOptions(),
    );

    return response.result.data.list;
  }

  Future<HallsMobile> getHallsMobile({final String cityId = "1"}) async {
    var response = await _api.hallListMobile(
      HallListMobileRequest(cityId: cityId),
      options: (await defaultCacheOptions)
          .copyWith(policy: CachePolicy.refreshForceCache)
          .toOptions(),
    );

    return response.result.data.list;
  }

  Future<Slots> getSlots(final Hall hall, {DateTime? date}) async {
    date ??= DateTime.now();

    final response = await _api.slots(
      DateFormat('y-MM-dd').format(date),
      "${hall.hname} (${hall.id})",
    );

    return response.result.data.list;
  }

  Future<SeatsList> getSeats(final Hall hall, {DateTime? date}) async {
    date ??= DateTime.now();

    final response = await _api.seats(
      DateFormat('y-MM-dd').format(date),
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

  Future<void> customSlotBook({
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

  Future<void> bookingCancel(final int bookingID) =>
      _api.bookingcancel(BookingCancelRequest(bookingId: bookingID));

  Future<void> updateUser(final UserBase user) => _api.updateuser(user);

  Future<void> updatePassword(
          final String oldPassword, final String newPassword) =>
      _api.updatepassword(UpdatePasswordRequest(
        oldPassword: oldPassword,
        password: newPassword,
        confirmPassword: newPassword,
      ));

  Future<void> logout() => flutterSecureStorage.delete(key: 'token');
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
      ? ["$status: $message", if (error != null) error].join(" : ")
      : message;
}
