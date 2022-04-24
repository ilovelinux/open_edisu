part of 'booking.dart';

class _TimeTable2 extends StatelessWidget {
  final Slots slots;
  final SeatsList seats;

  const _TimeTable2({Key? key, required this.slots, required this.seats})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BookingTableAlternativeBloc(),
      child: HorizontalDataTable(
        isFixedHeader: true,
        leftHandSideColumnWidth: 40,
        rightHandSideColumnWidth: _width * slots.length,
        headerWidgets: _getHeaderWidgets(context),
        itemCount: seats.length,
        leftSideItemBuilder: (BuildContext context, int index) => Container(
          child: Text("${index + 1}"),
          width: 40,
          height: _height,
          padding: const EdgeInsets.fromLTRB(5, 0, 0, 5),
          alignment: Alignment.center,
        ),
        rightSideItemBuilder: (BuildContext context, int index) => _TableRow2(
          seatno: index + 1,
          seatd: seats[index],
          seat: seats[index].seat,
        ),
      ),
    );
  }

  List<Widget> _getHeaderWidgets(BuildContext context) => <Widget>[
        const SizedBox(width: _width, height: 25),
        ...slots
            .map(
              (e) => Container(
                width: _width,
                height: 25,
                child: Text(
                  MaterialLocalizations.of(context).formatTimeOfDay(
                    e.begin,
                    alwaysUse24HourFormat: true,
                  ),
                ),
                // padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                alignment: Alignment.center,
              ),
            )
            .toList(),
      ];
}

class _TableRow2 extends StatelessWidget {
  const _TableRow2({
    Key? key,
    required this.seatno,
    required this.seatd,
    required this.seat,
  }) : super(key: key);

  final int seatno;
  final Seats seatd;
  final List<Seat> seat;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookingTableAlternativeBloc,
        BookingTableAlternativeState>(
      // Build only if it's the selected row or the previously selected row
      buildWhen: (previous, current) => previous.when(
        (previousRow, _, __) => current.when(
          (row, _, __) =>
              previousRow == seatno && previousRow != row || row == seatno,
          unselected: () => previousRow == seatno,
        ),
        unselected: () => current.when(
          (row, _, __) => row == seatno,
          unselected: () => false,
        ),
      ),
      builder: (context, state) {
        return Row(
          children: seat
              .map(
                (Seat e) => _TableCell2(
                  seatno: seatno,
                  seat: e,
                  color: _getCellColor(state, e),
                ),
              )
              .toList(),
        );
      },
    );
  }

  Color _getCellColor(BookingTableAlternativeState state, Seat seat) {
    if (seat.bookingId != null) {
      return unavailable;
    }

    final slotTime = seat.slotTime!;

    return state.when(
      (row, startTime, endTime) =>
          row == seatno && slotTime >= startTime && slotTime <= endTime
              ? conflict
              : available,
      unselected: () => available,
    );
  }
}

class _TableCell2 extends StatelessWidget {
  const _TableCell2({
    Key? key,
    required this.seatno,
    required this.seat,
    required this.color,
  }) : super(key: key);

  final int seatno;
  final Seat seat;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context
          .read<BookingTableAlternativeBloc>()
          .add(BookingTableAlternativeEvent(seat, seatno)),
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
