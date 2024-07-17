import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/Shared/components/textbutton_widget.dart';
import 'package:social_app/Shared/resources/color_manager.dart';
import 'package:social_app/layout/cubit/socialapp_cubit.dart';
import 'package:social_app/layout/cubit/socialapp_states.dart';

import '../../Shared/resources/values_manager.dart';

class AddPostScreen extends StatelessWidget {
  const AddPostScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController textController = TextEditingController();
    SocialAppCubit cubit = SocialAppCubit.get(context);
    return BlocConsumer<SocialAppCubit, SocialAppStates>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Create Post"),
            actions: [
              defaultbutton(
                text: "POST",
                onpress: () {
                  if (cubit.postImage == null) {
                    cubit.createPost(
                        text: textController.text,
                        dateTime: DateTime.now().toString());
                  } else {
                    cubit.upoladPostImage(
                        dateTime: DateTime.now().toString(),
                        text: textController.text);
                  }
                },
              ),
            ],
          ),
          body: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(AppPadding.p8.w),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundImage:
                          NetworkImage("${cubit.userModel!.image}"),
                      radius: AppSize.s20,
                    ),
                    SizedBox(
                      width: AppSize.s8.w,
                    ),
                    Expanded(
                      child: Text(
                        "${cubit.userModel!.firstname} ${cubit.userModel!.lastname}",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: AppSize.s8.h,
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(AppPadding.p8.w),
                  child: TextField(
                    controller: textController,
                    autofocus: false,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "W"
                            "hats On Your Mind...",
                        hintStyle: Theme.of(context).textTheme.titleMedium),
                  ),
                ),
              ),
              if (cubit.postImage != null)
                Expanded(
                  child: Stack(
                    alignment: AlignmentDirectional.topEnd,
                    children: [
                      Align(
                        alignment: AlignmentDirectional.topCenter,
                        child: Container(
                          width: double.infinity,
                          height: AppSize.s220.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(AppSize.s4),
                            image: DecorationImage(
                                image: FileImage(cubit.postImage!),
                                fit: BoxFit.cover),
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          cubit.clearPostImage();
                        },
                        icon: Icon(
                          Icons.clear,
                          color: Theme.of(context).primaryColor,
                        ),
                      )
                    ],
                  ),
                ),
              Container(
                color: Theme.of(context).primaryColor,
                child: Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          cubit.getPostImage();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.photo_camera_back_outlined,
                                color: ColorManager.white),
                            SizedBox(
                              width: AppSize.s4.w,
                            ),
                            Text(
                              "Add Photo",
                              style: TextStyle(
                                  color: ColorManager.white,
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      color: ColorManager.white,
                      height: AppSize.s16,
                      width: AppSize.s1,
                    ),
                    Expanded(
                      child: TextButton(
                        onPressed: () {},
                        child: Text(
                          "#Tags",
                          style: TextStyle(
                              color: ColorManager.white,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
      listener: (context, state) {},
    );
  }
}
