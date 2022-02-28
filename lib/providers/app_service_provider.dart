import 'package:fixit/core/service_provider.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppServiceProvider extends ServiceProvider {
  @override
  Future<void> register() async {
    await Get.putAsync(SharedPreferences.getInstance);

    await Get.putAsync(() => PackageInfo.fromPlatform());
  }
}
