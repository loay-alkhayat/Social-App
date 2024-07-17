abstract class LoginStates {}

class LoginInitialState extends LoginStates {}

class LoginLoadingState extends LoginStates {}

class LoginSucsessState extends LoginStates {
  final String uId;
  LoginSucsessState(this.uId);
}

class LoginErrorState extends LoginStates {
  final String error;
  LoginErrorState(this.error);
}

class LoginChangeVisibilityPasswordState extends LoginStates {}
