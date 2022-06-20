import 'package:firebase_auth/firebase_auth.dart';
import 'package:first/models/shop_models/shop_login_models.dart';
import 'package:first/moduls/shop_moduls/shop_login_screen/cubit/states.dart';
import 'package:first/moduls/social_moduls/social_login_screen/cubit/states.dart';
import 'package:first/shared/network/end_points.dart';
import 'package:first/shared/network/remote/dio_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart';

import '../../../../shared/components/constants.dart';
import '../../../../shared/network/local/cache_helper.dart';

class SocialLoginCubit extends Cubit<SocialLoginStates> {
  SocialLoginCubit() : super(SocialLoginInitialState());

  static SocialLoginCubit get(context) => BlocProvider.of(context);

  void userLogin({
    required String email,
    required String password,
  })
  {
    emit(SocialLoginLoadingState());

   FirebaseAuth.instance.signInWithEmailAndPassword(
     email: email, 
     password: password
     ).then((value) 
     {
       print(value.user!.email);
       print(value.user!.uid);
       uId = value.user!.uid;
  CacheHelper.saveData(key: 'uId', value: value.user!.uid);
      uId = value.user!.uid;
       emit(SocialLoginSuccessState(value.user!.uid));
     }).catchError((error)
     {
        emit(SocialLoginErrorState(error.toString()));
     });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibility()
  {
    isPassword = !isPassword;
    suffix = isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined ;

    emit(SocialChangePasswordVisibilityState());
  }
}