import 'dart:io';

import 'package:fixit/core/service_provider.dart';
import 'package:flutter_config/flutter_config.dart';

class ConfigServiceProvider extends ServiceProvider {
  @override
  Future<void> register() async {
    if (Platform.environment.containsKey('FLUTTER_TEST')) {
      FlutterConfig.loadValueForTesting({
        "API_BASE_URL": "http://example.com/api/v2/",
      });
    } else {
      await FlutterConfig.loadEnvVariables();
    }
  }
}
