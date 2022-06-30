import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:open_edisu/utilities/errors.dart';
import 'package:window_manager/window_manager.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'bloc/auth_bloc.dart';
import 'models/edisu.dart';
import 'screens/home.dart';
import 'screens/login.dart';
import 'screens/signup.dart';
import 'utilities/inceptor.dart';
import 'widgets/commons.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initInceptor();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      windowManager.setSize(const Size(414, 736)); // To simulate phone screen
    }

    return BlocProvider(
      create: (_) => AuthBloc()..add(const AuthEvent.restore()),
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
        home: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) => state.whenOrNull<void>(
            authenticated: (user) => GetIt.I.registerSingleton(user),
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
      ),
    );
  }
}
