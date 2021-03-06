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
    final user = GetIt.I<User>();

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
            AppLocalizations.of(context)!.welcome(user.name, user.surname),
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
      title: Text(AppLocalizations.of(context)!.logout),
      content: Text(AppLocalizations.of(context)!.logoutMessage),
      actions: [
        TextButton(
          child: Text(AppLocalizations.of(context)!.yes),
          onPressed: () {
            context.read<AuthBloc>().add(const AuthEvent.logout());
            Navigator.of(context).popUntil((route) => route.isFirst);
          },
        ),
        TextButton(
          child: Text(AppLocalizations.of(context)!.no),
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
          Stack(
            alignment: Alignment.center,
            children: [
              Text(AppLocalizations.of(context)!.weeklyStatisticsTitle),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () => _showWeeklyStatisticsInfo(context),
                  child: Icon(
                    Icons.question_mark,
                    size: 14,
                    color: Colors.red.shade400,
                  ),
                ),
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.all(16.0),
            height: 150,
            child: BlocBuilder<BookingsBloc, BookingsState>(
              builder: (context, state) => state.when(
                success: (bookings) => _WeeklyChartbar(bookings),
                loading: () => const LoadingWidget(),
                error: (e) => CenteredText(
                  kDebugMode ? e : AppLocalizations.of(context)!.genericError,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showWeeklyStatisticsInfo(BuildContext context) => showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Text(AppLocalizations.of(context)!.weeklyStatisticsTitle),
          content:
              Text(AppLocalizations.of(context)!.weeklyStatisticsDescription),
        ),
      );
}

class _WeeklyChartbar extends StatelessWidget {
  final Bookings bookings;

  const _WeeklyChartbar(this.bookings);

  @override
  Widget build(BuildContext context) {
    final shortWeekDays =
        DateFormat.EEEE(Localizations.localeOf(context).toLanguageTag())
            .dateSymbols
            .SHORTWEEKDAYS;

    final bookingsPerWeekDay = groupBy(
      bookings.where((final e) => e.bookingStatus.isCompleted()),
      (final Booking e) => e.date.weekday,
    );

    return charts.BarChart(
      [
        charts.Series<int, String>(
          id: 'Bookings',
          colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
          domainFn: (int v, _) => shortWeekDays[v % 7],
          measureFn: (int v, _) => bookingsPerWeekDay[v]?.length ?? 0,
          data: List.generate(7, (index) => index + 1, growable: false),
        )
      ],
      animate: true,
    );
  }
}
