part of '../home.dart';

class _HallsView extends StatelessWidget {
  const _HallsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HallsBloc()..add(const HallsEvent.update()),
      child: BlocBuilder<HallsBloc, HallsState>(
        builder: (context, state) => state.when(
          success: (halls, hallsMobile) => SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: halls
                  .map(
                    (hall) => _HallCard(
                      hall: hall,
                      hallMobile: hallsMobile.firstWhere(
                        (element) => element.name == hall.hname,
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
          loading: () => const LoadingWidget(),
          error: (e) => CenteredText(
            kDebugMode ? e : AppLocalizations.of(context)!.genericError,
          ),
        ),
      ),
    );
  }
}

class _HallCard extends StatelessWidget {
  final Hall hall;
  final HallMobile hallMobile;
  const _HallCard({Key? key, required this.hall, required this.hallMobile})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10.0,
      margin: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
      child: InkWell(
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => BlocProvider.value(
              value: context.read<BookingsBloc>(),
              child: BookingPage(hall: hall),
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SizedBox(
            height: 70,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  hallMobile.name,
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.location_pin, size: 16),
                    Flexible(child: Text(hallMobile.location)),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
