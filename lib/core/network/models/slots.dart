part of '../models.dart';

typedef SlotsResponse = Result<DataResponse<SlotsListResponse>>;

class SlotsListResponse extends ListResponse<Slots> {
  SlotsListResponse({required super.list});

  static SlotsListResponse fromJson(Map<String, dynamic> json) =>
      SlotsListResponse(
        list: json['list'].map<Slot>((e) {
          final times = e
              .split(' ')
              .map((e) => TimeOfDay.fromDateTime(DateFormat.Hm().parse(e)));
          return Slot(times.first, times.last);
        }).toList(),
      );
}
