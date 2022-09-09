import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:open_edisu/core/utilities/extensions/time.dart';

import '../../../../../core/utilities/dio.dart';
import '../../../../../core/utilities/errors.dart';
import '../../../../../core/utilities/inceptor.dart';
import '../../../../halls/models/halls.dart';
import '../../../logic/bookings_bloc.dart';
import '../../../models/booking.dart';

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
          onPressed: () => client
              .customSlotBook(
                hall: hall,
                date: date,
                seatID: seat.id,
                slot: slot,
              )
              .then(
                (value) => context
                    .read<BookingsBloc>()
                    .add(const BookingsEvent.update()),
              )
              .catchError((e) => showErrorInDialog(context, getErrorString(e)))
              .whenComplete(() => Navigator.of(context).pop()),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(AppLocalizations.of(context)!.no),
        ),
      ],
    );
  }
}
