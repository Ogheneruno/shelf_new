import 'dart:convert';

class User {
  final String username;
  final String email;
  final String password;

  User({
    required this.username,
    required this.email,
    required this.password,
  });

  @override
  String toString() => email;

  toJson() => jsonEncode(
        {
          'email': email,
          'username': username,
        },
      );
}
