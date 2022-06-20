import 'package:bloc/bloc.dart';
import 'package:first/models/shop_models/search_model.dart';
import 'package:first/moduls/shop_moduls/search/cubit/states.dart';
import 'package:first/shared/components/constants.dart';
import 'package:first/shared/network/end_points.dart';
import 'package:first/shared/network/remote/dio_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchCubit extends Cubit<SearchStates>
{
  SearchCubit() : super(SearchInitialState());

  static SearchCubit get(context) => BlocProvider.of(context);


  SearchModel? searchModel;

  void search(String text)
  {
    emit(SearchLoadingState());
   DioHelper.postData(
     url: SEARCH,
      data: 
   {
    'text': text
   },
   token: token,
   ).then((value) 
   {
     searchModel= SearchModel.fromJson(value.data);
     emit(SearchSuccessState());
   }).catchError((error)
   {
     print(error.toString());
     emit(SearchErrorState());
   });
  }
}