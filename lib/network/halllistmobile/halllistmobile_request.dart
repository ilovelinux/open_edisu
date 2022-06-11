import 'package:freezed_annotation/freezed_annotation.dart';

part 'halllistmobile_request.freezed.dart';
part 'halllistmobile_request.g.dart';

@Freezed(toJson: true)
class HallListMobileRequest with _$HallListMobileRequest {
  const factory HallListMobileRequest({
    @Default('1') final String cityId,
  }) = _HallListMobileRequest;
}
