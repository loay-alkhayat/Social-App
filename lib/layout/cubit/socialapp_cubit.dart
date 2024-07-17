import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/Shared/constatnce/string.dart';
import 'package:social_app/Shared/network/local/cache_helper.dart';
import 'package:social_app/layout/cubit/socialapp_states.dart';
import 'package:social_app/models/message_model/message_model.dart';
import 'package:social_app/models/post_model/post_model.dart';
import 'package:social_app/models/social_user_model/social_user_model.dart';

import '../../presentation/Chat/chat_screen.dart';
import '../../presentation/Create_Post/create_post.dart';
import '../../presentation/Feed/feed_screen.dart';
import '../../presentation/Setting/setting_screen.dart';
import '../../presentation/Users/users_screen.dart';

class SocialAppCubit extends Cubit<SocialAppStates> {
  SocialAppCubit() : super(SocialAppInitialState());

  static SocialAppCubit get(context) => BlocProvider.of(context);
  SocialUserModel? userModel;
  bool userData = false;
  void getUserData() {
    userData = false;
    emit(SocialAppGetUserDataLoadingState());
    FirebaseFirestore.instance
        .collection("users")
        .doc(StringConstance.uID)
        .get()
        .then((value) {
      userModel = SocialUserModel.fromJson(value.data()!);

      userData = true;
      emit(SocialAppGetUserDataSucsessState());
    }).catchError((error) {
      print(StringConstance.uID);
      userData = false;
      print(error);
      emit(SocialAppGetUserDataErrorState(error.toString()));
    });
  }

  int currentIndex = 0;
  List<Widget> Screens = [
    FeedScreen(),
    ChatScreen(),
    AddPostScreen(),
    UsersScreen(),
    SettingScreen(),
  ];
  List<String> Name = ["Home", "Chat", "Create Post", "Users", "Setting"];

  changeBottomNav(int index) {
    if (index == 4) {
      if (userData == false) {
        getUserData();
      }
      emit(SocialAppChangeBottomNavState());
    }
    if (index == 1) getUsers();

    if (index == 2) {
      emit(SocialAppAddPostState());
    } else {
      currentIndex = index;
      emit(SocialAppChangeBottomNavState());
    }
  }

  bool light = true;

  changeTheme({BuildContext? context, bool? sha}) {
    if (sha != null)
      light = sha;
    else
      light = !light;
    CacheHelper.saveData(key: "theme", value: light).then((value) {
      emit(SocialAppChangeThemeState());
    });
  }

  File? profileImage;
  var imagePicker = ImagePicker();

  Future<void> getProfileImage() async {
    final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      emit(SocialAppProfileImagePickerSucsessState());
    } else {
      print("No Image Selected");
      emit(SocialAppProfileImagePickerErrorState());
    }
  }

  File? coverImage;

  Future<void> getCoverImage() async {
    final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      coverImage = File(pickedFile.path);
      emit(SocialAppCoverImagePickerSucsessState());
    } else {
      print("No Image Selected");
      emit(SocialAppCoverImagePickerErrorState());
    }
  }

  String profileImageUrl = '';
  uploadProfileImage(
      {required String firstname,
      required String lastname,
      required String Bio}) {
    emit(SocialAppUploadProfileImageLoadingState());
    FirebaseStorage.instance
        .ref()
        .child("users/${Uri.file(profileImage!.path).pathSegments.last}")
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        updateUser(
            firstname: firstname, lastname: lastname, Bio: Bio, image: value);
      }).catchError((error) {
        emit(SocialAppUploadProfileImageErrorState());
      });
    }).catchError((error) {
      emit(SocialAppUploadProfileImageErrorState());
    });
  }

  String coverImageUrl = '';
  uploadCoverImage(
      {required String firstname,
      required String lastname,
      required String Bio}) {
    emit(SocialAppUploadCoverImageLoadingState());

    FirebaseStorage.instance
        .ref()
        .child("users/${Uri.file(coverImage!.path).pathSegments.last}")
        .putFile(coverImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        updateUser(
            firstname: firstname, lastname: lastname, Bio: Bio, cover: value);
      }).catchError((error) {
        emit(SocialAppUploadCoverImageErrorState());
      });
    }).catchError((error) {
      emit(SocialAppUploadCoverImageErrorState());
    });
  }

  void updateUser(
      {required String firstname,
      required String lastname,
      required String Bio,
      String? cover,
      String? image}) {
    SocialUserModel model = SocialUserModel(
      firstname: firstname,
      lastname: lastname,
      email: userModel!.email,
      uId: userModel!.uId,
      bio: Bio,
      cover: cover ?? userModel!.cover,
      image: image ?? userModel!.image,
    );
    FirebaseFirestore.instance
        .collection("users")
        .doc(StringConstance.uID)
        .update(model.ToMap())
        .then((value) {
      getUserData();
    }).catchError((error) {});
  }

  void createPost({
    required String text,
    String? postImage,
    required String dateTime,
  }) {
    emit(SocialAppCreatePostLoadingState());
    PostModel model = PostModel(
      firstname: userModel!.firstname,
      lastname: userModel!.lastname,
      uId: userModel!.uId,
      image: userModel!.image,
      text: text,
      dateTime: dateTime,
      postImage: postImage ?? "",
    );
    FirebaseFirestore.instance
        .collection("posts")
        .add(model.ToMap())
        .then((value) {
      emit(SocialAppCreatePostSucsessState());
    }).catchError((error) {
      emit(SocialAppCreatePostErrorState());
    });
  }

  File? postImage;

  Future<void> getPostImage() async {
    final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      postImage = File(pickedFile.path);
      emit(SocialAppCoverImagePickerSucsessState());
    } else {
      print("No Image Selected");
      emit(SocialAppCoverImagePickerErrorState());
    }
  }

  void upoladPostImage({
    String? text,
    String? dateTime,
  }) {
    FirebaseStorage.instance
        .ref()
        .child("posts/${Uri.file(postImage!.path).pathSegments.last}")
        .putFile(postImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        createPost(postImage: value, text: text!, dateTime: dateTime!);
      }).catchError((error) {
        emit(SocialAppCreatePostErrorState());
      });
    }).catchError((error) {
      print(error);
      emit(SocialAppCreatePostErrorState());
    });
  }

  void clearPostImage() {
    postImage = null;
    emit(SocialAppRemovePostImageSucsessState());
  }

  List<String> postsId = [];
  List<PostModel> posts = [];
  List<int> likes = [];
  Future<void> getPosts() async {
    emit(SocialAppGetPostLoadingState());
    await FirebaseFirestore.instance.collection("posts").get().then((value) {
      value.docs.forEach((element) {
        element.reference.collection('likes').get().then((value) {
          likes.add(value.docs.length);
          postsId.add(element.id);
          posts.add(
            PostModel.fromJson(
              element.data(),
            ),
          );
          emit(SocialAppGetPostSucsessState());
        }).catchError((onError) {
          emit(SocialAppGetPostErrorState());
        });
      });
    }).catchError((error) {
      emit(SocialAppGetPostErrorState());
    });
  }

  void likePost({required String postId}) {
    emit(SocialAppLikePostLoadingState());

    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(userModel!.uId)
        .set({"like": true}).then((value) {
      emit(SocialAppLikePostSucsessState());
    }).catchError((error) {
      emit(SocialAppLikePostErrorState());
    });
  }

  // void unLikePost({required String postId}) {
  //   FirebaseFirestore.instance
  //       .collection('posts')
  //       .doc(postId)
  //       .collection('likes')
  //       .doc(userModel!.uId)
  //       .set({"like": false}).then((value) {
  //     emit(SocialAppUnLikePostSucsessState());
  //   }).catchError((error) {
  //     emit(SocialAppLikePostErrorState());
  //   });
  // }

  List<SocialUserModel> users = [];
  void getUsers() {
    emit(SocialAppGetAllUsersLoadingState());
    if (users.length == 0)
      FirebaseFirestore.instance.collection("users").get().then((value) {
        value.docs.forEach((element) {
          if (element.data()['uId'] != userModel!.uId)
            users.add(
              SocialUserModel.fromJson(
                element.data(),
              ),
            );
        });
        emit(SocialAppGetAllUsersSucsessState());
      }).catchError((error) {
        emit(SocialAppGetAllUsersErrorState());
      });
  }

  void sendMessage({required String reciverId, required String text}) {
    emit(SocialAppSendMessageLoadingState());
    MessageModel model = MessageModel(
        DateTime.now().toString(), reciverId, userModel!.uId, text);
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .collection('chat')
        .doc(reciverId)
        .collection('messages')
        .add(model.ToMap());
    FirebaseFirestore.instance
        .collection('users')
        .doc(reciverId)
        .collection('chat')
        .doc(userModel!.uId)
        .collection('messages')
        .add(model.ToMap())
        .then((value) {
      emit(
        SocialAppSendMessageSucsessState(),
      );
    }).catchError((Error) {
      emit(
        SocialAppSendMessageErrorState(),
      );
    });
  }

  List<MessageModel> messages = [];
  void getMessages({required String reciverId}) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .collection('chat')
        .doc(reciverId)
        .collection('messages')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
      messages = [];
      event.docs.forEach((element) {
        messages.add(
          MessageModel.fromJson(element.data()),
        );
      });
    });
  }
}
