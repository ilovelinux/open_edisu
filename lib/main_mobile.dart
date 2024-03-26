import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:open_edisu/core/utilities/errors.dart';

import 'package:open_edisu/core/widgets/commons.dart';
import 'package:open_edisu/features/auth/logic/auth_bloc.dart';
import 'package:open_edisu/features/auth/models/user.dart';
import 'package:open_edisu/features/auth/ui/mobile/screens/login.dart';
import 'package:open_edisu/features/auth/ui/mobile/screens/signup.dart';
import 'package:open_edisu/features/booking/logic/bookings_bloc.dart';
import 'package:open_edisu/features/home/ui/mobile/screens/home.dart';

Widget main() {
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarBrightness: Brightness.light,
    statusBarIconBrightness: Brightness.dark,
    statusBarColor: Colors.transparent,
    systemNavigationBarColor: Colors.transparent,
  ));

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  return const MobileApp();
}

class MobileApp extends StatelessWidget {
  const MobileApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Open Edisu',
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: ThemeData(
        colorSchemeSeed: const Color.fromRGBO(0xd0, 0x36, 0x29, 1),
      ),
      darkTheme: ThemeData(
        colorSchemeSeed: const Color.fromRGBO(0xd0, 0x36, 0x29, 1),
        brightness: Brightness.dark,
      ),
      routes: {
        'login': (_) => const LoginPage(),
        'signup': (_) => const SignupPage(),
      },
      home: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) => state.whenOrNull<void>(
          authenticated: (user) {
            GetIt.I.registerSingleton<User>(user);
            context.read<BookingsBloc>().add(const BookingsEvent.update());
          },
          unauthenticated: (
            final sessionExpired,
            final connectionError,
            final message,
          ) {
            if (GetIt.I.isRegistered<User>()) {
              GetIt.I.unregister<User>();
            }

            final error = connectionError
                ? AppLocalizations.of(context)!.connectionError
                : sessionExpired
                    ? AppLocalizations.of(context)!.sessionExpired
                    : message;

            if (error != null) {
              showErrorInSnackbar(context, error);
            }
          },
        ),
        builder: (context, state) => state.when(
          authenticated: (_) => const HomePage(),
          unauthenticated: (_, __, ___) => const LoginPage(),
          unknown: () => const Scaffold(body: LoadingWidget()),
        ),
      ),
    );
  }
}
