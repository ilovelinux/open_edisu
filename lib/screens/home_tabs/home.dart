part of '../home.dart';

class _Home extends StatelessWidget {
  const _Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: const [
        _UserCard(),
        _WeeklyStatisticsCard(),
      ],
    );
  }
}

class _UserCard extends StatelessWidget {
  const _UserCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = (context.read<AuthBloc>().state as Authenticated).user;

    return Card(
      margin: const EdgeInsets.all(16.0),
      child: InkWell(
        onTap: () => showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext c) => BlocProvider.value(
            value: context.read<AuthBloc>(),
            child: const _LogoutDialog(),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Text(
            "Benvenuto, ${user.name} ${user.surname}!",
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 18.0,
            ),
          ),
        ),
      ),
    );
  }
}

class _LogoutDialog extends StatelessWidget {
  const _LogoutDialog();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Logout'),
      content: const Text('Vuoi uscire?'),
      actions: [
        TextButton(
          child: const Text('Si'),
          onPressed: () {
            context.read<AuthBloc>().add(const AuthenticationEvent.logout());
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: const Text('No'),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
    );
  }
}

class _WeeklyStatisticsCard extends StatelessWidget {
  const _WeeklyStatisticsCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          const Text("Weekly statistics"),
          Container(
            margin: const EdgeInsets.all(16.0),
            height: 150,
            child: BlocBuilder<BookingsBloc, BookingsState>(
              builder: (context, state) {
                return state.when(
                  (bookings) => _WeeklyChartbar(bookings),
                  loading: () => const LoadingWidget(),
                  error: (e) => CenteredText(e),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _WeeklyChartbar extends StatelessWidget {
  final Bookings bookings;

  const _WeeklyChartbar(this.bookings);

  @override
  Widget build(BuildContext context) {
    final shortWeekDays = DateFormat.EEEE().dateSymbols.SHORTWEEKDAYS;
    final counterPerWeek = List.filled(shortWeekDays.length, 0);

    for (final booking in bookings) {
      counterPerWeek[booking.date.weekday - 1]++;
    }

    return charts.BarChart(
      [
        charts.Series<MapEntry<int, int>, String>(
          id: 'Bookings',
          colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
          domainFn: (MapEntry<int, int> v, _) => shortWeekDays[v.key],
          measureFn: (MapEntry<int, int> v, _) => v.value,
          data: counterPerWeek.asMap().entries.toList(),
        )
      ],
      animate: true,
    );
  }
}
