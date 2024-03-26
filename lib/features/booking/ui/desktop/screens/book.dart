import 'dart:ui';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_edisu/core/utilities/extensions/date.dart';
import 'package:open_edisu/core/widgets/commons.dart';
import 'package:open_edisu/features/booking/logic/booking_info_bloc.dart';
import 'package:open_edisu/features/booking/ui/widgets/booking_table.dart';
import 'package:open_edisu/features/halls/models/halls.dart';

class DragWithTouchAndMouse extends ScrollBehavior {
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
    return ScaffoldPage(
      header: PageHeader(title: Text(hall.hname)),
      content: BookingView(hall: hall),
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
          Button(
            onPressed: _decrease(context),
            child: const Icon(FluentIcons.chevron_left),
          ),
          DatePicker(
            selected: date,
            onChanged: (time) => changeDate(context, time),
            startDate: DateTime.now(),
            endDate: DateTime.now().add(const Duration(days: 70)),
          ),
          Button(
            onPressed: _increase(context),
            child: const Icon(FluentIcons.chevron_right),
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
