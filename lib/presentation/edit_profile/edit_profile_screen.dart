import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/Shared/components/textbutton_widget.dart';
import 'package:social_app/Shared/components/textfield_widget.dart';
import 'package:social_app/Shared/resources/color_manager.dart';
import 'package:social_app/Shared/resources/values_manager.dart';
import 'package:social_app/layout/cubit/socialapp_cubit.dart';
import 'package:social_app/layout/cubit/socialapp_states.dart';

class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialAppCubit, SocialAppStates>(
      builder: (context, state) {
        SocialAppCubit cubit = SocialAppCubit.get(context);

        var bioController = TextEditingController(text: cubit.userModel!.bio);
        var firstNameController =
            TextEditingController(text: cubit.userModel!.firstname);
        var lastNameController =
            TextEditingController(text: cubit.userModel!.lastname);

        ImageProvider<Object> backgroundImage;
        if (cubit.profileImage == null) {
          backgroundImage = NetworkImage("${cubit.userModel!.image}");
        } else {
          backgroundImage = FileImage(cubit.profileImage!);
        }

        return Scaffold(
          appBar: AppBar(
            title: Text("Edit Profile"),
            actions: [
              defaultbutton(
                text: "UPDATE",
                onpress: () {
                  cubit.updateUser(
                      lastname: lastNameController.text,
                      firstname: firstNameController.text,
                      Bio: bioController.text);
                },
                width: AppSize.s110,
              ),
            ],
          ),
          body: Padding(
            padding: EdgeInsets.all(AppPadding.p8.w),
            child: SingleChildScrollView(
              reverse: true,
              child: Column(
                children: [
                  Container(
                    height: AppSize.s210.h,
                    child: Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        Align(
                          alignment: AlignmentDirectional.topCenter,
                          child: Stack(
                            alignment: AlignmentDirectional.topEnd,
                            children: [
                              Container(
                                width: double.infinity,
                                height: AppSize.s150.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(
                                      AppSize.s4,
                                    ),
                                    topLeft: Radius.circular(
                                      AppSize.s4,
                                    ),
                                  ),
                                  image: cubit.coverImage != null
                                      ? DecorationImage(
                                          image: FileImage(cubit.coverImage!),
                                          fit: BoxFit.fill)
                                      : DecorationImage(
                                          image: NetworkImage(
                                              cubit.userModel!.cover!),
                                          fit: BoxFit.fill),
                                ),
                              ),
                              IconButton(
                                  onPressed: () {
                                    cubit.getCoverImage();
                                  },
                                  icon: CircleAvatar(
                                    child: Icon(Icons.camera_alt_outlined,
                                        size: AppSize.s16,
                                        color: ColorManager.white),
                                    backgroundColor:
                                        Theme.of(context).primaryColor,
                                    radius: AppSize.s20.w,
                                  )),
                            ],
                          ),
                        ),
                        Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            CircleAvatar(
                              backgroundColor:
                                  Theme.of(context).scaffoldBackgroundColor,
                              radius: AppSize.s65,
                              child: CircleAvatar(
                                radius: AppSize.s60,
                                backgroundImage: backgroundImage,
                              ),
                            ),
                            IconButton(
                                onPressed: () {
                                  cubit.getProfileImage();
                                },
                                icon: CircleAvatar(
                                  child: Icon(Icons.camera_alt_outlined,
                                      size: AppSize.s16,
                                      color: ColorManager.white),
                                  backgroundColor:
                                      Theme.of(context).primaryColor,
                                  radius: AppSize.s20.w,
                                )),
                          ],
                        ),
                      ],
                    ),
                  ),
                  if (cubit.profileImage != null ||
                      cubit.coverImage != null &&
                          state is! SocialAppGetUserDataSucsessState)
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: AppPadding.p8.h),
                      child: Row(
                        children: [
                          if (cubit.profileImage != null)
                            Expanded(
                              child: Column(
                                children: [
                                  defaultbutton(
                                      text: "Upload Profile",
                                      onpress: () {
                                        cubit.uploadProfileImage(
                                            firstname: firstNameController.text,
                                            lastname: lastNameController.text,
                                            Bio: bioController.text);
                                      },
                                      fillbackground: true,
                                      backgroundcoloor: ColorManager.primary,
                                      width: double.infinity),
                                  SizedBox(
                                    height: AppSize.s4.h,
                                  ),
                                  if (state
                                      is SocialAppUploadProfileImageLoadingState)
                                    LinearProgressIndicator(
                                      color: ColorManager.primary,
                                    ),
                                ],
                              ),
                            ),
                          SizedBox(
                            width: AppSize.s4.w,
                          ),
                          if (cubit.coverImage != null)
                            Expanded(
                              child: Column(
                                children: [
                                  defaultbutton(
                                      text: "Upload Cover",
                                      onpress: () {
                                        cubit.uploadCoverImage(
                                            firstname: firstNameController.text,
                                            lastname: lastNameController.text,
                                            Bio: bioController.text);
                                      },
                                      width: double.infinity),
                                  SizedBox(
                                    height: AppSize.s4.h,
                                  ),
                                  if (state
                                      is SocialAppUploadCoverImageLoadingState)
                                    LinearProgressIndicator(
                                      color: ColorManager.primary,
                                    ),
                                ],
                              ),
                            ),
                        ],
                      ),
                    ),
                  SizedBox(
                    height: AppSize.s20.h,
                  ),
                  defaultTextForm(
                    label: "Name",
                    controller: firstNameController,
                    type: TextInputType.name,
                    prefixIcon: Icons.person,
                    validator: (value) {
                      if (value!.isEmpty) {
                        "name must not be empty";
                      }
                      return;
                    },
                  ),
                  SizedBox(
                    height: AppSize.s12,
                  ),
                  defaultTextForm(
                    label: "LastName",
                    controller: lastNameController,
                    type: TextInputType.name,
                    prefixIcon: Icons.person_outline,
                    validator: (value) {
                      if (value!.isEmpty) {
                        "name must not be empty";
                      }
                      return;
                    },
                  ),
                  SizedBox(
                    height: AppSize.s12,
                  ),
                  defaultTextForm(
                    label: "Bio",
                    controller: bioController,
                    type: TextInputType.name,
                    prefixIcon: Icons.info_outline,
                    validator: (value) {
                      if (value!.isEmpty) {
                        "name must not be empty";
                      }
                      return;
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
      listener: (context, state) {},
    );
  }
}
