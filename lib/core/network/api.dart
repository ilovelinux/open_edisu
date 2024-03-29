import 'dart:io';

import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart' hide Headers;

import 'package:open_edisu/features/auth/models/user.dart';
import 'package:open_edisu/features/booking/models/booking.dart';
import 'package:open_edisu/features/halls/models/halls.dart';
import 'package:open_edisu/core/network/models.dart';

part 'api.g.dart';

@RestApi(baseUrl: "https://api-edisuprenotazioni.edisu-piemonte.it/")
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @POST("/users/signin")
  @Headers({HttpHeaders.acceptLanguageHeader: "it"}) // TODO: Make this dynamic
  Future<SigninResponse> signin(
    @Field("email") final String email,
    @Field("password") final String password,
  );

  @POST("/web/initial_signup")
  @FormUrlEncoded()
  Future<Result> initialSignup(@Field("email") final String email);

  @POST("/web/verify_code")
  @FormUrlEncoded()
  Future<VerifyCodeResponse> verifyCode(
    @Field("email") final String email,
    @Field("token") final String token,
  );

  @POST("/web/master")
  @NoBody()
  Future<MasterDataResponse> master();

  @POST("/web/signup")
  @FormUrlEncoded()
  Future<SigninResponse> signup({
    @Field("email") required final String email,
    @Field("token") required final String token,
    @Field("first_name") required final String firstName,
    @Field("last_name") required final String lastName,
    @Field("roll_no") required final String rollNo,
    @Field("university_id") required final String universityId,
    @Field("password") required final String password,
    @Field("cpassword") required final String cpassword,
    @Field("is_disable") required final String isDisabled,
  });

  @POST("/web/me")
  @NoBody()
  Future<MeResponse> me(@DioOptions() Options options);

  @POST("/web/studentbookinglist")
  @FormUrlEncoded()
  Future<StudentBookingListResponse> studentBookingList({
    @Field('date') final String date = "",
    @Field("filter") final String filter = "-1",
    @DioOptions() required Options options,
  });

  @POST("/web/halllist")
  @FormUrlEncoded()
  Future<HallListResponse> hallList({
    @Field("type") final String type = "0",
    @DioOptions() required Options options,
  });

  @POST("/booking/halllist")
  @Headers({HttpHeaders.acceptLanguageHeader: "it"}) // TODO: Make this dynamic
  @Headers({HttpHeaders.contentTypeHeader: "application/json"})
  Future<HallListMobileResponse> hallListMobile(
    @Body() HallListMobileRequest body, {
    @DioOptions() required Options options,
  });

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
  @Headers({HttpHeaders.contentTypeHeader: "application/json"})
  Future<BookingsPerSeatsResponse> bookingsperseat(
      @Body() BookingsPerSeatsRequest body);

  @POST("/booking/custombooking")
  @Headers({HttpHeaders.acceptLanguageHeader: "it"})
  @Headers({HttpHeaders.contentTypeHeader: "application/json"})
  Future<void> custombooking(@Body() CustomBookingRequest body);

  @POST("/booking/bookingcancel")
  @Headers({HttpHeaders.acceptLanguageHeader: "it"})
  @Headers({HttpHeaders.contentTypeHeader: "application/json"})
  Future<void> bookingcancel(@Body() BookingCancelRequest body);

  @POST('/users/updateuser')
  @Headers({HttpHeaders.acceptLanguageHeader: "it"})
  Future<Result> updateuser(@Body() UserBase body);

  @POST('/users/updatepassword')
  @Headers({HttpHeaders.acceptLanguageHeader: "it"})
  Future<Result> updatepassword(@Body() UpdatePasswordRequest body);
}
