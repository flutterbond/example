import 'dart:io';

import 'package:fixit/config/auth.dart';
import 'package:fixit/core/auth/auth.dart';
import 'package:fixit/core/auth/authenticable.dart';
import 'package:fixit/core/service_provider.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:get_it/get_it.dart';

class ConfigServiceProvider extends ServiceProvider {
  @override
  Future<void> register(GetIt it) async {
    if (Platform.environment.containsKey('FLUTTER_TEST')) {
      FlutterConfig.loadValueForTesting({
        "API_BASE_URL": "http://example.com/api/v2/",
      });
    } else {
      await FlutterConfig.loadEnvVariables();
    }

    var guard = AuthConfig.defaultGuard;
    var guardDriver = AuthConfig.guards[guard]?['driver'];

    if (guardDriver == 'sanctum') {
      it.registerLazySingleton<AuthDriver>(() {
        return SanctumDriver<Authenticable>();
      });
    } else {
      it.registerLazySingleton<AuthDriver>(() {
        return GuestDriver();
      });
    }
  }
}
