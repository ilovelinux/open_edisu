part of 'booking.dart';

class _BookingTable extends StatelessWidget {
  const _BookingTable(this.bookingsPerSeats, {Key? key}) : super(key: key);

  final BookingsPerSeats bookingsPerSeats;

  @override
  Widget build(BuildContext context) {
    return BlocListener<bookings.BookingsBloc, bookings.BookingsState>(
      listenWhen: (_, current) => current is bookings.Showing,
      listener: (context, state) => state.whenOrNull<void>(
        (_) {
          final bloc = context.read<BookingInfoBloc>();
          bloc.add(DateChangeRequested(bloc.date));

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
        create: (context) => BookingTableBloc(),
        child: Column(
          children: [
            Expanded(child: _TimeTable(bookingsPerSeats)),
            _BookingButton(),
          ],
        ),
      ),
    );
  }
}

class _TimeTable extends StatelessWidget {
  const _TimeTable(this.bookingsPerSeats, {Key? key}) : super(key: key);

  final BookingsPerSeats bookingsPerSeats;

  @override
  Widget build(BuildContext context) {
    final slots = bookingsPerSeats.futureSlots;
    final bookingsOfTheDay = groupBy(
      context.read<BookingsBloc>().bookings.where((booking) =>
          booking.date.isAtSameDayAs(bookingsPerSeats.date) &&
          booking.isComing()),
      (Booking booking) => booking.seatNo,
    );

    return HorizontalDataTable(
      isFixedHeader: true,
      leftHandSideColumnWidth: 40,
      rightHandSideColumnWidth: _width * slots.length,
      headerWidgets: _getHeaderWidgets(slots),
      itemCount: bookingsPerSeats.seats.length,
      leftSideItemBuilder: (BuildContext context, int index) => Container(
        width: 40,
        height: _height,
        padding: const EdgeInsets.fromLTRB(5, 0, 0, 5),
        alignment: Alignment.center,
        child: Text(bookingsPerSeats.seats[index].seatNo),
      ),
      rightSideItemBuilder: (_, int index) => _TableRow(
        slots: slots,
        seat: bookingsPerSeats.seats[index],
        bookedSlots: bookingsOfTheDay[index + 1],
      ),
    );
  }

  List<Widget> _getHeaderWidgets(List<TimeRange> slots) => <Widget>[
        const SizedBox(width: _width, height: 25),
        ...slots
            .map(
              (e) => Container(
                width: _width,
                height: 25,
                // padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                alignment: Alignment.center,
                child: Text(e.timeStart.to24hours()),
              ),
            )
            .toList(),
      ];
}

class _TableRow extends StatelessWidget {
  const _TableRow({
    Key? key,
    required this.slots,
    required this.seat,
    Bookings? bookedSlots,
  })  : bookedSlots = bookedSlots ?? const [],
        super(key: key);

  final List<TimeRange> slots;
  final BookedSeat seat;
  final Bookings bookedSlots;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookingTableBloc, BookingTableState>(
      // Build only if it's the selected row or the previously selected row
      buildWhen: (previous, current) => previous.when(
        (previousSeat, _) => current.when(
          (currentSeat, _) => previousSeat == seat || currentSeat == seat,
          unselected: () => previousSeat == seat,
        ),
        unselected: () => current.when(
          (currentSeat, _) => currentSeat == seat,
          unselected: () => false,
        ),
      ),
      builder: (context, state) {
        return Row(
          children: slots
              .map((e) => _TableCell(seat, e, color: _getCellColor(state, e)))
              .toList(),
        );
      },
    );
  }

  Color _getCellColor(BookingTableState state, TimeRange slot) {
    for (final booking in bookedSlots) {
      if (slot.isAtTheSameMomentAs(
        TimeRange(timeStart: booking.startTime, timeEnd: booking.endTime),
      )) {
        return booked;
      }
    }

    if (seat.isBusy(slot)) {
      return unavailable;
    }

    return state.when(
      (selectedSeat, selectedSlot) =>
          selectedSeat.id == seat.id && slot.isAtTheSameMomentAs(selectedSlot)
              ? conflict
              : available,
      unselected: () => available,
    );
  }
}

class _TableCell extends StatelessWidget {
  const _TableCell(
    this.seat,
    this.slot, {
    Key? key,
    required this.color,
  }) : super(key: key);

  final BookedSeat seat;
  final TimeRange slot;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () =>
          context.read<BookingTableBloc>().add(BookingTableEvent(seat, slot)),
      child: Container(
        width: _width - _margin * 2,
        height: _height - _margin * 2,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          color: color,
        ),
        margin: const EdgeInsets.all(_margin),
      ),
    );
  }
}

class _BookingButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookingTableBloc, BookingTableState>(
      builder: (context, state) {
        return SizedBox(
          width: double.infinity,
          child: OutlinedButton(
            onPressed: _book(context, state),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(AppLocalizations.of(context)!.bookingButton),
            ),
          ),
        );
      },
    );
  }

  Function()? _book(BuildContext context, BookingTableState state) {
    return state.when(
      (seat, slot) => () {
        final bookingInfoBloc = context.read<BookingInfoBloc>();
        showDialog(
          context: context,
          builder: (_) => BlocProvider.value(
            value: context.read<BookingInfoBloc>(),
            child: BlocProvider.value(
              value: context.read<bookings.BookingsBloc>(),
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
      unselected: () => null,
    );
  }
}
