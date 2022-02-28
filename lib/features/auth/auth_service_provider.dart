import 'package:fixit/core/service_provider.dart';
import 'package:get/get.dart';

import 'data/datasources/auth_local_data_source.dart';
import 'data/datasources/auth_remote_data_source.dart';
import 'data/models/country.dart';
import 'data/models/user.dart';
import 'data/models/user_meta.dart';
import 'data/repositories/auth_repository.dart';
import 'data/services/apple_id_login_service.dart';
import 'data/services/google_account_login_service.dart';
import 'presentation/activation/activation_cubit.dart';
import 'presentation/bloc/auth_bloc.dart';
import 'presentation/complete_registeration/complete_registration_cubit.dart';
import 'presentation/forget_password/forget_password_cubit.dart';
import 'presentation/login/login_cubit.dart';
import 'presentation/register/register_cubit.dart';
import 'presentation/reset_password/reset_password_cubit.dart';
import 'presentation/social_account_login/apple_id_login/apple_id_login_cubit.dart';
import 'presentation/social_account_login/google_account_login/google_account_login_cubit.dart';

class AuthServiceProvider extends ServiceProvider {
  @override
  Future<void> register() async {
    Get.lazyPut(() => AuthRemoteDataSource(Get.find()), fenix: true);
    Get.lazyPut(() => AuthLocalDataSource(Get.find()), fenix: true);

    Get.lazyPut(() => AuthRepository(Get.find(), Get.find()), fenix: true);

    Get.lazyPut(() => GoogleAccountLoginService(), fenix: true);
    Get.lazyPut(() => AppleIdLoginService(), fenix: true);

    Get.lazyPut(() => RegisterCubit(Get.find()), fenix: true);
    Get.lazyPut(() => CompleteRegistrationCubit(Get.find()), fenix: true);
    Get.lazyPut(() => LoginCubit(Get.find()), fenix: true);
    Get.lazyPut(() => GoogleAccountLoginCubit(Get.find(), Get.find()),
        fenix: true);
    Get.lazyPut(() => AppleIdLoginCubit(Get.find(), Get.find()), fenix: true);
    Get.lazyPut(() => ForgetPasswordCubit(Get.find()), fenix: true);
    Get.lazyPut(() => ActivationCubit(Get.find()), fenix: true);
    Get.lazyPut(() => ActivationCubit(Get.find()), fenix: true);
    Get.lazyPut(() => ResetPasswordCubit(Get.find()), fenix: true);

    Get.lazyPut(() => AuthBloc(Get.find()), fenix: true);
  }

  @override
  T? responseConvert<T>(Map<String, dynamic> json) {
    switch (T) {
      case User:
        return User.fromJson(json) as T;
      case UserMeta:
        return UserMeta.fromJson(json) as T;
      case Country:
        return Country.fromJson(json) as T;
      default:
        return null;
    }
  }
}
