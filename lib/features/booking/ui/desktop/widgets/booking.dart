import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

import 'package:open_edisu/features/booking/models/booking.dart';

class BookingTicket extends StatefulWidget {
  final Booking booking;
  final Function()? onTap;
  final bool minimal;
  final Function(BuildContext, Booking)? dialogBuilder;

  const BookingTicket(
    this.booking, {
    super.key,
    this.dialogBuilder,
    this.onTap,
    this.minimal = false,
  });

  @override
  State<BookingTicket> createState() => _BookingTicketState();
}

class _BookingTicketState extends State<BookingTicket> {
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    final qrCodeSize = deviceSize.width > deviceSize.height
        ? deviceSize.height * 0.6
        : deviceSize.width * 0.6;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Expander(
        // leading: Text("Ok"),
        header: Container(
          margin: const EdgeInsets.all(16),
          height: 80,
          child: Row(
            children: [
              if (!widget.minimal)
                PrettyQrView.data(
                  data: widget.booking.bookingId.toUpperCase(),
                  decoration: PrettyQrDecoration(
                    shape: PrettyQrSmoothSymbol(
                      color: FluentTheme.of(context).iconTheme.color!,
                    ),
                  ),
                ),
              if (!widget.minimal) const Divider(direction: Axis.vertical),
              const Spacer(),
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
              const Divider(direction: Axis.vertical),
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
        content: Column(
          children: [
            Container(
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
            if (!widget.minimal)
              Button(
                onPressed: () => showDialog(
                  context: context,
                  builder: (context) =>
                      widget.dialogBuilder!(context, widget.booking),
                ),
                child: Text("Delete booking"),
              )
          ],
        ),
      ),
    );
  }
}
