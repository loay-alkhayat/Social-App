abstract class SignUpStates {}

class SignUpInitialState extends SignUpStates {}

class SignUpLoadingState extends SignUpStates {}

class SignUpSucsessState extends SignUpStates {}

class SignUpErrorState extends SignUpStates {
  final String error;
  SignUpErrorState(this.error);
}

class SignUpChangeVisibilityPasswordState extends SignUpStates {}

class CreateUserLoadingState extends SignUpStates {}

class CreateUserSucsessState extends SignUpStates {}

class CreateUserErrorState extends SignUpStates {
  final String error;
  CreateUserErrorState(this.error);
}
