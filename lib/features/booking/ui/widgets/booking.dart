import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

import '../../models/booking.dart';

class BookingTicket extends StatelessWidget {
  final Booking booking;
  final Function()? onTap;
  final bool showQrCode;

  const BookingTicket(
    this.booking, {
    super.key,
    this.onTap,
    this.showQrCode = true,
  });

  @override
  Widget build(BuildContext context) {
    return Card.outlined(
      margin: const EdgeInsets.symmetric(vertical: 12.0),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16.0),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SizedBox(
            height: 80,
            child: Row(
              children: [
                if (showQrCode)
                  PrettyQrView.data(
                    data: booking.bookingId.toUpperCase(),
                    decoration: PrettyQrDecoration(
                      shape: PrettyQrSmoothSymbol(
                        color: Theme.of(context).colorScheme.inverseSurface,
                      ),
                    ),
                  ),
                if (showQrCode) const VerticalDivider(),
                if (!showQrCode) const Spacer(),
                Column(
                  crossAxisAlignment: showQrCode
                      ? CrossAxisAlignment.start
                      : CrossAxisAlignment.center,
                  children: [
                    Text(
                      booking.hallName,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      booking.timeRange.format(context, " - "),
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
                    children: [
                      Text(
                        AppLocalizations.of(context)!.seatNo,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        booking.seatNo,
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
        ),
      ),
    );
  }
}
