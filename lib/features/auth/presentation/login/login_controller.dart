import 'package:fixit/core/models/single_m_response.dart';
import 'package:fixit/features/auth/data/models/user.dart';
import 'package:fixit/features/auth/data/models/user_meta.dart';
import 'package:fixit/features/auth/data/repositories/auth_repository.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final AuthRepository authenticationRepository;

  LoginController(this.authenticationRepository);

  RxBool loading = false.obs;
  RxList errors = [].obs;

  Future<void> loginPressed(
      {required String mobile, required String password}) async {
    final response = await authenticationRepository.login(
      mobile,
      password,
    );
    return (response.fold(
      (failure) => onError,
      (response) => onSuccess,
    ));
  }

  onError(failure) {
    // Set loading flag to false to hide loading icon
    // Add errors to errors array to show validation errors
  }

  onSuccess(SingleMResponse<User, UserMeta> response) {
    // Redirect to home page
  }
}
