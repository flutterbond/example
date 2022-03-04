import 'package:bloc_test/bloc_test.dart';
import 'package:fixit/core/auth/auth.dart';
import 'package:fixit/core/auth/authenticable.dart';
import 'package:fixit/core/constants.dart';
import 'package:fixit/core/models/single_m_response.dart';
import 'package:fixit/features/auth/data/models/user.dart';
import 'package:fixit/features/auth/data/models/user_meta.dart';
import 'package:fixit/features/auth/presentation/login/login_cubit.dart';
import 'package:fixit/features/auth/presentation/login/login_state.dart';
import 'package:fixit/injection_container.dart';
import 'package:fixit/routes/app_router.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../test_helpers.dart';
import 'factories/user_factory.dart';
import 'factories/user_meta_factory.dart';

@GenerateMocks([AppRouter])
void main() {
  setUp(() async {
    mockPackageInfo();
    mockSharedPreferences();
    await mockSetup();
    sl.registerLazySingleton<AuthDriver>(() {
      return SanctumDriver<Authenticable>();
    });
  });

  group('Login cubit tests', () {
    var user = UserFactory.create();
    var userMeta = UserMetaFactory.create();

    test('initial state should be InitialLoginState', () {
      expect(sl<LoginCubit>().state, equals(InitialLoginState()));
    });

    blocTest(
      "success login must emits [LoginLoading,LoginSuccess]",
      setUp: () {
        when(appRouter.pop(true)).thenAnswer((_) async => true);
        mockApiClient.fakePost(
          Api.login(),
          SingleMResponse<User, UserMeta>(user, userMeta).toJson(),
        );
      },
      build: () => sl<LoginCubit>(),
      act: (LoginCubit loginCubit) {
        return loginCubit.loginPressed(mobile: "123", password: "123456");
      },
      expect: () => [
        LoginLoading(),
        LoginSuccess(user: user),
      ],
      verify: (LoginCubit loginCubit) {
        expect(Auth.check(), equals(true));
        expect(Auth.user(), equals(user));
      },
    );

    blocTest(
      "failed login must emits [LoginLoading,LoginFailed]",
      setUp: () {
        mockApiClient.fakePost(
          Api.login(),
          "{ \"message\": \"Login Failed\" }",
          statusCode: 403,
        );
      },
      build: () => sl<LoginCubit>(),
      act: (LoginCubit loginCubit) {
        return loginCubit.loginPressed(mobile: "123", password: "123456");
      },
      expect: () => [
        LoginLoading(),
        const LoginFailed(error: "Login Failed"),
      ],
      verify: (LoginCubit loginCubit) {
        expect(Auth.check(), equals(false));
        expect(Auth.user(), isNull);
      },
    );
  });
}
