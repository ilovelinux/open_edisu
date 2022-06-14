part of '../home.dart';

class _BookingsView extends StatelessWidget {
  const _BookingsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookingsBloc, BookingsState>(
      builder: (context, state) => state.when(
        success: (bookings) => _BookingViewBody(bookings),
        loading: () => const LoadingWidget(),
        error: (e) => CenteredText(e),
      ),
    );
  }
}

class _BookingViewBody extends StatelessWidget {
  const _BookingViewBody(this.bookings, {Key? key}) : super(key: key);

  final Bookings bookings;

  @override
  Widget build(BuildContext context) {
    Bookings upcoming = [];
    Bookings past = [];

    for (final booking in bookings) {
      if (booking.isUpcoming()) {
        upcoming.add(booking);
      } else {
        past.add(booking);
      }
    }

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          flexibleSpace: Align(
            alignment: Alignment.bottomCenter,
            child: TabBar(
              tabs: [
                Tab(text: AppLocalizations.of(context)!.upcomingBookings),
                Tab(text: AppLocalizations.of(context)!.pastBookings),
              ],
            ),
          ),
        ),
        body: TabBarView(
          children: [
            BookingList(bookings: upcoming),
            BookingList(bookings: past),
          ],
        ),
      ),
    );
  }
}

class BookingList extends StatelessWidget {
  const BookingList({Key? key, required this.bookings}) : super(key: key);

  final Bookings bookings;

  @override
  Widget build(BuildContext context) {
    if (bookings.isEmpty) {
      return CenteredText("${AppLocalizations.of(context)!.noBookings} :(");
    }
    return ListView.builder(
      itemCount: bookings.length,
      itemBuilder: (_, index) => BookingListTile(booking: bookings[index]),
    );
  }
}

class BookingListTile extends StatelessWidget {
  const BookingListTile({Key? key, required this.booking}) : super(key: key);

  final Booking booking;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: booking.bookingStatus.isPending() ? Colors.amber : null,
      leading: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Text("${booking.seatNo}")],
      ),
      title: Text(booking.hallName),
      subtitle: Text(
        [
          DateFormat.yMEd(Localizations.localeOf(context).toLanguageTag())
              .format(booking.date),
          if (kDebugMode) booking.bookingStatus.toString()
        ].join(" "),
      ),
      trailing: Text(booking.timeRange.format(context, " - ")),
      onTap: () => showDialog(
        context: context,
        builder: (_) => BlocProvider.value(
          value: context.read<BookingsBloc>(),
          child: _BookingDialog(booking: booking),
        ),
      ),
    );
  }
}

class _BookingDialog extends StatelessWidget {
  const _BookingDialog({Key? key, required this.booking}) : super(key: key);

  final Booking booking;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        "${booking.hallName}: ${DateFormat.yMd().format(booking.date)} "
        "${booking.startTime.format(context)} - ${booking.endTime.format(context)}",
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 200,
            height: 200,
            child: QrImage(
              data: booking.bookingId.toUpperCase(),
            ),
          ),
          Text(
            booking.bookingId,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          child: const Text("Ok"),
          onPressed: () => Navigator.of(context).pop(),
        ),
        if (booking.isUpcoming())
          TextButton(
            child: const Text("Cancella"),
            onPressed: () async {
              try {
                await client.bookingCancel(booking.id);
                context.read<BookingsBloc>().add(const BookingsEvent.update());
              } catch (e) {
                context.read<ErrorCubit>().showInDialog(e.toString());
              }
              Navigator.of(context).pop();
            },
          ),
      ],
    );
  }
}
