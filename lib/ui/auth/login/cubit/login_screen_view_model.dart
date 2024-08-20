import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:kafiil_test/domain/use_cases/login_use_case.dart';
import 'package:kafiil_test/ui/auth/login/cubit/states.dart';

import '../../../../utils/my_theme.dart';

class LoginScreenViewModel extends Cubit<LoginStates> {
  LoginScreenViewModel({required this.loginUseCase})
      : super(LoginInitialState());

  final LoginUseCase loginUseCase;

  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isObscure = true;
  bool rememberMe = false;
  bool isErrorVisible = false;
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  Future<void> savePassword(String password) async {
    await _secureStorage.write(key: 'password', value: password);
  }

  Future<void> saveRememberMeState() async {
    await _secureStorage.write(key: 'isLoggedIn', value: 'true');
  }

  Future<bool> isLoggedIn() async {
    final isLoggedIn = await _secureStorage.read(key: 'isLoggedIn');
    return isLoggedIn == 'true';
  }

  void validateForm() {
    final form = formKey.currentState;
    if (form != null && form.validate()) {
      isErrorVisible = false;
    } else {
      isErrorVisible = true;
    }
    emit(LoginValidationState(isErrorVisible: isErrorVisible));
  }

  void login() async {
    if (formKey.currentState!.validate()) {
      emit(LoginLoadingState());

      var either = await loginUseCase.invoke(
          emailController.text.trim(), passwordController.text.trim());

      either.fold(
        (failure) => emit(LoginErrorState(errorMessage: failure.errorMessage)),
        (response) async {
          await savePassword(passwordController.text.trim());

          if (rememberMe) {
            await saveRememberMeState();
          }

          emit(LoginSuccessState());
        },
      );
    }
  }

  void showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Center(
          child: CircularProgressIndicator(
            backgroundColor: MyTheme.primary900Color.withOpacity(0.5),
          ),
        );
      },
    );
  }

  void dismissLoadingDialog(BuildContext context) {
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    }
  }
}
