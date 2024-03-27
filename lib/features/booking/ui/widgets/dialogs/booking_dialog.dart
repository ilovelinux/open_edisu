import 'dart:io';

import 'package:fluent_ui/fluent_ui.dart' as fu;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:open_edisu/core/utilities/extensions/time.dart';

import 'package:open_edisu/core/utilities/dio.dart';
import 'package:open_edisu/core/utilities/errors.dart';
import 'package:open_edisu/core/utilities/inceptor.dart';
import 'package:open_edisu/features/halls/models/halls.dart';
import 'package:open_edisu/features/booking/logic/bookings_bloc.dart';
import 'package:open_edisu/features/booking/models/booking.dart';

class BookingDialog extends StatelessWidget {
  const BookingDialog({
    super.key,
    required this.hall,
    required this.seat,
    required this.date,
    required this.slot,
  });

  final Hall hall;
  final BookedSeat seat;
  final DateTime date;
  final TimeRange slot;

  @override
  Widget build(BuildContext context) {
    final title = AppLocalizations.of(context)!.bookingConfirmationTitle;
    final content = AppLocalizations.of(context)!.bookingConfirmationContent(
      seat.seatNo,
      slot.timeStart.to24hours(),
      slot.timeEnd.to24hours(),
    );

    if (Platform.isAndroid) {
      return AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: <Widget>[
          TextButton(
            child: Text(AppLocalizations.of(context)!.yes),
            onPressed: () => _book(context),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(AppLocalizations.of(context)!.no),
          ),
        ],
      );
    }

    return fu.ContentDialog(
      title: fu.Text(title),
      content: fu.Text(content),
      actions: [
        fu.Button(
          child: fu.Text(AppLocalizations.of(context)!.yes),
          onPressed: () => _book(context),
        ),
        fu.FilledButton(
          onPressed: () => Navigator.of(context).pop(),
          child: fu.Text(AppLocalizations.of(context)!.no),
        ),
      ],
    );
  }

  void _book(BuildContext context) {
    client
        .customSlotBook(
          hall: hall,
          date: date,
          seatID: seat.id,
          slot: slot,
        )
        .then(
          (value) =>
              context.read<BookingsBloc>().add(const BookingsEvent.update()),
        )
        .catchError((e) => showErrorInDialog(context, getErrorString(e)))
        .whenComplete(() => Navigator.of(context).pop());
  }
}
