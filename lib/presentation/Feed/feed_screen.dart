import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/Shared/resources/color_manager.dart';
import 'package:social_app/Shared/resources/values_manager.dart';
import 'package:social_app/layout/cubit/socialapp_cubit.dart';
import 'package:social_app/layout/cubit/socialapp_states.dart';
import 'package:social_app/models/post_model/post_model.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SocialAppCubit cubit = SocialAppCubit.get(context);
    return BlocConsumer<SocialAppCubit, SocialAppStates>(
      builder: (context, state) {
        return RefreshIndicator(
          child: ConditionalBuilder(
            condition: cubit.posts.length > 0,
            builder: (context) {
              return SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: AppPadding.p2.w),
                  child: Column(
                    children: [
                      ListView.separated(
                        separatorBuilder: (context, index) => SizedBox(
                          height: AppSize.s4,
                        ),
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return buildPostItem(
                              cubit.posts[index], context, index);
                        },
                        itemCount: cubit.posts.length,
                      ),
                    ],
                  ),
                ),
              );
            },
            fallback: (context) => Center(
              child: CircularProgressIndicator(
                color: ColorManager.primary,
              ),
            ),
          ),
          onRefresh: () async {
            await cubit.getPosts();
          },
        );
      },
      listener: (context, state) {

      },
    );
  }

  Widget? buildPostItem(PostModel model, context, int index) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(AppPadding.p8.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage("${model.image}"),
                  radius: AppSize.s20,
                ),
                SizedBox(
                  width: AppSize.s10.w,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "${model.firstname} ${model.lastname} ",
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          SizedBox(
                            width: AppSize.s4.w,
                          ),
                          Icon(
                            Icons.check_circle,
                            color: Colors.blue,
                            size: AppSize.s16,
                          )
                        ],
                      ),
                      SizedBox(
                        height: AppSize.s4.h,
                      ),
                      Text(
                        "${model.dateTime}",
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.more_horiz,
                    size: AppSize.s18,
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: AppPadding.p4),
              child: Container(
                width: double.infinity,
                color: ColorManager.lightGrey,
                height: AppSize.s1_5,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: AppPadding.p8),
              child: Text(
                "${model.text}",
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            // Padding(
            //   padding: EdgeInsets.only(top: AppSize.s10, bottom: AppSize.s4),
            //   child: Container(
            //     width: double.infinity,
            //     child: Wrap(
            //       children: [
            //         Container(
            //           height: AppSize.s18,
            //           child: MaterialButton(
            //             onPressed: () {},
            //             child: Text(
            //               "#SoftWare",
            //               style: TextStyle(color: ColorManager.blue),
            //             ),
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            if (model.postImage != "")
              Card(
                elevation: 0,
                child: Image(image: NetworkImage("${model.postImage}")),
              ),
            Padding(
              padding: EdgeInsets.only(top: AppPadding.p8.h),
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {},
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: AppSize.s4.h, horizontal: AppSize.s4.w),
                        child: Row(
                          children: [
                            Icon(
                              Icons.heart_broken_outlined,
                              size: AppSize.s16,
                              color: ColorManager.red,
                            ),
                            SizedBox(
                              width: AppSize.s4.w,
                            ),
                            StreamBuilder(
                              stream: Stream.value(
                                  SocialAppCubit.get(context).likes[index]),
                              builder: (context, snapshot) {
                                return Text(
                                  "${SocialAppCubit.get(context).likes[index]}",
                                  style: Theme.of(context).textTheme.bodySmall,
                                );
                              },
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {},
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: AppSize.s4.h, horizontal: AppSize.s4.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Icon(
                              Icons.comment_outlined,
                              size: AppSize.s16,
                              color: ColorManager.amber,
                            ),
                            SizedBox(
                              width: AppSize.s4.w,
                            ),
                            Text(
                              "0 Comments",
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: AppPadding.p8.h),
              child: Container(
                width: double.infinity,
                color: ColorManager.lightGrey,
                height: AppSize.s1_5,
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {},
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(
                              "${SocialAppCubit.get(context).userModel!.image}"),
                          radius: AppSize.s16,
                        ),
                        SizedBox(
                          width: AppSize.s14.w,
                        ),
                        Text(
                          "Write Comment...",
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    SocialAppCubit.get(context).likePost(
                        postId: SocialAppCubit.get(context).postsId[index]);
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: AppSize.s4.h, horizontal: AppSize.s4.w),
                    child: Row(
                      children: [
                        Icon(
                          Icons.heart_broken_outlined,
                          size: AppSize.s16,
                          color: ColorManager.red,
                        ),
                        SizedBox(
                          width: AppSize.s4.w,
                        ),
                        Text(
                          "Like",
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
