import 'dart:io';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_edisu/main_mobile.dart' as mobile;
import 'package:open_edisu/main_desktop.dart' as desktop;

import 'package:open_edisu/core/utilities/inceptor.dart';
import 'package:open_edisu/features/auth/logic/auth_bloc.dart';
import 'package:open_edisu/features/booking/logic/bookings_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initInceptor();

  Widget app;
  if (Platform.isAndroid) {
    app = mobile.main();
  } else {
    app = desktop.main();
  }

  runApp(MyApp(app));
}

class MyApp extends StatelessWidget {
  final Widget child;

  const MyApp(this.child, {super.key});

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
      child: child,
    );
  }
}
