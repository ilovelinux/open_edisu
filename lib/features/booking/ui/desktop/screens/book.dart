import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:open_edisu/core/widgets/commons.dart';
import 'package:open_edisu/features/booking/logic/booking_info_bloc.dart';
import 'package:open_edisu/features/booking/logic/booking_table_cubit.dart';
import 'package:open_edisu/features/booking/logic/bookings_bloc.dart';
import 'package:open_edisu/features/booking/ui/widgets/booking_table.dart';
import 'package:open_edisu/features/booking/ui/widgets/date_selector.dart';
import 'package:open_edisu/features/booking/ui/widgets/dialogs/booking_dialog.dart';
import 'package:open_edisu/features/halls/models/halls.dart';

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
      child: ScaffoldPage(
        header: PageHeader(title: Text(hall.hname)),
        content: BookingView(hall: hall),
        bottomBar: _BookingButton(),
      ),
    );
  }
}

class BookingView extends StatelessWidget {
  final Hall hall;

  const BookingView({super.key, required this.hall});

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
        const SizedBox(height: 12.0),
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
                      builder: (BuildContext context) => ContentDialog(
                        title: Text(
                            AppLocalizations.of(context)!.bookingSuccessTitle),
                        content: Text(AppLocalizations.of(context)!
                            .bookingSuccessContent),
                        actions: [
                          FilledButton(
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Button(
          onPressed: decrease(context),
          style: ButtonStyle(iconSize: ButtonState.all(20)),
          child: const Icon(FluentIcons.chevron_left),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: DatePicker(
            selected: date,
            onChanged: (time) => changeDate(context, time),
            startDate: DateTime.now(),
            endDate: DateTime.now().add(const Duration(days: 70)),
          ),
        ),
        Button(
          onPressed: increase(context),
          style: ButtonStyle(iconSize: ButtonState.all(20)),
          child: const Icon(FluentIcons.chevron_right),
        ),
      ],
    );
  }
}

class _BookingButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookingTableCubit, BookingTableState>(
      builder: (context, state) => FilledButton(
        onPressed: _book(context, state),
        style: ButtonStyle(
          padding: ButtonState.all(const EdgeInsets.symmetric(vertical: 12)),
          shape: ButtonState.all<ShapeBorder>(LinearBorder.none),
        ),
        child: SizedBox(
          width: double.infinity,
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
