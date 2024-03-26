import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:open_edisu/core/utilities/extensions/date.dart';
import 'package:open_edisu/core/widgets/commons.dart';
import 'package:open_edisu/features/booking/logic/booking_info_bloc.dart';
import 'package:open_edisu/features/booking/ui/mobile/screens/booking_table.dart';
import 'package:open_edisu/features/halls/models/halls.dart';

class DragWithTouchAndMouse extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        PointerDeviceKind.trackpad,
      };
}

class BookingPage extends StatelessWidget {
  final Hall hall;

  const BookingPage({super.key, required this.hall});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(hall.hname)),
      body: BookingView(hall: hall),
    );
  }
}

class BookingView extends StatelessWidget {
  final Hall hall;

  const BookingView({super.key, required this.hall});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BookingInfoBloc(hall)
        ..add(BookingInfoEvent.changeDate(DateTime.now())),
      child: Column(
        children: [
          BlocBuilder<BookingInfoBloc, BookingInfoState>(
            buildWhen: (_, current) => current.maybeWhen(
              update: () => true,
              orElse: () => false,
            ),
            builder: (context, _) =>
                _DateSelector(date: context.read<BookingInfoBloc>().date),
          ),
          Expanded(
            child: BlocBuilder<BookingInfoBloc, BookingInfoState>(
              builder: (context, state) => state.when(
                success: (slots, bookingsPerSeat) =>
                    BookingTable(slots, bookingsPerSeat),
                loading: () => const LoadingWidget(),
                update: () => const LoadingWidget(),
                error: (e) => CenteredText(e),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DateSelector extends StatelessWidget {
  const _DateSelector({required this.date});

  final DateTime date;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          TextButton(
            onPressed: _decrease(context),
            child: const Icon(Icons.arrow_back),
          ),
          TextButton(
            onPressed: () => showDatePicker(
              context: context,
              initialDate: date,
              firstDate: DateTime.now(),
              lastDate: DateTime.now().add(const Duration(days: 7)),
            ).then((newDate) {
              if (newDate != null) {
                changeDate(context, newDate);
              }
            }),
            child: Text(
                DateFormat.yMEd(Localizations.localeOf(context).toLanguageTag())
                    .format(date)),
          ),
          TextButton(
            onPressed: _increase(context),
            child: const Icon(Icons.arrow_forward),
          ),
        ],
      ),
    );
  }

  Function()? _decrease(BuildContext context) {
    final newDate = date.subtract(const Duration(days: 1));
    final downLimit = DateTime.now().withoutTime();
    if (newDate.isBefore(downLimit)) {
      return null;
    }
    return () => changeDate(context, newDate);
  }

  Function()? _increase(BuildContext context) {
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
