import 'package:first/models/shop_models/shop_login_models.dart';
import 'package:first/moduls/shop_moduls/register_screen/cubit/states.dart';
import 'package:first/shared/network/end_points.dart';
import 'package:first/shared/network/remote/dio_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart';

class ShopRegisterCubit extends Cubit<ShopRegisterStates> {
  ShopRegisterCubit() : super(ShopRegisterInitialState());

  static ShopRegisterCubit get(context) => BlocProvider.of(context);
  ShopLoginModel? registerModel;
  void userRegister({
    required String email,
    required String password,
    required String name,
    required String phone,

  })
  {
    emit(ShopRegisterLoadingState());

    DioHelper.postData(
      url: REGISTER,
      data:
      {
        'email': email,
        'password': password,
        'name': name,
        'phone': phone,

      },
    ).then((value)
    {
      print(value.data['message']);

      print(value.data);

      registerModel = ShopLoginModel.fromJson(value.data);
     
      emit(ShopRegisterSuccessState(registerModel!));
    }).catchError((error)
    {
      print(error.toString());
      emit(ShopRegisterErrorState(error.toString()));
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibility()
  {
    isPassword = !isPassword;
    suffix = isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined ;

    emit(ShopRegisterChangePasswordVisibilityState());
  }
}