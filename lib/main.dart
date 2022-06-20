import 'dart:math';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:desktop_window/desktop_window.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:first/layout/shop_layout/layout/shop_layout.dart';
import 'package:first/layout/shop_layout/shop_cubit/cubit.dart';
import 'package:first/layout/social_layout/cubit/cubit.dart';
import 'package:first/layout/social_layout/cubit/states.dart';
import 'package:first/layout/social_layout/social_layout.dart';
import 'package:first/moduls/mobile.dart';
import 'package:first/moduls/shop_moduls/shop_login_screen/cubit/cubit.dart';
import 'package:first/moduls/social_moduls/comment_screen/comment_screen.dart';
import 'package:first/moduls/social_moduls/social_login_screen/social_login_screen.dart';
import 'package:first/shared/components/components.dart';
import 'package:first/shared/components/constants.dart';
import 'package:first/shared/cubit/cubit.dart';
import 'package:first/shared/cubit/states.dart';
import 'package:first/shared/network/local/cache_helper.dart';
import 'package:first/shared/network/remote/dio_helper.dart';
import 'package:first/shared/styles/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'moduls/desktop.dart';
import 'moduls/shop_moduls/on_boarding/on_barding_screen.dart';
import 'moduls/shop_moduls/shop_login_screen/shop_login_screen.dart';
import 'moduls/social_moduls/social_register_screen/social_register_screen.dart';
import 'shared/cubit/bloc_observer.dart';
import 'package:first/moduls/social_moduls/settings/settings_screen.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print(message.data.toString());
  showToase(message: 'on message background app', state: ToastStates.SUCCESS);
}

void main() async {
  BlocOverrides.runZoned(
    () {
      AppCubit();
      ShopLoginCubit();
      ShopCubit();
      SocialCubit();
    },
    blocObserver: MyBlocObserver(),
  );

//   String token = '';

  // بيتأكد ان كل حاجه هنا في الميثود خلصت و بعدين يتفح الابلكيشن
  WidgetsFlutterBinding.ensureInitialized();

  // await DesktopWindow.setMinWindowSize(Size(350.0, 650.0));

  await Firebase.initializeApp(
    options: FirebaseOptions(
        apiKey: "AIzaSyDBPb2Vfy-dPcThtHZs9O90gq2oFaPdWiA",
        appId: "1:926815582690:android:ef35a0cec3f3af33bba1bb",
        messagingSenderId: "926815582690",
        projectId: "first---project-794c9",
        authDomain: "nanochat.firebaseapp.com",
        storageBucket: "first---project-794c9.appspot.com"),
  );

  await CacheHelper.init();
  DioHelper.init();
  Widget widget = OnBoardingScreen();
  // bool isDark = CacheHelper.getData(key: 'isDark');
  // bool? onBoarding = CacheHelper.getData(key: 'onBoarding');
  //token = CacheHelper.getData(key: 'token');
  // uId = CacheHelper.getData(key: 'uId');

// if(onBoarding != null){

// if(token != null) widget = ShopLayout();
// else{
//   widget = ShopLoginScreen();
// }

// }else{
//   widget = OnBoardingScreen();
// }

  // if (uId != null) {
  //   widget = SocialLayout();
  // } else {
  //   widget = SocialLoginScreen();
  // }

// var token = await FirebaseMessaging.instance.getToken();
// print(token);
  FirebaseMessaging.onMessage.listen((event) {
    print(event.data.toString());
    showToase(message: 'on message', state: ToastStates.SUCCESS);
  });

  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    print(event.data.toString());
    showToase(message: 'on message opend app', state: ToastStates.SUCCESS);
  });

  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  // print(token);
  // print(onBoarding);
  runApp(MyApp(widget));
}

// Stateless
// Stateful

// class MyApp

class MyApp extends StatelessWidget {
  // constructor
  // build
  final Widget widget;

  MyApp(this.widget);
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => AppCubit(),
        ),
        BlocProvider(
            create: (BuildContext context) =>
                ShopCubit() //..getHomeData()..getCategories()..getFavorites()..getUserData(),
            ),
        BlocProvider(
            create: (BuildContext context) => SocialCubit()
              ..getUserData()
              ..getPosts())
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: LightTheme,
              darkTheme: DarkTheme,
              themeMode: ThemeMode
                  .light, //AppCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
              home: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  if (constraints.minWidth.toInt() <= 560)
                    return MediaQuery(
                      data: MediaQuery.of(context).copyWith(
                        textScaleFactor: 0.7
                      ), 
                      child: MobileScreen());

                  return DeskTopScreen();
                },
              ));
        },
      ),
    );
  }
}
