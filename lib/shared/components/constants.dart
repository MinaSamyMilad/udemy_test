// POST
// UPDATE
// DELETE

// GET

// base url : https://newsapi.org/
// method (url) : v2/top-headlines?
// queries : country=eg&category=business&apiKey=65f7f556ec76449fa7dc7c0069f040ca

// https://newsapi.org/v2/everything?q=tesla&apiKey=65f7f556ec76449fa7dc7c0069f040ca


import 'package:first/moduls/shop_moduls/shop_login_screen/shop_login_screen.dart';
import 'package:first/shared/components/components.dart';
import 'package:first/shared/network/local/cache_helper.dart';
import 'package:flutter/material.dart';

void signOut(context)
{
   CacheHelper.removeData(key: 'token').then((value) 
            {
              if(value == true)
              {
                navigateAndFinish(context, ShopLoginScreen());
              }
            });
}


void printFullText(String text)
{
  final pattern = RegExp('.{1,800}');
  pattern.allMatches(text).forEach((match)=> print(match.group(0)));
}
  String token = '';
  var uId = null;

  var indexNumber;