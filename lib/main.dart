import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:window_manager/window_manager.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'bloc/auth_bloc.dart';
import 'cubit/error_cubit.dart';
import 'screens/home.dart';
import 'screens/login.dart';
import 'screens/signup.dart';
import 'utilities/inceptor.dart';
import 'widgets/commons.dart';
import 'widgets/dialogs/error_dialog.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  initInceptor();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      windowManager.setSize(const Size(414, 736)); // To simulate phone screen
    }

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ErrorCubit()),
        BlocProvider(create: (_) => AuthBloc()..add(const RestoreRequested())),
      ],
      child: MaterialApp(
        title: 'Open Edisu',
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        theme: ThemeData.from(
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromRGBO(0xd0, 0x36, 0x29, 1),
          ),
        ).copyWith(appBarTheme: const AppBarTheme(centerTitle: true)),
        routes: {
          'login': (_) => const LoginPage(),
          'signup': (_) => const SignupPage(),
        },
        home: BlocListener<ErrorCubit, ErrorState>(
          listener: (context, state) => state.when(
            () => null,
            dialogError: (final String? message) => showDialog(
              context: context,
              builder: (_) => ErrorDialog(message ?? "UNKNOWN ERROR"),
            ),
            snackBarError: (final String? message) =>
                ScaffoldMessenger.of(context)
                  ..clearSnackBars()
                  ..showSnackBar(
                    SnackBar(content: Text(message ?? "UNKNOWN ERROR")),
                  ),
          ),
          child: BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) => state.whenOrNull<void>(
              unauthenticated: (final sessionExpired, final message) {
                final error = sessionExpired
                    ? AppLocalizations.of(context)!.sessionExpired
                    : message;

                if (error != null) {
                  context.read<ErrorCubit>().showInSnackBar(error);
                }
              },
            ),
            builder: (context, state) => state.when(
              authenticated: (_) => const HomePage(),
              unauthenticated: (_, __) => const LoginPage(),
              unknown: () => const LoadingWidget(),
            ),
          ),
        ),
      ),
    );
  }
}
