import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:first/layout/shop_layout/shop_cubit/cubit.dart';
import 'package:first/layout/shop_layout/shop_cubit/states.dart';
import 'package:first/models/shop_models/favorits_model.dart';
import 'package:first/shared/components/components.dart';
import 'package:first/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavouritsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
      listener: (contex, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: state! is ShopLoadingGetFavoritesState,
          builder: (context) => ListView.separated(
            itemBuilder: (context, index) => buildListProduct(
                ShopCubit.get(context).favoritesModel!.data!.data![index].product!, context),
            separatorBuilder: (context, index) => myDivider(),
            itemCount:
                ShopCubit.get(context).favoritesModel!.data!.data!.length,
          ),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}

