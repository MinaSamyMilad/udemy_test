import 'package:bloc/bloc.dart';
import 'package:first/layout/shop_layout/shop_cubit/states.dart';
import 'package:first/models/shop_models/categories_model.dart';
import 'package:first/models/shop_models/change_favorites_model.dart';
import 'package:first/models/shop_models/favorits_model.dart';
import 'package:first/models/shop_models/home_models.dart';
import 'package:first/models/shop_models/shop_login_models.dart';

import 'package:first/moduls/shop_moduls/cateogories/cateogories_screen.dart';
import 'package:first/moduls/shop_moduls/favourits/favourits_screen.dart';
import 'package:first/moduls/shop_moduls/products/products_screen.dart';
import 'package:first/moduls/shop_moduls/settings/settings_screen.dart';
import 'package:first/shared/components/constants.dart';
import 'package:first/shared/network/end_points.dart';
import 'package:first/shared/network/remote/dio_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopCubit extends Cubit<ShopStates>{
  ShopCubit() : super(ShopInitialState());

static ShopCubit get(context) => BlocProvider.of(context);

Map<int, bool> favourits= {};

int curruntIndex = 0;

List<Widget> bottomScreens =[
ProductsScreen(),
CategoriesScreen(),
FavouritsScreen(),
SettingsScreen(),
];

void changeBottomNav(int index)
{
  curruntIndex = index;
  emit(ShopChangeBottomNavState());
}


HomeModel? homeModel;

void getHomeData()
{
  emit(ShopLoadingHomeDataState());
  DioHelper.getData(
    url: HOME,
    token: token,
    ).then((value) 
  {
    homeModel = HomeModel.fromJson(value.data);
    print(homeModel!.data!.banners[0].image);
    print(homeModel!.status);
    homeModel!.data!.products.forEach((element) {
     favourits.addAll({
     element.id : element.inFavourites,
     });
    });
    emit(ShopSuccessHomeDataState());
    
  }).catchError((error)
  {
    print(error.toString());
    emit(ShopErrorHomeDataState());
  });
}

CategoriesModel? categoriesModel;

void getCategories()
{
  DioHelper.getData(
    url: GET_CATEGORIES,
    ).then((value) 
  {
    categoriesModel = CategoriesModel.fromJson(value.data);

    emit(ShopSuccessCategoriesState());
    
  }).catchError((error)
  {
    print(error.toString());
    emit(ShopErrorCategoriesState());
  });
}

ChangeFavoritesModel? changeFavoritesModel;

void changeFavorites(int productId)
{

  favourits[productId] = !favourits[productId]!;
    emit(ShopChangeFavoritesState());

 DioHelper.postData(
   url: FAVORITES,
    data: {
      'product_id' : productId,
    },
    token: token,
    ).then((value)
    {
      
      changeFavoritesModel = ChangeFavoritesModel.fromjson(value.data);
      if(categoriesModel!.status == false)
      {
       favourits[productId] = !favourits[productId]!;
      }else{
        getFavorites();
      }
    emit(ShopSuccessChangeFavoritesState(changeFavoritesModel!));
    }).catchError((error)
    {
    favourits[productId] = !favourits[productId]!;
    emit(ShopErrorChangeFavoritesState());
  
    });
}
FavoritesModel? favoritesModel;

void getFavorites()
{
  emit(ShopLoadingGetFavoritesState());
  DioHelper.getData(
    url: FAVORITES,
    token: token
    ).then((value) 
  {
    favoritesModel = FavoritesModel.fromJson(value.data);

    emit(ShopGetFavoritesState());
    
  }).catchError((error)
  {
    print(error.toString());
    emit(ShopErrorGetFavoritesState());
  });
}

ShopLoginModel? userModel;

void getUserData()
{
  emit(ShopLoadingGetUserDataState());
  DioHelper.getData(
    url: PROFILE,
    token: token
    ).then((value) 
  {
    userModel = ShopLoginModel.fromJson(value.data);

    emit(ShopSuccessGetUserDataState(userModel!));
    
  }).catchError((error)
  {
    print(error.toString());
    emit(ShopErrorGetUserDataState());
  });
}

void updateUserData({
  required String name,
  required String email,
  required String phone,

})
{
  emit(ShopLoadingUpdateUserDataState());
  DioHelper.putData(
    url: UPDATE_PROFILE,
    token: token,
    data: {
     'name': name,
     'email': email,
     'phone': phone,
    }
    ).then((value) 
  {
    userModel = ShopLoginModel.fromJson(value.data);

    emit(ShopSuccessUpdateUserDataState(userModel!));
    
  }).catchError((error)
  {
    print(error.toString());
    emit(ShopErrorUpdateUserDataState());
  });
}
}



