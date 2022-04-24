import 'dart:developer';

import 'constants/api.dart';
import '../models/edisu.dart';

Future<User> Function(String, String) login = User.signin;
Future<void> logout() async => client.setToken(null);

Future<User?> restore() async {
  log("Restoring client session");
  await client.restore();

  if (client.isAuthenticated()) {
    return await User.getInfo();
  }

  log("Client wasn't authenticated");
  return null;
}
