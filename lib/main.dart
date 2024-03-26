import 'dart:io';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:open_edisu/features/home/ui/screens/home_desktop.dart';

import 'core/utilities/errors.dart';
import 'core/utilities/inceptor.dart';
import 'features/auth/logic/auth_bloc.dart';
import 'features/auth/models/user.dart';
import 'features/auth/ui/screens/login.dart';
import 'features/auth/ui/screens/signup.dart';
import 'features/booking/logic/bookings_bloc.dart';
import 'features/home/ui/screens/home.dart';
import 'core/widgets/commons.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initInceptor();

  if (Platform.isAndroid) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.dark,
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.transparent,
    ));
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (_) => AuthBloc()..add(const AuthEvent.restore()),
        ),
        BlocProvider<BookingsBloc>(
          create: (_) => BookingsBloc(),
        ),
      ],
      child: Platform.isAndroid ? const MobileApp() : const DesktopApp(),
    );
  }
}

class DesktopApp extends StatelessWidget {
  const DesktopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FluentApp(
      title: 'Open Edisu',
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
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
          authenticated: (_) => const HomePageDesktop(),
          unauthenticated: (_, __, ___) => const LoginPage(),
          unknown: () => const Scaffold(body: LoadingWidget()),
        ),
      ),
    );
  }
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
