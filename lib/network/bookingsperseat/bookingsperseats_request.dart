import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:open_edisu/utilities/json/converters.dart';

part 'bookingsperseats_request.freezed.dart';
part 'bookingsperseats_request.g.dart';

@Freezed(toJson: true)
class BookingsPerSeatsRequest with _$BookingsPerSeatsRequest {
  const factory BookingsPerSeatsRequest({
    @DateFormatConverter.dMy() required final DateTime date,
    required final String hallId,
  }) = _BookingsPerSeatsRequest;
}
