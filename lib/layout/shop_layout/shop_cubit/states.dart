import 'package:first/models/shop_models/change_favorites_model.dart';
import 'package:first/models/shop_models/shop_login_models.dart';

abstract class ShopStates{}

class ShopInitialState extends ShopStates{}

class ShopChangeBottomNavState extends ShopStates{}

class ShopLoadingHomeDataState extends ShopStates{}

class ShopSuccessHomeDataState extends ShopStates{}

class ShopErrorHomeDataState extends ShopStates{}

class ShopSuccessCategoriesState extends ShopStates{}

class ShopErrorCategoriesState extends ShopStates{}

class ShopSuccessChangeFavoritesState extends ShopStates{
final ChangeFavoritesModel model;

  ShopSuccessChangeFavoritesState(this.model);

}

class ShopChangeFavoritesState extends ShopStates{}

class ShopErrorChangeFavoritesState extends ShopStates{}

class ShopLoadingGetFavoritesState extends ShopStates{}

class ShopGetFavoritesState extends ShopStates{}

class ShopErrorGetFavoritesState extends ShopStates{}

class ShopLoadingGetUserDataState extends ShopStates{}

class ShopSuccessGetUserDataState extends ShopStates
{
  final ShopLoginModel loginModel;

  ShopSuccessGetUserDataState(this.loginModel);
}

class ShopErrorGetUserDataState extends ShopStates{}

class ShopLoadingUpdateUserDataState extends ShopStates{}

class ShopSuccessUpdateUserDataState extends ShopStates
{
  final ShopLoginModel loginModel;

  ShopSuccessUpdateUserDataState(this.loginModel);
}

class ShopErrorUpdateUserDataState extends ShopStates{}