part of '../home.dart';

class _HallsView extends StatelessWidget {
  const _HallsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HallsBloc()..add(const HallsUpdateRequested()),
      child: BlocBuilder<HallsBloc, HallsState>(
        builder: (context, state) {
          return state.when(
            (halls) => Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: halls.map((hall) => _HallCard(hall: hall)).toList(),
            ),
            loading: () => const LoadingWidget(),
            error: (e) => CenteredText(e),
          );
        },
      ),
    );
  }
}

class _HallCard extends StatelessWidget {
  final Hall hall;
  const _HallCard({Key? key, required this.hall}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
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
          padding: const EdgeInsets.all(32.0),
          child: Text(hall.building),
        ),
      ),
    );
  }
}
