import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../models/edisu.dart';

class BookingTicket extends StatelessWidget {
  final Booking booking;
  final Function()? onTap;

  const BookingTicket(this.booking, {Key? key, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10.0,
      margin: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SizedBox(
            height: 80,
            child: Row(
              children: [
                QrImage(
                  size: 80,
                  data: booking.bookingId.toUpperCase(),
                ),
                const VerticalDivider(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                  width: 60,
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
