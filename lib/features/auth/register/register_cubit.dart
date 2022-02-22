import 'package:fixit/core/errors/failures.dart';
import 'package:fixit/core/models/validation_response.dart';
import 'package:fixit/features/auth/data/dto/user_register.dart';
import 'package:fixit/features/auth/data/repositories/auth_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';

class RegisterCubitFixit extends FormBloc<String, String> {
  final AuthRepository authenticationRepository;
  RegisterCubitFixit(this.authenticationRepository) {
    addFieldBlocs(
      fieldBlocs: [
        userName,
        email,
        password,
        mobileNumber,
      ],
    );
  }

  final userName = TextFieldBloc(
    validators: [
      FieldBlocValidators.required,
    ],
  );

  final email = TextFieldBloc(
    validators: [
      FieldBlocValidators.required,
    ],
  );

  final password = TextFieldBloc(
    validators: [
      FieldBlocValidators.required,
    ],
  );
  final mobileNumber = TextFieldBloc(
    validators: [
      FieldBlocValidators.required,
    ],
  );

  @override
  void onSubmitting() async {
    List<TextFieldBloc> listOfTextFieldBloc = [
      userName,
      email,
      password,
      mobileNumber,
    ];
    UserDto user = UserDto(
      userName: userName.value,
      email: email.value,
      password: password.value,
      mobile: mobileNumber.value,
    );
    final response = await authenticationRepository.registerFixit(user);

    response.fold(
      (failure) {
        if (failure is ServerFailure) {
          Errors errors = Errors.fromJson(failure.errors);
          int i = 0;
          errors.toJson().forEach((key, listOfErrors) {
            if (listOfErrors != null) {
              listOfTextFieldBloc[i].addFieldError(listOfErrors.join('، '));
            }
            i++;
          });
          emitFailure(failureResponse: 'حدث خطأ ما');
        } else {
          debugPrint('failure is not ServerFailure');
          emitFailure(failureResponse: 'حدث خطأ ما');
        }
      },
      (response) => emitSuccess(),
    );
  }
}
