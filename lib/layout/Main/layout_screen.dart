import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/Shared/network/local/cache_helper.dart';

import '../../../Shared/resources/routes_manager.dart';
import '../cubit/socialapp_cubit.dart';
import '../cubit/socialapp_states.dart';

class MainLayoutScreen extends StatelessWidget {
  const MainLayoutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialAppCubit, SocialAppStates>(
      builder: (context, state) {
        SocialAppCubit cubit = SocialAppCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
                onPressed: () {
                  cubit.changeTheme(context: context);
                },
                icon: Icon(cubit.light == true
                    ? Icons.dark_mode_outlined
                    : Icons.light_mode_outlined)),
            centerTitle: true,
            actions: [
              IconButton(
                  onPressed: () async {},
                  icon: Icon(
                    Icons.search,
                  )),
              IconButton(
                  onPressed: () async {
                    await CacheHelper.removeData(key: "uID");
                     cubit.messages.clear() ;
                     cubit.users.clear();
                     cubit.postsId.clear() ;
                     cubit.posts.clear();
                     cubit.likes.clear() ;
                    cubit.currentIndex = 0;
                    FirebaseAuth.instance.signOut();
                    Navigator.pushNamedAndRemoveUntil(
                        context, Routes.loginRoute, (route) => false);
                  },
                  icon: Icon(
                    Icons.notifications_sharp,
                  )),
            ],
            automaticallyImplyLeading: false,
            title: Text(cubit.Name[cubit.currentIndex]),
          ),
          body: cubit.Screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            onTap: (index) => cubit.changeBottomNav(index),
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: cubit.Name[0],
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.chat),
                label: cubit.Name[1],
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.upload_file),
                label: cubit.Name[2],
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: cubit.Name[3],
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: cubit.Name[4],
              ),
            ],
          ),
        );
      },
      listener: (context, state) {
        if (state is SocialAppAddPostState) {
          Navigator.pushNamed(context, Routes.addPostRoute);
        }
      },
    );
  }
}
