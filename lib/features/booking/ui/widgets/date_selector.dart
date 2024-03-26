import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_edisu/core/utilities/extensions/date.dart';
import 'package:open_edisu/features/booking/logic/booking_info_bloc.dart';

abstract class BaseDateSelector extends StatelessWidget {
  const BaseDateSelector({super.key, required this.date});

  final DateTime date;

  Function()? decrease(BuildContext context) {
    final newDate = date.subtract(const Duration(days: 1));
    final downLimit = DateTime.now().withoutTime();
    if (newDate.isBefore(downLimit)) {
      return null;
    }
    return () => changeDate(context, newDate);
  }

  Function()? increase(BuildContext context) {
    final newDate = date.add(const Duration(days: 1));
    final upLimit = DateTime.now().add(const Duration(days: 7));
    if (newDate.isAfter(upLimit)) {
      return null;
    }
    return () => changeDate(context, newDate);
  }

  void changeDate(BuildContext context, DateTime date) =>
      context.read<BookingInfoBloc>().add(BookingInfoEvent.changeDate(date));
}
