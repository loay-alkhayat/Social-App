import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/layout/Main/layout_screen.dart';
import 'package:social_app/layout/cubit/socialapp_cubit.dart';

import '../../../Shared/components/textbutton_widget.dart';
import '../../../Shared/components/textfield_widget.dart';
import '../../../Shared/resources/assets_manager.dart';
import '../../../Shared/resources/color_manager.dart';
import '../../../Shared/resources/styles_manager.dart';
import '../../../Shared/resources/values_manager.dart';
import 'SignUp_cubit/signup_cubit.dart';
import 'SignUp_cubit/signup_states.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SignUpCubit cubit = SignUpCubit.get(context);
    return BlocConsumer<SignUpCubit, SignUpStates>(
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(child: Image.asset(ImageAssets.splashLogo)),
                SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(AppPadding.p18.w),
                    child: Form(
                      key: cubit.formKey,
                      child: Column(
                        children: [
                          Text(
                            "SignUp To Get Your Own Account",
                            style: getSemiBoldStyle(
                                color: ColorManager.darkGrey,
                                fontsize: AppSize.s14.sp),
                          ),
                          SizedBox(
                            height: AppSize.s10.h,
                          ),
                          Padding(
                            padding: EdgeInsets.all(AppPadding.p8.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                defaultTextForm(
                                    width: AppSize.s150.w,
                                    label: 'Firstname',
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "Please Enter your FirstName";
                                      }
                                    },
                                    controller: cubit.nameController,
                                    type: TextInputType.name),
                                defaultTextForm(
                                    width: AppSize.s150.w,
                                    label: "LastName",
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "Please Enter your LastName";
                                      }
                                    },
                                    controller: cubit.lastnameController,
                                    type: TextInputType.name),
                              ],
                            ),
                          ),
                          defaultTextForm(
                              controller: cubit.emailController,
                              sefixicon: Icons.email_outlined,
                              label: "Email",
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Please Enter your Email";
                                }
                              },
                              type: TextInputType.emailAddress),
                          SizedBox(
                            height: AppSize.s10.h,
                          ),
                          defaultTextForm(
                              controller: cubit.passwordController,
                              prassedSufix: () {
                                cubit.changePasswordVisibilty();
                              },
                              sefixicon: cubit.suffix,
                              hidden: cubit.hidden,
                              label: "Password",
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Please Enter your Password";
                                }
                              },
                              type: TextInputType.visiblePassword),
                          SizedBox(
                            height: AppSize.s20.h,
                          ),
                          ConditionalBuilder(
                              condition: state is! CreateUserLoadingState,
                              builder: (context) => defaultbutton(
                                  onpress: () {
                                    if (cubit.formKey.currentState!
                                        .validate()) {
                                      cubit.userRegister(
                                          firstname: cubit.nameController.text,
                                          lastname:
                                              cubit.lastnameController.text,
                                          email: cubit.emailController.text,
                                          password:
                                              cubit.passwordController.text);
                                    }
                                  },
                                  text: "SignUP",
                                  width: 400.w,
                                  fillbackground: true,
                                  backgroundcoloor: ColorManager.primary),
                              fallback: (context) => Center(
                                    child: CircularProgressIndicator(
                                      color: ColorManager.primary,
                                    ),
                                  ))
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
      listener: (context, state) {
        if (state is CreateUserSucsessState) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => BlocProvider.value(
                value: SocialAppCubit()..getUserData(),
                child: MainLayoutScreen(),
              ),
            ),
            (route) => false,
          );
        }
      },
    );
  }
}
