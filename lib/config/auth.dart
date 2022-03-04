import 'package:fixit/features/auth/data/models/driver.dart';
import 'package:fixit/features/auth/data/models/user.dart';

class AuthConfig {
  static var defaultGuard = 'users';

  static var guards = {
    'users': {
      'driver': 'sanctum',
      'model': User,
    },
    'drivers': {
      'driver': 'sanctum',
      'model': Driver,
    },
  };
}
