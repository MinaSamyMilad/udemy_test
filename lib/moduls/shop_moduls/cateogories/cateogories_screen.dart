import 'package:first/layout/shop_layout/shop_cubit/cubit.dart';
import 'package:first/models/shop_models/categories_model.dart';
import 'package:first/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoriesScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
      listener: (contex, state){},
      builder: (context, state){
        return ListView.separated(
        itemBuilder: (context, index) =>buildCatItem(ShopCubit.get(context).categoriesModel!.data!.data![index]), 
        separatorBuilder: (context, index) =>myDivider(), 
        itemCount: ShopCubit.get(context).categoriesModel!.data!.data!.length,
        );
  
      },
         );
    }
}

Widget buildCatItem(DataModel model) =>Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
        Image(
          image: NetworkImage(model.image!),
          width:80.0,
          height: 80.0,
          fit: BoxFit.cover,
          ),
        SizedBox(
            width: 20,
          ),
        Text(
            model.name!,
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold
            ),
            ),
        Spacer(),
        Icon(Icons.arrow_forward_ios)
        ],
      ),
    );
 