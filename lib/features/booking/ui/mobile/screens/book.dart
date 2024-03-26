import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:open_edisu/core/widgets/commons.dart';
import 'package:open_edisu/features/booking/logic/booking_info_bloc.dart';
import 'package:open_edisu/features/booking/logic/booking_table_cubit.dart';
import 'package:open_edisu/features/booking/logic/bookings_bloc.dart';
import 'package:open_edisu/features/booking/ui/widgets/booking_table.dart';
import 'package:open_edisu/features/booking/ui/widgets/date_selector.dart';
import 'package:open_edisu/features/booking/ui/widgets/dialogs/booking_dialog.dart';
import 'package:open_edisu/features/halls/models/halls.dart';

class DragWithTouchAndMouse extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        PointerDeviceKind.trackpad,
      };
}

class BookingPage extends StatelessWidget {
  final Hall hall;

  const BookingPage({super.key, required this.hall});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => BookingTableCubit(),
        ),
        BlocProvider(
            create: (context) => BookingInfoBloc(hall)
              ..add(BookingInfoEvent.changeDate(DateTime.now()))),
      ],
      child: Scaffold(
        appBar: AppBar(title: Text(hall.hname)),
        body: const BookingView(),
        persistentFooterButtons: [
          TextButton(onPressed: () {}, child: _BookingButton())
        ],
      ),
    );
  }
}

class BookingView extends StatelessWidget {
  const BookingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocBuilder<BookingInfoBloc, BookingInfoState>(
          buildWhen: (_, current) => current.maybeWhen(
            update: () => true,
            orElse: () => false,
          ),
          builder: (context, _) =>
              _DateSelector(date: context.read<BookingInfoBloc>().date),
        ),
        Expanded(
          child: BlocBuilder<BookingInfoBloc, BookingInfoState>(
            builder: (context, state) => state.when(
              success: (slots, bookingsPerSeat) =>
                  BlocListener<BookingsBloc, BookingsState>(
                listener: (context, state) => state.whenOrNull<void>(
                  success: (_) {
                    final bloc = context.read<BookingInfoBloc>();
                    bloc.add(BookingInfoEvent.changeDate(bloc.date));

                    showDialog(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: Text(
                            AppLocalizations.of(context)!.bookingSuccessTitle),
                        content: Text(AppLocalizations.of(context)!
                            .bookingSuccessContent),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: const Text("Ok"),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                child: BookingTable(slots, bookingsPerSeat),
              ),
              loading: () => const LoadingWidget(),
              update: () => const LoadingWidget(),
              error: (e) => CenteredText(e),
            ),
          ),
        ),
      ],
    );
  }
}

class _DateSelector extends BaseDateSelector {
  const _DateSelector({required super.date});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          TextButton(
            onPressed: decrease(context),
            child: const Icon(Icons.arrow_back),
          ),
          TextButton(
            onPressed: () => showDatePicker(
              context: context,
              initialDate: date,
              firstDate: DateTime.now(),
              lastDate: DateTime.now().add(const Duration(days: 7)),
            ).then((newDate) {
              if (newDate != null) {
                changeDate(context, newDate);
              }
            }),
            child: Text(
                DateFormat.yMEd(Localizations.localeOf(context).toLanguageTag())
                    .format(date)),
          ),
          TextButton(
            onPressed: increase(context),
            child: const Icon(Icons.arrow_forward),
          ),
        ],
      ),
    );
  }
}

class _BookingButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookingTableCubit, BookingTableState>(
      builder: (context, state) => SizedBox(
        width: double.infinity,
        child: FilledButton(
          onPressed: _book(context, state),
          style: ButtonStyle(
            padding: MaterialStateProperty.all<EdgeInsets>(
              const EdgeInsets.all(16.0),
            ),
          ),
          child: Text(AppLocalizations.of(context)!.bookingButton),
        ),
      ),
    );
  }

  Function()? _book(BuildContext context, BookingTableState state) {
    return state.whenOrNull(
      selected: (seat, slot) => () {
        final bookingInfoBloc = context.read<BookingInfoBloc>();
        showDialog(
          context: context,
          builder: (_) => BlocProvider.value(
            value: bookingInfoBloc,
            child: BlocProvider.value(
              value: context.read<BookingsBloc>(),
              child: BookingDialog(
                hall: bookingInfoBloc.hall,
                seat: seat,
                date: bookingInfoBloc.date,
                slot: slot,
              ),
            ),
          ),
        );
      },
    );
  }
}
