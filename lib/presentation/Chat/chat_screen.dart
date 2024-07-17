import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/Shared/resources/color_manager.dart';
import 'package:social_app/layout/cubit/socialapp_cubit.dart';
import 'package:social_app/layout/cubit/socialapp_states.dart';
import 'package:social_app/models/social_user_model/social_user_model.dart';
import 'package:social_app/presentation/Chat/chat_detail_screen.dart';

import '../../Shared/resources/values_manager.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SocialAppCubit cubit = SocialAppCubit.get(context);
    return BlocConsumer<SocialAppCubit, SocialAppStates>(
      builder: (context, state) {
        return ConditionalBuilder(
            condition: cubit.users.length > 0,
            builder: (context) {
              return ListView.separated(
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) =>
                      buildChatItem(context, cubit.users[index]),
                  separatorBuilder: (context, index) => Divider(),
                  itemCount: cubit.users.length);
            },
            fallback: (context) => Center(
                  child: CircularProgressIndicator(
                    color: ColorManager.primary,
                  ),
                ));
      },
      listener: (context, state) {},
    );
  }
}

Widget buildChatItem(BuildContext context, SocialUserModel model) => InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatDetailsScreen(model: model),
          ),
        );
      },
      child: Padding(
        padding: EdgeInsets.all(AppPadding.p20.w),
        child: Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage("${model.image}"),
              radius: AppSize.s25,
            ),
            SizedBox(
              width: AppSize.s10.w,
            ),
            Text(
              "${model.firstname} ${model.lastname}",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
