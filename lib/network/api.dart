import 'dart:io';

import 'package:open_edisu/network/custombooking/custombooking_request.dart';
import 'package:open_edisu/network/generic_response.dart';
import 'package:open_edisu/network/master/master_response.dart';
import 'package:open_edisu/network/signin/signin_response.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart' hide Headers;

import 'bookingcancel/bookingcancel_request.dart';
import 'bookingsperseat/bookingsperseats_request.dart';
import 'bookingsperseat/bookingsperseats_response.dart';
import 'halllist/halllist_response.dart';
import 'halllistmobile/halllistmobile_request.dart';
import 'halllistmobile/halllistmobile_response.dart';
import 'me/me_response.dart';
import 'seats/seats_response.dart';
import 'slots/slots_response.dart';
import 'studentbookinglist/studentbookinglist_response.dart';

part 'api.g.dart';

@RestApi(baseUrl: "https://edisuprenotazioni.edisu-piemonte.it:8443/sbs/")
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @POST("/web/signin")
  @FormUrlEncoded()
  Future<SigninResponse> signin(
    @Field("email") final String email,
    @Field("password") final String password,
  );

  @POST("/web/initial_signup")
  @FormUrlEncoded()
  Future<GenericResponse> initialSignup(@Field("email") final String email);

  @POST("/web/verify_code")
  @FormUrlEncoded()
  Future<GenericResponse> verifyCode(
    @Field("email") final String email,
    @Field("token") final String token,
  );

  @POST("/web/master")
  @NoBody()
  Future<MasterDataResponse> master();

  @POST("/web/signup")
  @FormUrlEncoded()
  Future<MeResponse> signup({
    @Field("email") required final String email,
    @Field("token") required final String token,
    @Field("first_name") required final String firstName,
    @Field("last_name") required final String lastName,
    @Field("roll_no") required final String rollNo,
    @Field("university_id") required final String universityId,
    @Field("password") required final String password,
    @Field("cpassword") required final String cpassword,
    @Field("is_disabled") required final String isDisabled,
  });

  @POST("/web/me")
  @NoBody()
  Future<MeResponse> me();

  @POST("/web/studentbookinglist")
  @FormUrlEncoded()
  Future<StudentBookingListResponse> studentBookingList({
    @Field('date') final String date = "",
    @Field("filter") final String filter = "-1",
  });

  @POST("/web/halllist")
  @FormUrlEncoded()
  Future<HallListResponse> hallList({@Field("type") final String type = "0"});

  @POST("/booking/halllist")
  @Headers({HttpHeaders.acceptLanguageHeader: "it"}) // TODO: Make this dynamic
  Future<HallListMobileResponse> hallListMobile(
      @Body() HallListMobileRequest body);

  @POST("/web/student/slots")
  @FormUrlEncoded()
  Future<SlotsResponse> slots(
    @Field("date") final String date,
    @Field("hall") final String hall,
  );

  @POST("/web/student/seats")
  @FormUrlEncoded()
  Future<SeatsResponse> seats(
    @Field("date") final String date,
    @Field("hall") final String hall,
  );

  @POST("/booking/bookingsperseats")
  @Headers({HttpHeaders.acceptLanguageHeader: "it"})
  Future<BookingsPerSeatsResponse> bookingsperseat(
      @Body() BookingsPerSeatsRequest body);

  @POST("/booking/custombooking")
  @Headers({HttpHeaders.acceptLanguageHeader: "it"})
  Future custombooking(@Body() CustomBookingRequest body);

  @POST("/booking/bookingcancel")
  @Headers({HttpHeaders.acceptLanguageHeader: "it"})
  Future bookingcancel(@Body() BookingCancelRequest body);
}
