import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get_it/get_it.dart';

import 'package:open_edisu/features/auth/logic/auth_bloc.dart';
import 'package:open_edisu/features/auth/models/user.dart';
import 'package:open_edisu/features/auth/ui/desktop/screens/login.dart';
import 'package:open_edisu/features/booking/logic/bookings_bloc.dart';
import 'package:open_edisu/features/home/ui/desktop/screens/home.dart';

Widget main() {
  return const DesktopApp();
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
      },
      theme: FluentThemeData(
        accentColor: Colors.red,
      ),
      darkTheme: FluentThemeData(
        accentColor: Colors.red,
        brightness: Brightness.dark,
      ),
      // themeMode: ThemeMode.dark,
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
          ) async {
            if (GetIt.I.isRegistered<User>()) {
              GetIt.I.unregister<User>();
            }

            final error = connectionError
                ? AppLocalizations.of(context)!.connectionError
                : sessionExpired
                    ? AppLocalizations.of(context)!.sessionExpired
                    : message;

            if (error != null) {
              await displayInfoBar(context, builder: (context, close) {
                return InfoBar(
                  title: const Text('Error'),
                  content: Text(error),
                  action: IconButton(
                    icon: const Icon(FluentIcons.clear),
                    onPressed: close,
                  ),
                  severity: InfoBarSeverity.error,
                );
              });
            }
          },
        ),
        builder: (context, state) => state.when(
          authenticated: (_) => const HomePageDesktop(),
          unauthenticated: (_, __, ___) =>
              const NavigationView(content: LoginPage()),
          unknown: () =>
              const ScaffoldPage(content: Center(child: ProgressRing())),
        ),
      ),
    );
  }
}
