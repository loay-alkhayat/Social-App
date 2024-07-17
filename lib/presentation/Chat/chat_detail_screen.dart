import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/Shared/resources/color_manager.dart';
import 'package:social_app/layout/cubit/socialapp_cubit.dart';
import 'package:social_app/layout/cubit/socialapp_states.dart';
import 'package:social_app/models/message_model/message_model.dart';
import 'package:social_app/models/social_user_model/social_user_model.dart';

import '../../Shared/resources/values_manager.dart';

class ChatDetailsScreen extends StatelessWidget {
  ChatDetailsScreen({required this.model});
  SocialUserModel model;
  TextEditingController messageController = TextEditingController();
  ScrollController controllerScroll = ScrollController();
  @override
  Widget build(BuildContext context) {
    SocialAppCubit cubit = SocialAppCubit.get(context);
    return Builder(
      builder: (context) {
        cubit.getMessages(reciverId: model.uId!);
        return BlocConsumer<SocialAppCubit, SocialAppStates>(
          builder: (context, state) {
            return Scaffold(
                appBar: AppBar(
                  title: Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage("${model.image}"),
                        radius: AppSize.s20,
                      ),
                      SizedBox(
                        width: AppSize.s10.w,
                      ),
                      Text(
                        "${model.firstname} ${model.lastname}",
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(color: ColorManager.white),
                      ),
                    ],
                  ),
                ),
                body: Padding(
                  padding: EdgeInsets.all(AppPadding.p8.w),
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.separated(
                            physics: BouncingScrollPhysics(),
                            controller: controllerScroll,
                            itemBuilder: (context, index) {
                              if (cubit.userModel!.uId ==
                                  cubit.messages[index].senderId)
                                return myMessageBuild(
                                    context, cubit.messages[index]);
                              return reciverMessageBuild(
                                  context, cubit.messages[index]);
                            },
                            separatorBuilder: (context, index) => SizedBox(
                                  height: AppSize.s4.h,
                                ),
                            itemCount: cubit.messages.length),
                      ),
                      SizedBox(
                        height: AppSize.s4.h,
                      ),
                      Container(
                        padding: EdgeInsets.only(left: AppPadding.p4),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        decoration: BoxDecoration(
                          border: Border.all(
                              width: AppSize.s0_5,
                              color: Theme.of(context)
                                  .primaryColorDark
                                  .withAlpha(40)),
                          borderRadius: BorderRadius.all(
                            Radius.circular(AppSize.s12),
                          ),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: AppPadding.p4),
                                child: TextField(
                                  textInputAction: TextInputAction.send,
                                  autofocus: true,
                                  canRequestFocus: true,
                                  autocorrect: false,
                                  onSubmitted: (value) {
                                    controllerScroll.animateTo(
                                        duration: Duration(seconds: 1),
                                        curve: Curves.ease,
                                        controllerScroll
                                            .position.maxScrollExtent);
                                    if (messageController.text.isNotEmpty) {
                                      cubit.sendMessage(
                                          reciverId: model.uId!,
                                          text: messageController.text);
                                    }
                                  },
                                  controller: messageController,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Write Your Message...",
                                      hintStyle: TextStyle(
                                        color:
                                            Theme.of(context).primaryColorDark,
                                      )),
                                ),
                              ),
                            ),
                            Container(
                              color: Theme.of(context).primaryColor,
                              height: AppSize.s50,
                              child: MaterialButton(
                                minWidth: AppSize.s1,
                                onPressed: () {
                                  controllerScroll.animateTo(
                                      duration: Duration(seconds: 1),
                                      curve: Curves.ease,
                                      controllerScroll
                                          .position.maxScrollExtent);
                                  if (messageController.text.isNotEmpty) {
                                    cubit.sendMessage(
                                        reciverId: model.uId!,
                                        text: messageController.text);
                                  }
                                },
                                child: Icon(
                                  Icons.send,
                                  color: ColorManager.white,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ));
          },
          listener: (context, state) {},
        );
      },
    );
  }
}

Widget myMessageBuild(BuildContext context, MessageModel model) => Align(
      alignment: AlignmentDirectional.centerStart,
      child: Container(
          padding: EdgeInsets.all(AppPadding.p8.w),
          decoration: BoxDecoration(
            color: Colors.grey[400],
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(AppPadding.p8),
              topRight: Radius.circular(AppPadding.p8),
              bottomRight: Radius.circular(AppPadding.p8),
            ),
          ),
          child: Text(model.text!,
              style: TextStyle(
                  color: Theme.of(context).primaryColorDark,
                  fontWeight: FontWeight.w300))),
    );
Widget reciverMessageBuild(BuildContext context, MessageModel model) => Align(
      alignment: AlignmentDirectional.centerEnd,
      child: Container(
          padding: EdgeInsets.all(AppPadding.p8.w),
          decoration: BoxDecoration(
            color: Colors.blue[200],
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(AppPadding.p8),
              topRight: Radius.circular(AppPadding.p8),
              bottomLeft: Radius.circular(AppPadding.p8),
            ),
          ),
          child: Text(
            model.text!,
            style: Theme.of(context).textTheme.titleMedium,
          )),
    );
