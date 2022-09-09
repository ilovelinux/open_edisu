part of '../models.dart';

@Freezed(toJson: true)
class HallListMobileRequest with _$HallListMobileRequest {
  const factory HallListMobileRequest({
    @Default('1') final String cityId,
  }) = _HallListMobileRequest;
}

typedef HallListMobileResponse
    = Result<DataResponse<ListResponse<HallsMobile>>>;
