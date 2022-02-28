import 'package:fixit/features/app/launch_page.dart';
import 'package:fixit/features/home/home_page.dart';
import 'package:fixit/routes/middlewares/auth_middleware.dart';
import 'package:get/get.dart';

mixin AppPages {
  static const initial = 'launch';

  static final routes = [
    GetPage(
      name: 'launch',
      // binding: HomeBinding(),
      page: () => const LaunchPage(),
    ),
    GetPage(
      name: 'home',
      // binding: HomeBinding(),
      page: () => const HomePage(),
      middlewares: [AuthMiddleware()],
    ),
  ];
}
