import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/auth_bloc.dart';
import '../../models/edisu.dart';

class AccountView extends StatefulWidget {
  const AccountView({Key? key}) : super(key: key);

  @override
  State<AccountView> createState() => _AccountViewState();
}

class _AccountViewState extends State<AccountView> {
  late final User user;

  @override
  void initState() {
    user = context
        .read<AuthBloc>()
        .state
        .whenOrNull(authenticated: (user) => user)!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final kDebugMode = false;

    return Scaffold(
      appBar: AppBar(title: const Text("Account")),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            const SizedBox(height: 40),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(60),
                color: Theme.of(context).primaryColor,
              ),
              padding: const EdgeInsets.all(10),
              child: Icon(
                Icons.person,
                size: 60,
                color: Theme.of(context).cardColor,
              ),
            ),
            const SizedBox(height: 40),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Flexible(
                  flex: 1,
                  child: TextFormField(
                    enabled: false,
                    initialValue: user.name,
                    decoration: InputDecoration(
                      labelText: "Name",
                      hintText: user.name,
                    ),
                  ),
                ),
                const SizedBox(width: 40.0),
                Flexible(
                  flex: 1,
                  child: TextFormField(
                    enabled: false,
                    initialValue: user.surname,
                    decoration: InputDecoration(
                      labelText: "Surname",
                      hintText: user.surname,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            TextFormField(
              enabled: false,
              initialValue: user.email,
              decoration: InputDecoration(
                labelText: "Email",
                hintText: user.email,
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              enabled: false,
              initialValue: user.studentCode,
              decoration: InputDecoration(
                labelText: "Student code",
                hintText: user.studentCode,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
