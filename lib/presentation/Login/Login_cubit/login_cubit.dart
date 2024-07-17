import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/Shared/constatnce/string.dart';

import 'login_states.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);
  TextEditingController email_controller = TextEditingController();
  TextEditingController password_controller = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String? Uid;
  void userLogin({required String email, required String password}) {
    emit(LoginLoadingState());

    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      StringConstance.uID = value.user!.uid;
      emit(LoginSucsessState(value.user!.uid));
    }).catchError((error) {
      print(error.toString());
      emit(LoginErrorState(error.toString()));
    });
  }

  // Future signInWithGoogle() async {
  //   // Trigger the authentication flow
  //   final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
  //   if (googleUser == null) {
  //     return;
  //   }
  //
  //   // Obtain the auth details from the request
  //   final GoogleSignInAuthentication? googleAuth =
  //       await googleUser?.authentication;
  //
  //   // Create a new credential
  //   final credential = GoogleAuthProvider.credential(
  //     accessToken: googleAuth?.accessToken,
  //     idToken: googleAuth?.idToken,
  //   );
  //
  //   // Once signed in, return the UserCredential
  //   await FirebaseAuth.instance.signInWithCredential(credential);
  //   emit(LoginSucsessState());
  // }

  bool hidden = true;
  IconData? suffix = Icons.visibility_outlined;
  void changePasswordVisibilty() {
    hidden = !hidden;
    suffix = hidden ? Icons.visibility : Icons.visibility_off_sharp;
    emit(LoginChangeVisibilityPasswordState());
  }

  // String? tokenDevice;
  // getToken() async {
  //   await FirebaseMessaging.instance.getToken().then((value) {
  //     tokenDevice = value;
  //   });
  // }
}
