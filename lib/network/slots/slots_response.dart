import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../models/edisu.dart';
import '../generic_response.dart';

typedef SlotsResponse = Result<DataResponse<SlotsListResponse>>;

class SlotsListResponse extends ListResponse<Slots> {
  SlotsListResponse({required Slots list}) : super(list: list);

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
