import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../bloc/bookings_bloc.dart';
import '../../cubit/error_cubit.dart';
import '../../models/edisu.dart';
import '../../utilities/extensions/time.dart';
import '../../utilities/inceptor.dart';

class BookingDialog extends StatelessWidget {
  const BookingDialog({
    Key? key,
    required this.hall,
    required this.seat,
    required this.date,
    required this.slot,
  }) : super(key: key);

  final Hall hall;
  final BookedSeat seat;
  final DateTime date;
  final TimeRange slot;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(AppLocalizations.of(context)!.bookingConfirmationTitle),
      content: Text(
        AppLocalizations.of(context)!.bookingConfirmationContent(
          seat.seatNo,
          slot.timeStart.to24hours(),
          slot.timeEnd.to24hours(),
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: Text(AppLocalizations.of(context)!.yes),
          onPressed: () async {
            try {
              await client.customSlotBook(
                hall: hall,
                date: date,
                seatID: seat.id,
                slot: slot,
              );
              context.read<BookingsBloc>().add(const BookingsEvent.update());
            } catch (e) {
              context.read<ErrorCubit>().showInDialog(e.toString());
            }
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(AppLocalizations.of(context)!.no),
        ),
      ],
    );
  }
}
