import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first/layout/social_layout/cubit/states.dart';
import 'package:first/models/social_models/message_model.dart';
import 'package:first/models/social_models/social_user_model.dart';
import 'package:first/moduls/social_moduls/chats/chats_screen.dart';
import 'package:first/moduls/social_moduls/feeds/feeds_screen.dart';
import 'package:first/moduls/social_moduls/new_post_screen/new_post_screen.dart';
import 'package:first/moduls/social_moduls/settings/settings_screen.dart';
import 'package:first/moduls/social_moduls/users/users_screen.dart';
import 'package:floor/floor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../models/social_models/post_model.dart';
import '../../../shared/components/constants.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class SocialCubit extends Cubit<SocialStates> {
  SocialCubit() : super(SocialInitialState());

  static SocialCubit get(context) => BlocProvider.of(context);

  SocialUserModel? userModel;

  void getUserData() {
    emit(SocialGetUserLoadingState());

    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      print(value.data());
      userModel = SocialUserModel.fromjson(value.data()!);
      uId = userModel!.uId!;
      emit(SocialGetUserSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SocialGetUserErrorState(error.toString()));
    });
  }

  int currentIndex = 0;
  List<Widget> screens = [
    FeedsScreen(),
    ChatsScreen(),
    NewPostScreen(),
    UsersScreen(),
    SocialSettingsScreen()
  ];

  List<String> titles = [
    'Home',
    'Chats',
    'Post',
    'Users',
    'Settings',
  ];

  void changeBottomNav(int index) {
    if (index == 1) getUsers();
    if (index == 2)
      emit(SocialNewPostState());
    else {
      emit(SocialChangeBottomNavState());
      currentIndex = index;
    }
  }

  File? profileImage;
  final picker = ImagePicker();

  Future<void> getProfileImage() async {
    // ignore: deprecated_member_use
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      emit(SocialProfileImagePeckedSuccessState());
    } else {
      print('No image selected.');
      emit(SocialProfileImagePeckedErrorState());
    }
  }

  File? coverImage;

  Future<void> getCoverImage() async {
    // ignore: deprecated_member_use
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      coverImage = File(pickedFile.path);
      emit(SocialProfileImagePeckedSuccessState());
    } else {
      print('No image selected.');
      emit(SocialProfileImagePeckedErrorState());
    }
  }

  void uploadProfileImage({
    required String name,
    required String phone,
    required String bio,
  }) {
    emit(SocialUpdateUserLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        // emit(SocialUploadProfileImagePeckedSuccessState());
        print(value);
        updateUser(name: name, phone: phone, bio: bio, image: value);
      }).catchError((error) {
        emit(SocialUploadCoverImagePeckedErrorState());
      });
    }).catchError((error) {
      emit(SocialUploadCoverImagePeckedErrorState());
    });
  }

  void uploadCoverImage({
    required String name,
    required String phone,
    required String bio,
  }) {
    emit(SocialUpdateUserLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(coverImage!.path).pathSegments.last}')
        .putFile(coverImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        //emit(SocialUploadCoverImagePeckedSuccessState());
        print(value);
        updateUser(name: name, phone: phone, bio: bio, cover: value);
      }).catchError((error) {
        emit(SocialUploadCoverImagePeckedErrorState());
      });
    }).catchError((error) {
      emit(SocialUploadCoverImagePeckedErrorState());
    });
  }

  // void updateUserImages({
  //   required String name,
  //   required String phone,
  //   required String bio,
  // }) {
  //   if(coverImage != null)
  //   {
  //      uploadCoverImage();
  //   } else if(profileImage != null)
  //   {
  //    uploadProfileImage();
  //   }
  //    else if(coverImage != null && profileImage != null)
  //    {
  //      updateUser(bio: bio, name: name, phone: phone);
  //    }
  //   else{

  //   }

  // }
  void updateUser({
    required String name,
    required String phone,
    required String bio,
    String? image,
    String? cover,
  }) {
    SocialUserModel model = SocialUserModel(
      name: name,
      phone: phone,
      bio: bio,
      email: userModel!.email,
      cover: cover ?? userModel!.cover,
      image: image ?? userModel!.image,
      uId: userModel!.uId,
      isEmailVerified: false,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(model.uId)
        .update(model.toMap())
        .then((value) {
      //emit(SocialUpdateUserLoadingState());
      getUserData();
    }).catchError((error) {
      emit(SocialUpdateUserErrorState());
    });
  }

  File? postImage;

  Future<void> getPostImage() async {
    // ignore: deprecated_member_use
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    print('third Image');
    if (pickedFile != null) {
      postImage = File(pickedFile.path);
      print('first Image');
      emit(SocialPostImagePeckedSuccessState());
    } else {
      print('No image selected.');
      emit(SocialPostImagePeckedErrorState());
    }
  }

  void removePostImage() {
    postImage == null;
    emit(SocialRemovePostImageState());
  }

  void uploadPostImage({required String text, required String dateTime}) {
    emit(SocialCreatePostLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('posts/${Uri.file(postImage!.path).pathSegments.last}')
        .putFile(postImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print('second Image');
        createPost(text: text, dateTime: dateTime, postImage: value);
      }).catchError((error) {
        emit(SocialPostImagePeckedErrorState());
      });
    }).catchError((error) {
      emit(SocialPostImagePeckedErrorState());
    });
  }

  void createPost({
    required String text,
    required String dateTime,
    String? postImage,
  }) {
    emit(SocialCreatePostLoadingState());
    print('first');
    PostModel model = PostModel(
        name: userModel!.name,
        image: userModel!.image,
        uId: userModel!.uId,
        text: text,
        dateTime: dateTime,
        postImage: postImage ?? '');
    print('second');

    FirebaseFirestore.instance
        .collection('posts')
        .add(model.toMap())
        .then((value) {
      print('third');

      emit(SocialCreatePostSuccessState());
    }).catchError((error) {
      emit(SocialCreatePostErrorState());
    });
  }

  List<PostModel> posts = [];
  List<String> postsId = [];
  List<int> likes = [];
  List<int> comments = [];

  void getPosts() {
    FirebaseFirestore.instance.collection('posts').get().then((value) {
      value.docs.forEach((element) {
        element.reference.collection('comment').get().then((value) {
          comments.add(value.docs.length);
          element.reference.collection('likes').get().then((value) {
            likes.add(value.docs.length);
            postsId.add(element.id);
            posts.add(PostModel.fromjson(element.data()));
          }).catchError((error) {});
        }).catchError((error) {});
      });
      emit(SocialGetPostsSuccessState());
    }).catchError((error) {
      emit(SocialGetPostsErrorState(error.toString()));
    });
  }

  void likePost({required String postId}) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(userModel!.uId)
        .set({'like': true}).then((value) {
      emit(SocialLikePostSuccessState());
    }).catchError((error) {
      emit(SocialLikePostErrorState(error.toString()));
    });
  }

  void commentPost({required String postId, required String comment}) {
    emit(SocialCommentPostLoadingState());
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('comment')
        .doc(userModel!.uId)
        .set({'comment': comment}).then((value) {
      emit(SocialCommentPostSuccessState());
    }).catchError((error) {
      emit(SocialCommentPostErrorState(error.toString()));
    });
  }



  List<SocialUserModel> users = [];

  void getUsers() {
    if (users.length == 0)
      FirebaseFirestore.instance.collection('users').get().then((value) {
        value.docs.forEach((element) {
          if (element.data()['uId'] != userModel!.uId)
            users.add(SocialUserModel.fromjson(element.data()));
        });
        emit(SocialGetAllUsersSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(SocialGetAllUsersErrorState(error.toString()));
      });
  }

  void sendMessages({
    required receiverId,
    required dateTime,
    required text,
  }) {
    SocialMessageModel model = SocialMessageModel(
      reseiverId: receiverId,
      senderId: userModel!.uId,
      dateTime: dateTime,
      text: text,
    );
    //set my chats
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('message')
        .add(model.toMap())
        .then((value) {
      emit(SocialSendMessagesSuccessState());
    }).catchError((error) {
      emit(SocialSendMessagesErrorState());
    });

    //set reseiver chats
    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverId)
        .collection('chats')
        .doc(userModel!.uId)
        .collection('message')
        .add(model.toMap())
        .then((value) {
      emit(SocialSendMessagesSuccessState());
    }).catchError((error) {
      emit(SocialSendMessagesErrorState());
    });
  }

  List<SocialMessageModel>? messages =[];

  void getMessages({
    required receiverId,
  }) {
   FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('message')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
              messages = [];

      event.docs.forEach((element) {
        messages!.add(SocialMessageModel.fromjson(element.data()));
      });
    });
    emit(SocialGetMessagesSuccessState());
  }
}
