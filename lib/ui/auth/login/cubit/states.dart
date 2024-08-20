abstract class LoginStates {}

class LoginInitialState extends LoginStates {}

class LoginLoadingState extends LoginStates {}

class LoginErrorState extends LoginStates {
  String? errorMessage;

  LoginErrorState({required this.errorMessage});
}

class LoginSuccessState extends LoginStates {}

class LoginValidationState extends LoginStates {
  bool isErrorVisible;

  LoginValidationState({required this.isErrorVisible});
}
