import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/Shared/components/toast_widget.dart';
import 'package:social_app/Shared/network/local/cache_helper.dart';
import 'package:social_app/layout/cubit/socialapp_cubit.dart';

import '../../../Shared/components/textbutton_widget.dart';
import '../../../Shared/components/textfield_widget.dart';
import '../../../Shared/resources/assets_manager.dart';
import '../../../Shared/resources/color_manager.dart';
import '../../../Shared/resources/routes_manager.dart';
import '../../../Shared/resources/styles_manager.dart';
import '../../../Shared/resources/values_manager.dart';
import 'Login_cubit/login_cubit.dart';
import 'Login_cubit/login_states.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LoginCubit cubit = LoginCubit.get(context);
    return BlocConsumer<LoginCubit, LoginStates>(
      builder: (context, state) => SafeArea(
        child: Scaffold(
          body: Form(
            key: cubit.formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(child: Image.asset(ImageAssets.splashLogo)),
                SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(AppPadding.p18.h),
                    child: Column(
                      children: [
                        defaultTextForm(
                            validator: (value) {
                              if (value!.isEmpty) return "Cant Be Empty!";

                              // if (RegExp(r'[!#<>?":_~`;[\]\\|=+)'
                              //         r'(*&^%-]')
                              //     .hasMatch(value)) {
                              //   return 'Must Have Only Char';
                              // }
                            },
                            sefixicon: Icons.email_outlined,
                            label: "Email",
                            controller: cubit.email_controller,
                            type: TextInputType.emailAddress),
                        SizedBox(
                          height: AppSize.s12.h,
                        ),
                        defaultTextForm(
                            validator: (value) {
                              if (value!.isEmpty) return "Cant Be Empty..!";
                            },
                            hidden: cubit.hidden,
                            sefixicon: cubit.suffix,
                            label: "Password",
                            prassedSufix: () {
                              cubit.changePasswordVisibilty();
                            },
                            controller: cubit.password_controller,
                            type: TextInputType.visiblePassword),
                        SizedBox(
                          height: AppSize.s20.h,
                        ),
                        ConditionalBuilder(
                          condition: state is! LoginLoadingState,
                          builder: (context) => defaultbutton(
                            onpress: () {
                              if (cubit.formKey.currentState!.validate()) {
                                cubit.userLogin(
                                    email: cubit.email_controller.text,
                                    password: cubit.password_controller.text);
                              }
                            },
                            width: 400.w,
                            fillbackground: true,
                            backgroundcoloor: ColorManager.primary,
                            text: "Login",
                          ),
                          fallback: (context) => Center(
                            child: CircularProgressIndicator(
                              color: ColorManager.primary,
                            ),
                          ),
                        ),
                        // SizedBox(
                        //   height: 10.h,
                        // ),
                        // ConditionalBuilder(
                        //   condition: state is! LoginLoadingState,
                        //   builder: (context) => defaultbutton(
                        //     onpress: () {
                        //       cubit.signInWithGoogle();
                        //     },
                        //     width: AppSize.s220,
                        //     text: "SignUP With Google",
                        //     backgroundcoloor: ColorManager.lightprimary,
                        //     fillbackground: true,
                        //   ),
                        //   fallback: (context) => Center(
                        //     child: CircularProgressIndicator(
                        //       color: ColorManager.primary,
                        //     ),
                        //   ),
                        // ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Dont Have Account..?"),
                            TextButton(
                              style: ButtonStyle(
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      side: BorderSide(
                                          color: Theme.of(context)
                                              .scaffoldBackgroundColor),
                                    ),
                                  ),
                                  backgroundColor: MaterialStatePropertyAll(
                                      Theme.of(context)
                                          .scaffoldBackgroundColor)),
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, Routes.registerRoute);
                              },
                              child: Text(
                                "Register",
                                style: getRegularStyle(
                                    color: ColorManager.primary,
                                    fontsize: 14.sp),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      listener: (context, state) async {
        if (state is LoginErrorState) {
          CustomToast.showToast(context, "تأكد من صحة حسابك",
              ColorManager.error, ColorManager.white);
        }
        if (state is LoginSucsessState) {
          print(state.uId);

          SocialAppCubit.get(context).getUserData();

          await CacheHelper.saveData(key: "uID", value: state.uId)
              .then((value) {
            CustomToast.showToast(context, "تم تسجيل دخولك بنجاح!",
                ColorManager.primary, ColorManager.white);
            Navigator.pushNamedAndRemoveUntil(
                context, Routes.mainRoute, (route) => false);

            cubit.email_controller.clear();
            cubit.password_controller.clear();
          });
        }
      },
    );
  }
}
