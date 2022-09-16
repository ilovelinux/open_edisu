part of '../models.dart';

@freezed
class MasterResponse with _$MasterResponse {
  const factory MasterResponse({
    required final int status,
    required final String messsage,
    required final MasterDataResponse result,
  }) = _MasterResponse;

  factory MasterResponse.fromJson(Map<String, dynamic> json) =>
      _$MasterResponseFromJson(json);
}

@JsonSerializable()
class MasterDataResponse {
  final MasterUniversitiesDataResponse result;

  MasterDataResponse({required this.result});

  factory MasterDataResponse.fromJson(Map<String, dynamic> json) =>
      _$MasterDataResponseFromJson(json);
}

@JsonSerializable()
class MasterUniversitiesDataResponse {
  final Universities universities;

  MasterUniversitiesDataResponse({required this.universities});

  factory MasterUniversitiesDataResponse.fromJson(Map<String, dynamic> json) =>
      _$MasterUniversitiesDataResponseFromJson(json);
}
