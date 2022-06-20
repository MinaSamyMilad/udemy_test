import 'package:first/layout/shop_layout/shop_cubit/cubit.dart';
import 'package:first/layout/shop_layout/shop_cubit/states.dart';

import 'package:first/moduls/shop_moduls/search/search_screen.dart';
import 'package:first/shared/components/components.dart';
import 'package:first/shared/network/local/cache_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var cubit = ShopCubit.get(context);
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
            appBar: AppBar(
              title: Text('Salla'),
              actions: [
                IconButton(onPressed: (){
                  navigateTo(context, ShopSearchScreen());
                }, icon: Icon(Icons.search))
              ],
            ),
            body: cubit.bottomScreens[cubit.curruntIndex],
            bottomNavigationBar: BottomNavigationBar(
              onTap: (index)
              {
                cubit.changeBottomNav(index);
              },
              currentIndex: cubit.curruntIndex,
              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.apps),
                  label: 'Categories',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.favorite),
                  label: 'Favourites',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.settings),
                  label: 'Settings',
                ),
                  ],
            ));

      },
    );
  }
}
