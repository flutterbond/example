import 'package:dio/dio.dart';
import 'package:fixit/core/service_provider.dart';
import 'package:get/get.dart';

import '../core/api_client.dart';

class ApiServiceProvider extends ServiceProvider {
  @override
  Future<void> register() async {
    var baseOptions = BaseOptions(
      connectTimeout: 100 * 1000,
      sendTimeout: 1000 * 1000,
      receiveTimeout: 1000 * 1000,
      receiveDataWhenStatusError: true,
      baseUrl: 'https://backend-develop.famcare.app/api/v2',
    );

    Get.lazyPut<Dio>(() => Dio(baseOptions), fenix: true);
    Get.lazyPut<ApiClient>(() => ApiClient(Get.find()), fenix: true);
  }
}
