import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:open_edisu/utilities/json/converters.dart';

part 'custombooking_request.freezed.dart';
part 'custombooking_request.g.dart';

@Freezed(toJson: true)
class CustomBookingRequest with _$CustomBookingRequest {
  const factory CustomBookingRequest({
    required final int hallId,
    required final int seatId,
    @DateFormatConverter.dMy() required final DateTime date,
    @TimeOfDayConverter() required final TimeOfDay startTime,
    @TimeOfDayConverter() required final TimeOfDay endTime,
  }) = _CustomBookingRequest;
}
