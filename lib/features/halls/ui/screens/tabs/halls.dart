import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:maps_launcher/maps_launcher.dart';

import '../../../../../core/widgets/commons.dart';
import '../../../../booking/logic/bookings_bloc.dart';
import '../../../../booking/ui/screens/booking.dart';
import '../../../logic/halls_bloc.dart';
import '../../../models/halls.dart';

class HallsView extends StatelessWidget {
  const HallsView({super.key});

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
  const _HallCard({required this.hall, required this.hallMobile});

  final Hall hall;
  final HallMobile hallMobile;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      margin: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: Colors.black45),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: InkWell(
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => BlocProvider.value(
              value: context.read<BookingsBloc>(),
              child: BookingPage(hall: hall),
            ),
          ),
        ),
        child: Container(
          padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
          constraints: const BoxConstraints(minHeight: 100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    hallMobile.name,
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    constraints: const BoxConstraints(minWidth: 85),
                    child: Row(
                      children: [
                        Text(
                          "${AppLocalizations.of(context)!.seats}:  "
                              .toUpperCase(),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(hall.husable.toString()),
                      ],
                    ),
                  ),
                ],
              ),
              TextButton.icon(
                onPressed: () => MapsLauncher.launchQuery(hallMobile.location),
                icon: const Icon(Icons.location_pin, size: 16),
                label: Text(hallMobile.location),
                style: ButtonStyle(
                  padding: MaterialStateProperty.all(
                    const EdgeInsets.fromLTRB(0, 2, 2, 2),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
