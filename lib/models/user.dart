part of 'edisu.dart';

class User {
  final String name;
  final String surname;
  final String email;
  final String creationDate;
  final bool newsletter;
  final bool notification;
  final String userType;
  final String studentCode;
  final int studentType;
  final bool studentDisabled;
  final int uniID;
  final int id;

  User(Map<String, dynamic> data)
      : name = data["name"],
        surname = data["surname"],
        email = data["email"],
        creationDate = data["creationDate"],
        newsletter = data["newsletter"] == 1,
        notification = data["notification"] == 1,
        userType = data["userType"],
        studentCode = data["studentCode"],
        studentType = data["studentType"],
        studentDisabled = data["studentDisabled"] == 1,
        uniID = data["uniID"],
        id = data["id"];

  static Future<User> signin(String email, String password) async {
    final response = await client
        .postAPIRaw(urls.signin, body: {'email': email, 'password': password});

    await client.setToken(response["token"]);
    return User(response["result"]["data"]);
  }

  static Future<User> getInfo() async {
    final response = await client.postAPI(urls.me);

    return User(response["data"]);
  }
}
