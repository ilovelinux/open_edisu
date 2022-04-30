import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_edisu/utilities/api.dart';

import '../../bloc/bookings_bloc.dart';
import '../../cubit/error_cubit.dart';
import '../../models/edisu.dart';
import '../../utilities/extensions/time.dart';

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
      title: const Text('Conferma prenotazione'),
      content: Text(
        "Vuoi prenotare il posto ${seat.seatNo} "
        "dalle ${slot.timeStart.to24hours()} alle ${slot.timeEnd.to24hours()}",
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('Si'),
          onPressed: () async {
            try {
              await customSlotBook(
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
          child: const Text('No'),
        ),
      ],
    );
  }
}
