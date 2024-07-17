import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/Shared/resources/routes_manager.dart';
import 'package:social_app/Shared/resources/values_manager.dart';
import 'package:social_app/layout/cubit/socialapp_cubit.dart';
import 'package:social_app/layout/cubit/socialapp_states.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialAppCubit, SocialAppStates>(
      builder: (context, state) {
        SocialAppCubit cubit = SocialAppCubit.get(context);
        return ConditionalBuilder(
          condition:
              cubit.userData || state is! SocialAppGetUserDataLoadingState,
          builder: (context) => SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(AppPadding.p8),
              child: Column(
                children: [
                  Container(
                    height: AppSize.s210.h,
                    child: Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        Align(
                          alignment: AlignmentDirectional.topCenter,
                          child: Container(
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
                              image: DecorationImage(
                                  image: NetworkImage(
                                    "${cubit.userModel!.cover}",
                                  ),
                                  fit: BoxFit.cover),
                            ),
                          ),
                        ),
                        CircleAvatar(
                          backgroundColor:
                              Theme.of(context).scaffoldBackgroundColor,
                          radius: AppSize.s65,
                          child: CircleAvatar(
                            radius: AppSize.s60,
                            backgroundImage:
                                NetworkImage("${cubit.userModel!.image}"),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: AppSize.s4,
                  ),
                  Text(
                    "${cubit.userModel!.firstname} ${cubit.userModel!.lastname}",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  SizedBox(
                    height: AppSize.s4.h,
                  ),
                  Text(
                    "${cubit.userModel!.bio}",
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: AppPadding.p16),
                    child: Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () {},
                            child: Column(
                              children: [
                                Text(
                                  "100",
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                                Text(
                                  "Post",
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () {},
                            child: Column(
                              children: [
                                Text(
                                  "265",
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                                Text(
                                  "Photos",
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () {},
                            child: Column(
                              children: [
                                Text(
                                  "10k",
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                                Text(
                                  "Followers",
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () {},
                            child: Column(
                              children: [
                                Text(
                                  "54",
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                                Text(
                                  "Following",
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {},
                          child: Text(
                            "Add Photo",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                    color: Theme.of(context).primaryColor),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: AppSize.s4.w,
                      ),
                      OutlinedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, Routes.editProfile);
                        },
                        child: Icon(
                          Icons.edit,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          fallback: (context) {
            return Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).primaryColor,
              ),
            );
          },
        );
      },
      listener: (context, state) {},
    );
  }
}
