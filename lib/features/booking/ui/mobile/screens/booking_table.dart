import 'dart:io';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';
import 'package:open_edisu/core/utilities/extensions/date.dart';
import 'package:open_edisu/core/utilities/extensions/time.dart';
import 'package:open_edisu/core/widgets/commons.dart';
import 'package:open_edisu/features/booking/logic/booking_info_bloc.dart';
import 'package:open_edisu/features/booking/logic/booking_table_cubit.dart';
import 'package:open_edisu/features/booking/logic/bookings_bloc.dart';
import 'package:open_edisu/features/booking/models/booking.dart';
import 'package:open_edisu/features/booking/ui/config.dart';
import 'package:open_edisu/features/booking/ui/mobile/screens/book.dart';
import 'package:open_edisu/features/booking/ui/widgets/dialogs/booking_dialog.dart';

class BookingTable extends StatelessWidget {
  const BookingTable(this.slots, this.bookingsPerSeats, {super.key});

  final Slots slots;
  final BookingsPerSeats bookingsPerSeats;

  @override
  Widget build(BuildContext context) {
    return BlocListener<BookingsBloc, BookingsState>(
      listener: (context, state) => state.whenOrNull<void>(
        success: (_) {
          final bloc = context.read<BookingInfoBloc>();
          bloc.add(BookingInfoEvent.changeDate(bloc.date));

          showDialog(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              title: Text(AppLocalizations.of(context)!.bookingSuccessTitle),
              content:
                  Text(AppLocalizations.of(context)!.bookingSuccessContent),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text("Ok"),
                ),
              ],
            ),
          );
        },
      ),
      child: BlocProvider(
        create: (context) => BookingTableCubit(),
        child: ScrollConfiguration(
          behavior: DragWithTouchAndMouse(),
          child: Column(
            children: [
              Expanded(
                  child: TimeTable(slots.withSeparators, bookingsPerSeats)),
              _BookingButton(),
            ],
          ),
        ),
      ),
    );
  }
}

class TimeTable extends StatelessWidget {
  const TimeTable(this.allSlots, this.bookingsPerSeats);

  final Slots allSlots;
  final BookingsPerSeats bookingsPerSeats;

  @override
  Widget build(BuildContext context) {
    final Slots slots = bookingsPerSeats.futureSlots.isNotEmpty
        ? allSlots
            .skipWhile((slot) =>
                slot == slotSeparator ||
                slot.timeStart < bookingsPerSeats.futureSlots.first.timeStart)
            .toList()
        : const [];

    if (slots.isEmpty) {
      return CenteredText(AppLocalizations.of(context)!.noSlotsAvailable);
    }

    final bookingsOfTheDay = groupBy(
      context.read<BookingsBloc>().bookings.where((booking) =>
          booking.date.isAtSameDayAs(bookingsPerSeats.date) &&
          booking.isUpcoming()),
      (Booking booking) => booking.seatNo,
    );

    return HorizontalDataTable(
      isFixedHeader: true,
      leftHandSideColumnWidth: 40,
      rightHandSideColumnWidth: tableConfig.ui.width * slots.length -
          slots.separatorsCount *
              (tableConfig.ui.width - tableConfig.ui.separatorWidth),
      headerWidgets: _getHeaderWidgets(slots),
      itemCount: bookingsPerSeats.seats.length,
      leftSideItemBuilder: (BuildContext context, int index) => Container(
        width: 40,
        height: tableConfig.ui.height,
        padding: const EdgeInsets.fromLTRB(5, 0, 0, 5),
        alignment: Alignment.center,
        child: Text(bookingsPerSeats.seats[index].seatNo),
      ),
      rightSideItemBuilder: (_, int index) => _TableRow(
        slots: slots,
        seat: bookingsPerSeats.seats[index],
        bookedSlots: bookingsOfTheDay[index + 1],
      ),
      horizontalScrollbarStyle:
          Platform.isWindows ? const ScrollbarStyle(isAlwaysShown: true) : null,
      leftHandSideColBackgroundColor: Theme.of(context).colorScheme.background,
      rightHandSideColBackgroundColor: Theme.of(context).colorScheme.background,
    );
  }

  List<Widget> _getHeaderWidgets(Slots slots) => <Widget>[
        SizedBox(width: tableConfig.ui.width, height: 25),
        ...slots.map(
          (e) => Container(
            width: e == slotSeparator
                ? tableConfig.ui.separatorWidth
                : tableConfig.ui.width,
            height: 25,
            // padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
            alignment: Alignment.center,
            child: Text(e == slotSeparator ? "" : e.begin.to24hours()),
          ),
        ),
      ];
}

class _TableRow extends StatelessWidget {
  const _TableRow({
    required this.slots,
    required this.seat,
    Bookings? bookedSlots,
  }) : bookedSlots = bookedSlots ?? const [];

  final Slots slots;
  final BookedSeat seat;
  final Bookings bookedSlots;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookingTableCubit, BookingTableState>(
      // Build only if it's the selected row or the previously selected row
      buildWhen: (previous, current) => previous.when(
        selected: (previousSeat, _) => current.when(
          selected: (currentSeat, _) =>
              previousSeat == seat || currentSeat == seat,
          unselected: () => previousSeat == seat,
        ),
        unselected: () => current.when(
          selected: (currentSeat, _) => currentSeat == seat,
          unselected: () => false,
        ),
      ),
      builder: (context, state) => Row(
        children: slots
            .map((e) => _TableCell(seat, e, color: _getCellColor(state, e)))
            .toList(),
      ),
    );
  }

  Color _getCellColor(BookingTableState state, Slot slot) {
    if (slot == slotSeparator) {
      return tableConfig.colors.unavailable;
    }

    if (bookedSlots.any((b) => slot.isAtTheSameMomentAs(b.timeRange))) {
      return tableConfig.colors.booked;
    }

    if (seat.isBusy(slot)) {
      return tableConfig.colors.unavailable;
    }

    return state.when(
      selected: (selectedSeat, selectedSlot) =>
          selectedSeat.id == seat.id && slot.isAtTheSameMomentAs(selectedSlot)
              ? tableConfig.colors.conflict
              : tableConfig.colors.available,
      unselected: () => tableConfig.colors.available,
    );
  }
}

class _TableCell extends StatelessWidget {
  const _TableCell(this.seat, this.slot, {required this.color});

  final BookedSeat seat;
  final TimeRange slot;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.read<BookingTableCubit>().select(seat, slot),
      child: Container(
        width: (slot == slotSeparator
                ? tableConfig.ui.separatorWidth
                : tableConfig.ui.width) -
            tableConfig.ui.margin * 2,
        height: tableConfig.ui.height - tableConfig.ui.margin * 2,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          color: color,
        ),
        margin: EdgeInsets.all(tableConfig.ui.margin),
      ),
    );
  }
}

class _BookingButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookingTableCubit, BookingTableState>(
      builder: (context, state) => Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
        child: FilledButton(
          onPressed: _book(context, state),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(AppLocalizations.of(context)!.bookingButton),
          ),
        ),
      ),
    );
  }

  Function()? _book(BuildContext context, BookingTableState state) {
    return state.whenOrNull(
      selected: (seat, slot) => () {
        final bookingInfoBloc = context.read<BookingInfoBloc>();
        showDialog(
          context: context,
          builder: (_) => BlocProvider.value(
            value: bookingInfoBloc,
            child: BlocProvider.value(
              value: context.read<BookingsBloc>(),
              child: BookingDialog(
                hall: bookingInfoBloc.hall,
                seat: seat,
                date: bookingInfoBloc.date,
                slot: slot,
              ),
            ),
          ),
        );
      },
    );
  }
}
