abstract class ServiceProvider {
  Future<void> register();

  T? responseConvert<T>(Map<String, dynamic> json) => null;
}
