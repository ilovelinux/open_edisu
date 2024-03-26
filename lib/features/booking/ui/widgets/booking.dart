import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

import 'package:open_edisu/core/utilities/dio.dart';
import 'package:open_edisu/core/utilities/errors.dart';
import 'package:open_edisu/core/utilities/inceptor.dart';
import 'package:open_edisu/features/booking/logic/bookings_bloc.dart';
import 'package:open_edisu/features/booking/models/booking.dart';

class BookingTicket extends StatefulWidget {
  final Booking booking;
  final Function()? onTap;
  final bool minimal;

  const BookingTicket(
    this.booking, {
    super.key,
    this.onTap,
    this.minimal = false,
  });

  @override
  State<BookingTicket> createState() => _BookingTicketState();
}

class _BookingTicketState extends State<BookingTicket> {
  bool show = false;

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    final qrCodeSize = deviceSize.width > deviceSize.height
        ? deviceSize.height * 0.6
        : deviceSize.width * 0.6;

    return Card.outlined(
      elevation: 10,
      margin: const EdgeInsets.symmetric(vertical: 12.0),
      child: InkWell(
        onTap: widget.onTap ?? () => setState(() => show = !show),
        borderRadius: BorderRadius.circular(16.0),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              SizedBox(
                height: 80,
                child: Row(
                  children: [
                    if (!widget.minimal)
                      PrettyQrView.data(
                        data: widget.booking.bookingId.toUpperCase(),
                        decoration: PrettyQrDecoration(
                          shape: PrettyQrSmoothSymbol(
                            color: Theme.of(context).colorScheme.inverseSurface,
                          ),
                        ),
                      ),
                    if (!widget.minimal) const VerticalDivider(),
                    if (widget.minimal) const Spacer(),
                    Column(
                      crossAxisAlignment: widget.minimal
                          ? CrossAxisAlignment.start
                          : CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          widget.booking.hallName,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          widget.booking.timeRange.format(context, " - "),
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    const Spacer(),
                    const VerticalDivider(),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      width: 70,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.seatNo,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            widget.booking.seatNo,
                            style: const TextStyle(
                              fontSize: 18,
                              fontFamily: "Monospace",
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              AnimatedSize(
                duration: const Duration(milliseconds: 250),
                curve: Curves.fastOutSlowIn,
                child: SizedBox(
                  height: show ? null : 0,
                  child: Container(
                    color: Colors.white,
                    width: qrCodeSize,
                    height: qrCodeSize,
                    margin: const EdgeInsets.symmetric(vertical: 20),
                    padding: const EdgeInsets.all(10),
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: Container(
                        alignment: Alignment.center,
                        child: PrettyQrView.data(
                          data: widget.booking.bookingId.toUpperCase(),
                          decoration: const PrettyQrDecoration(
                            shape: PrettyQrRoundedSymbol(
                              borderRadius: BorderRadius.zero,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              if (show) Text("Booking id: " + widget.booking.bookingId),
              if (!widget.minimal && show)
                TextButton(
                  onPressed: () => _deleteBooking(context),
                  child: Text("Delete booking"),
                ),
            ],
          ),
        ),
      ),
    );
  }

  void _deleteBooking(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Delete booking"),
        content: const Text("Are you sure you wanna delete booking"),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("No, keep it"),
          ),
          TextButton(
            child: const Text("Yes, delete!"),
            onPressed: () => client
                .bookingCancel(widget.booking.id)
                .then((_) => context
                    .read<BookingsBloc>()
                    .add(const BookingsEvent.update()))
                .catchError(
                    (e) => showErrorInDialog(context, getErrorString(e)))
                .whenComplete(() => Navigator.of(context).pop()),
          ),
        ],
        actionsAlignment: MainAxisAlignment.spaceBetween,
      ),
    );
  }
}
