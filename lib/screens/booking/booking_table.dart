part of 'booking.dart';

class _BookingTable extends StatelessWidget {
  const _BookingTable(this.bookingsPerSeats, {Key? key}) : super(key: key);

  final BookingsPerSeats bookingsPerSeats;

  @override
  Widget build(BuildContext context) {
    return BlocListener<bookings.BookingsBloc, bookings.BookingsState>(
      listenWhen: (_, current) =>
          current is bookings.Showing || current is bookings.Error,
      listener: (context, state) => state.whenOrNull<void>(
        (_) {
          final bloc = context.read<BookingInfoBloc>();
          bloc.add(DateChangeRequested(bloc.date));

          showDialog(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              title: const Text("Fatto!"),
              content: const Text("La prenotazione è avvenuta con successo."),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text("Ok"),
                ),
              ],
            ),
          );
        },
        error: (e) => context.read<ErrorCubit>().showInDialog(e),
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
    final slots = bookingsPerSeats.slots;
    return HorizontalDataTable(
      isFixedHeader: true,
      leftHandSideColumnWidth: 40,
      rightHandSideColumnWidth: _width * slots.length,
      headerWidgets: _getHeaderWidgets(slots),
      itemCount: bookingsPerSeats.seats.length,
      leftSideItemBuilder: (BuildContext context, int index) => Container(
        child: Text(bookingsPerSeats.seats[index].seatNo),
        width: 40,
        height: _height,
        padding: const EdgeInsets.fromLTRB(5, 0, 0, 5),
        alignment: Alignment.center,
      ),
      rightSideItemBuilder: (_, int index) =>
          _TableRow(slots, bookingsPerSeats.seats[index]),
    );
  }

  List<Widget> _getHeaderWidgets(List<TimeRange> slots) => <Widget>[
        const SizedBox(width: _width, height: 25),
        ...slots
            .map(
              (e) => Container(
                width: _width,
                height: 25,
                child: Text(e.timeStart.to24hours()),
                // padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                alignment: Alignment.center,
              ),
            )
            .toList(),
      ];
}

class _TableRow extends StatelessWidget {
  const _TableRow(this.slots, this.seat, {Key? key}) : super(key: key);

  final List<TimeRange> slots;
  final BookedSeat seat;

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
    if (seat.isBusy(slot)) {
      return unavailable;
    }

    return state.when(
      (selectedSeat, selectedSlot) =>
          selectedSeat.id == seat.id && slot.isAtTheSameMonmentAs(selectedSlot)
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
            child: const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text("PRENOTA"),
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
