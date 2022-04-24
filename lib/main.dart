import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:window_manager/window_manager.dart';

import 'bloc/authentication_bloc.dart';
import 'cubit/error_cubit.dart';
import 'screens/home.dart';
import 'screens/login.dart';
import 'widgets/commons.dart';
import 'widgets/dialogs/error_dialog.dart';

void main() async => runApp(const MyApp());

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
        theme: ThemeData.from(
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromRGBO(0xd0, 0x36, 0x29, 1),
          ),
        ).copyWith(appBarTheme: const AppBarTheme(centerTitle: true)),
        home: BlocListener<ErrorCubit, ErrorState>(
          listener: (context, state) {
            if (state is SnackBarError) {
              ScaffoldMessenger.of(context)
                ..clearSnackBars()
                ..showSnackBar(
                  SnackBar(content: Text(state.message ?? "UNKNOWN ERROR")),
                );
            } else if (state is DialogError) {
              showDialog(
                context: context,
                builder: (_) => ErrorDialog(state.message ?? "UNKNOWN ERROR"),
              );
            }
          },
          child: BlocBuilder<AuthBloc, AuthenticationState>(
            builder: (context, state) {
              return state.when(
                (user) => const HomePage(),
                unauthenticated: (String? e) {
                  if (e != null) context.read<ErrorCubit>().showInSnackBar(e);
                  return const LoginPage();
                },
                unknown: () => const LoadingWidget(),
              );
            },
          ),
        ),
      ),
    );
  }
}
