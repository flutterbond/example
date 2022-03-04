import 'package:auto_route/auto_route.dart';
import 'package:fixit/core/auth/auth.dart';

import '../../injection_container.dart';
import '../app_router.dart';

class AuthGuard extends AutoRouteGuard {
  @override
  Future<void> onNavigation(
    NavigationResolver resolver,
    StackRouter router,
  ) async {
    if (Auth.check()) {
      resolver.next(true);
    } else {
      final bool result = await router.push<bool>(const LoginRoute()) ?? false;
      resolver.next(result);
    }
  }
}
