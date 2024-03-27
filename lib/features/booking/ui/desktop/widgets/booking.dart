import 'dart:math';
import 'dart:ui';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

import 'package:open_edisu/features/booking/models/booking.dart';

class BookingTicket extends StatefulWidget {
  final Booking booking;
  final bool minimal;
  final Function(BuildContext, Booking)? dialogBuilder;

  const BookingTicket(
    this.booking, {
    super.key,
    this.dialogBuilder,
    this.minimal = false,
  });

  @override
  State<BookingTicket> createState() => _BookingTicketState();
}

class _BookingTicketState extends State<BookingTicket> {
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    final qrCodeSize = min(
      300.0,
      deviceSize.width > deviceSize.height
          ? deviceSize.height * 0.6
          : deviceSize.width * 0.6,
    );

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Expander(
        headerBackgroundColor: widget.booking.isUpcoming()
            ? null
            : FluentTheme.of(context).brightness == Brightness.light
                ? ButtonState.all(Colors.grey[20])
                : ButtonState.all(Colors.red.withAlpha(32)),
        contentPadding: widget.minimal
            ? const EdgeInsets.all(16).copyWith(top: 8)
            : const EdgeInsets.only(top: 8),
        leading: widget.minimal
            ? null
            : Stack(
                children: [
                  Container(
                    height: widget.booking.isUpcoming() ? 80 : 70,
                    margin: widget.booking.isUpcoming()
                        ? null
                        : const EdgeInsets.only(left: 5, top: 5),
                    child: PrettyQrView.data(
                      data: widget.booking.bookingId.toUpperCase(),
                      decoration: PrettyQrDecoration(
                        shape: PrettyQrSmoothSymbol(
                          color: FluentTheme.of(context).iconTheme.color!,
                        ),
                      ),
                    ),
                  ),
                  if (!widget.booking.isUpcoming())
                    ClipRect(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
                        blendMode: BlendMode.srcOver,
                        child: const SizedBox(height: 80, width: 80),
                      ),
                    ),
                ],
              ),
        header: Container(
          margin: const EdgeInsets.all(16),
          height: 80,
          child: Column(
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
        ),
        trailing: Container(
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
            Text(
              AppLocalizations.of(context)!.bookingId(widget.booking.bookingId),
            ),
            if (!widget.minimal && widget.booking.isUpcoming())
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: FilledButton(
                  onPressed: () => showDialog(
                    context: context,
                    builder: (context) =>
                        widget.dialogBuilder!(context, widget.booking),
                  ),
                  style: ButtonStyle(
                    padding: ButtonState.all(
                        const EdgeInsets.symmetric(vertical: 12)),
                    shape: ButtonState.all<ShapeBorder>(LinearBorder.none),
                  ),
                  child: SizedBox(
                    width: double.infinity,
                    child: Text(AppLocalizations.of(context)!.delete),
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}
