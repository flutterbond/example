import 'dart:convert';

import 'package:fixit/features/auth/data/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../injection_container.dart';
import 'authenticable.dart';

class Auth {
  static AuthDriver authDriver = sl<AuthDriver>();

  static bool check() {
    return authDriver.check();
  }

  static Authenticable? user() {
    return authDriver.user();
  }

  static Future<bool> attempt(Authenticable user) async {
    return authDriver.attempt(user);
  }
}

class SanctumDriver<T> implements AuthDriver {
  @override
  bool check() {
    return sl<SharedPreferences>().containsKey('_user');
  }

  @override
  Authenticable? user() {
    if (check()) {
      var userJson = sl<SharedPreferences>().getString('_user')!;
      return User.fromJson(json.decode(userJson));
    }
    return null;
  }

  @override
  Future<bool> attempt(Authenticable user) async {
    return await sl<SharedPreferences>().setString(
      '_user',
      json.encode(user),
    );
  }
}

class GuestDriver<T> implements AuthDriver {
  @override
  bool check() {
    return false;
  }

  @override
  Authenticable? user() {
    return null;
  }

  @override
  Future<bool> attempt(Authenticable user) {
    throw UnimplementedError();
  }
}

abstract class AuthDriver {
  bool check();

  Authenticable? user();

  Future<bool> attempt(Authenticable user);
}
