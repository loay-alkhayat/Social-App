abstract class SocialAppStates {}

class SocialAppInitialState extends SocialAppStates {}

class SocialAppLoadingState extends SocialAppStates {}

class SocialAppSucsessState extends SocialAppStates {}

class SocialAppErrorState extends SocialAppStates {}

class SocialAppChangeThemeState extends SocialAppStates {}

class SocialAppChangeBottomNavState extends SocialAppStates {}

class SocialAppAddPostState extends SocialAppStates {}

class SocialAppGetUserDataLoadingState extends SocialAppStates {}

class SocialAppGetUserDataSucsessState extends SocialAppStates {}

class SocialAppGetUserDataErrorState extends SocialAppStates {
  final String Error;
  SocialAppGetUserDataErrorState(this.Error);
}

class SocialAppProfileImagePickerSucsessState extends SocialAppStates {}

class SocialAppProfileImagePickerErrorState extends SocialAppStates {}

class SocialAppCoverImagePickerSucsessState extends SocialAppStates {}

class SocialAppCoverImagePickerErrorState extends SocialAppStates {}

class SocialAppUploadCoverImageLoadingState extends SocialAppStates {}

class SocialAppUploadCoverImageSucsessState extends SocialAppStates {}

class SocialAppUploadCoverImageErrorState extends SocialAppStates {}

class SocialAppUploadProfileImageLoadingState extends SocialAppStates {}

class SocialAppUploadProfileImageSucsessState extends SocialAppStates {}

class SocialAppUploadProfileImageErrorState extends SocialAppStates {}

class SocialAppCreatePostLoadingState extends SocialAppStates {}

class SocialAppCreatePostSucsessState extends SocialAppStates {}

class SocialAppCreatePostErrorState extends SocialAppStates {}

class SocialAppRemovePostImageSucsessState extends SocialAppStates {}

class SocialAppLikePostSucsessState extends SocialAppStates {}

class SocialAppLikePostErrorState extends SocialAppStates {}

class SocialAppLikePostLoadingState extends SocialAppStates {}

class SocialAppGetPostSucsessState extends SocialAppStates {}

class SocialAppGetPostErrorState extends SocialAppStates {}

class SocialAppGetPostLoadingState extends SocialAppStates {}

class SocialAppUnLikePostSucsessState extends SocialAppStates {}

class SocialAppUnLikePostErrorState extends SocialAppStates {}

class SocialAppUnLikePostLoadingState extends SocialAppStates {}

class SocialAppGetAllUsersSucsessState extends SocialAppStates {}

class SocialAppGetAllUsersErrorState extends SocialAppStates {}

class SocialAppGetAllUsersLoadingState extends SocialAppStates {}

class SocialAppSendMessageLoadingState extends SocialAppStates {}

class SocialAppSendMessageSucsessState extends SocialAppStates {}

class SocialAppSendMessageErrorState extends SocialAppStates {}

class SocialAppChatDetielsScreenState extends SocialAppStates {}
