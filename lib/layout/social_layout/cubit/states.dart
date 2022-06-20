abstract class SocialStates {}

class SocialInitialState extends SocialStates {}

class SocialGetUserLoadingState extends SocialStates {}

class SocialGetUserSuccessState extends SocialStates {}

class SocialGetUserErrorState extends SocialStates {
  final String error;

  SocialGetUserErrorState(this.error);
}

class SocialGetAllUsersLoadingState extends SocialStates {}

class SocialGetAllUsersSuccessState extends SocialStates {}

class SocialGetAllUsersErrorState extends SocialStates {
  final String error;

  SocialGetAllUsersErrorState(this.error);
}

class SocialGetPostsLoadingState extends SocialStates {}

class SocialGetPostsSuccessState extends SocialStates {}

class SocialGetPostsErrorState extends SocialStates {
  final String error;

  SocialGetPostsErrorState(this.error);
}



class SocialLikePostSuccessState extends SocialStates {}

class SocialLikePostErrorState extends SocialStates {
  final String error;

  SocialLikePostErrorState(this.error);
}

class SocialCommentPostLoadingState extends SocialStates {}

class SocialCommentPostSuccessState extends SocialStates {}

class SocialCommentPostErrorState extends SocialStates {
  final String error;

  SocialCommentPostErrorState(this.error);
}



class SocialChangeBottomNavState extends SocialStates {}

class SocialNewPostState extends SocialStates {}

class SocialProfileImagePeckedSuccessState extends SocialStates {}

class SocialProfileImagePeckedErrorState extends SocialStates {}

class SocialCoverImagePeckedSuccessState extends SocialStates {}

class SocialCoverImagePeckedErrorState extends SocialStates {}

class SocialUploadProfileImagePeckedSuccessState extends SocialStates {}

class SocialUploadProfileImagePeckedErrorState extends SocialStates {}

class SocialUploadCoverImagePeckedSuccessState extends SocialStates {}

class SocialUploadCoverImagePeckedErrorState extends SocialStates {}

class SocialUpdateUserErrorState extends SocialStates {}

class SocialUpdateUserLoadingState extends SocialStates {}

//post states
class SocialCreatePostErrorState extends SocialStates {}

class SocialCreatePostLoadingState extends SocialStates {}

class SocialCreatePostSuccessState extends SocialStates {}

class SocialPostImagePeckedSuccessState extends SocialStates {}

class SocialPostImagePeckedErrorState extends SocialStates {}

class SocialRemovePostImageState extends SocialStates {}

//message states
class SocialSendMessagesSuccessState extends SocialStates {}

class SocialSendMessagesErrorState extends SocialStates {}

class SocialGetMessagesSuccessState extends SocialStates {}



