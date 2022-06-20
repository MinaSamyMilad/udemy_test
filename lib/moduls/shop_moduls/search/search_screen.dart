import 'package:first/layout/shop_layout/shop_cubit/cubit.dart';
import 'package:first/moduls/shop_moduls/search/cubit/cubit.dart';
import 'package:first/moduls/shop_moduls/search/cubit/states.dart';
import 'package:first/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopSearchScreen extends StatelessWidget {
 var formKey = GlobalKey<FormState>();
 var searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchStates>(
         listener: (context, state) {}, 
         builder: (context, state) {
           return Scaffold(
          appBar: AppBar(),
          body: Form(
            key: formKey,
            child: Column(
              children: [
                defaultFormField(
                  controller: searchController, 
                  type: TextInputType.text, 
                  validate: (String value)
                  {
                    if(value.isEmpty)
                    {
                      return 'please enter text to search';
                    }
                  }, 
                  label: 'Search', 
                  prefix: Icons.search,
                  onSubmit: (String text)
                  {
                    SearchCubit.get(context).search(text);
                  }
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  if(state is SearchLoadingState)
                   LinearProgressIndicator(),

                   ListView.separated(
            itemBuilder: (context, index) => buildListProduct(
              SearchCubit.get(context).searchModel!.data!.data![index], context, OldPrice: false,
            ),
            separatorBuilder: (context, index) => myDivider(),
            itemCount: SearchCubit.get(context).searchModel!.data!.data!.length,
          ),
        
              ],
            ),
          )
        );
         },
          ),
    );
  }
}