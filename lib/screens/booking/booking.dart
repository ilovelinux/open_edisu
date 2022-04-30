import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';

import '../../bloc/booking_info_bloc.dart';
import '../../bloc/booking_table_alternative_bloc.dart';
import '../../bloc/bookings_bloc.dart' as bookings;
import '../../models/edisu.dart';
import '../../widgets/commons.dart';
import '../../widgets/dialogs/booking_dialog.dart';
import '../../bloc/booking_table_bloc.dart';
import '../../utilities/extensions/time.dart';
import '../../utilities/extensions/date.dart';

part 'booking_table.dart';
part 'booking_table_alternative.dart';

// Table colors
const Color available = Color(0xFF6FB2D2);
const Color booked = Color(0xFF85C88A);
const Color unavailable = Color(0xFFEEEEEE);
const Color conflict = Color(0xFFEBD671);

// Table sizes
const double _width = 60;
const double _height = 60;
const double _margin = 6;

class BookingPage extends StatelessWidget {
  final Hall hall;

  const BookingPage({Key? key, required this.hall}) : super(key: key);

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

  const BookingView({Key? key, required this.hall}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          BookingInfoBloc(hall)..add(DateChangeRequested(DateTime.now())),
      child: Column(
        children: [
          BlocBuilder<BookingInfoBloc, BookingInfoState>(
            buildWhen: (_, current) => current is Update,
            builder: (context, _) =>
                _DateSelector(date: context.read<BookingInfoBloc>().date),
          ),
          Expanded(
            child: BlocBuilder<BookingInfoBloc, BookingInfoState>(
              builder: (context, state) => state.when(
                (bookingsPerSeat) => _BookingTable(bookingsPerSeat),
                alternative: (slots, seats) =>
                    _TimeTable2(slots: slots, seats: seats),
                loading: () => const LoadingWidget(),
                update: () => const LoadingWidget(),
                closed: () => const Text("Building closed."),
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
  const _DateSelector({Key? key, required this.date}) : super(key: key);

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
            onPressed: () async {
              final newDate = await showDatePicker(
                context: context,
                initialDate: date,
                firstDate: DateTime.now(),
                lastDate: DateTime.now().add(const Duration(days: 7)),
              );
              if (newDate != null) {
                changeDate(context, newDate);
              }
            },
            child: Text(DateFormat.yMEd().format(date)),
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
      context.read<BookingInfoBloc>().add(DateChangeRequested(date));
}
