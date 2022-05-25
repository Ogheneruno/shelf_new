import 'dart:convert';

class UserData {
  final String username;
  final String email;
  final String id;

  UserData({
    required this.username,
    required this.email,
    required this.id,
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
