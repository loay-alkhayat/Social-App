import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/Shared/constatnce/string.dart';
import 'package:social_app/models/social_user_model/social_user_model.dart';
import 'package:social_app/presentation/SignUp/SignUp_cubit/signup_states.dart';

class SignUpCubit extends Cubit<SignUpStates> {
  SignUpCubit() : super(SignUpInitialState());

  static SignUpCubit get(context) => BlocProvider.of(context);
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool hidden = true;
  IconData? suffix = Icons.visibility_outlined;
  void changePasswordVisibilty() {
    hidden = !hidden;
    suffix = hidden ? Icons.visibility : Icons.visibility_off_sharp;
    emit(SignUpChangeVisibilityPasswordState());
  }

  Future userRegister(
      {required String email,
      required String password,
      required String firstname,
      required String lastname}) async {
    emit(SignUpLoadingState());

    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {
      createUser(
        firstname: firstname,
        email: email,
        uId: value.user!.uid,
        lastname: lastname,
      );
      StringConstance.uID = value.user!.uid;
      print(value.user!.uid);
    }).catchError((error) {
      emit(SignUpErrorState(error.toString()));
    });
  }

  void createUser({
    required String firstname,
    required String lastname,
    required String email,
    required String uId,
  }) {
    emit(CreateUserLoadingState());
    SocialUserModel model = SocialUserModel(
      firstname: firstname,
      lastname: lastname,
      email: email,
      uId: uId,
      bio: "Write your Bio..",
      cover:
          "https://plus.unsplash.com/premium_photo-1667899358372-802ada9fb00c?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2070&q=80",
      image: "https://images.unsplash"
          ".com/photo-1494790108377-be9c29b29330?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1887&q=80",
    );
    FirebaseFirestore.instance
        .collection("users")
        .doc(uId)
        .set(model.ToMap())
        .then((value) {
      emit(CreateUserSucsessState());
    }).catchError((error) {
      emit(
        CreateUserErrorState(error.toString()),
      );
    });
  }

// String? tokenDevice;
// getToken() async {
//   await FirebaseMessaging.instance.getToken().then((value) {
//     tokenDevice = value;
//   });
// }
}
