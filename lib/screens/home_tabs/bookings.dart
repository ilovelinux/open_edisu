part of '../home.dart';

class _BookingsView extends StatelessWidget {
  const _BookingsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookingsBloc, BookingsState>(
      builder: (context, state) {
        return state.when(
          (bookings) => _buildBookingView(context, bookings),
          loading: () => const LoadingWidget(),
          error: (e) => CenteredText(e),
        );
      },
    );
  }

  Widget _buildBookingView(BuildContext context, Bookings bookings) {
    Bookings coming = [];
    Bookings old = [];

    for (final booking in bookings) {
      if (booking.isComing()) {
        coming.add(booking);
      } else {
        old.add(booking);
      }
    }

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          flexibleSpace: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TabBar(
                tabs: [
                  RefreshIndicator(
                    onRefresh: () async => context
                        .read<BookingsBloc>()
                        .add(const BookingsEvent.update()),
                    child: const Tab(text: 'Future prenotazioni'),
                  ),
                  const Tab(text: 'Vecchie prenotazioni'),
                ],
              )
            ],
          ),
        ),
        body: TabBarView(
          children: [
            BookingList(bookings: coming),
            BookingList(bookings: old),
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
      return const CenteredText("Non ci sono prenotazioni al momento :(");
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
      leading: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Text("${booking.seatNo}")],
      ),
      title: Text(booking.hallName),
      subtitle: Text(DateFormat.yMEd().format(booking.date)),
      trailing: Text(
        "${booking.startTime.format(context)} - ${booking.endTime.format(context)}",
      ),
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
            child: QrImage(data: booking.bookingId),
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
        if (booking.isComing())
          TextButton(
            child: const Text("Cancella"),
            onPressed: () async {
              try {
                await bookingCancel(booking.id);
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
