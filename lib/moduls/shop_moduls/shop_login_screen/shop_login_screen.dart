import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:first/layout/shop_layout/layout/shop_layout.dart';
import 'package:first/models/shop_models/shop_login_models.dart';
import 'package:first/moduls/shop_moduls/register_screen/shop_register_screen.dart';
import 'package:first/moduls/shop_moduls/shop_login_screen/cubit/cubit.dart';
import 'package:first/moduls/shop_moduls/shop_login_screen/cubit/states.dart';
import 'package:first/shared/components/components.dart';
import 'package:first/shared/components/constants.dart';
import 'package:first/shared/network/local/cache_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ShopLoginScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit, ShopLoginStates>(
        listener: (context, state) {
          if(state is ShopLoginSuccessState)
          {
            if(state.loginModel.status== true)
            {
              print(state.loginModel.message);
              print(state.loginModel.data!.token);
              CacheHelper.saveData(key: 'token', value: '123456789').then((value) {
               token = state.loginModel.data!.token!;

                navigateAndFinish(context, ShopLayout());
              });
            }
            else{

showToase(message: state.loginModel.message, state: ToastStates.ERRoR);
              
                print(state.loginModel.message);
            }
          }
        },
        builder: (context, state) {
          
          CacheHelper.saveData(key: 'token', value: '123456789');
          return Scaffold(
              appBar: AppBar(),
              body: Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('LOGIN',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline4!
                                  .copyWith(
                                    color: Colors.black,
                                  )),
                          Text('Login now to browse our hot offres',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                    color: Colors.grey,
                                  )),
                          SizedBox(
                            height: 30.0,
                          ),
                          TextFormField(
      controller: emailController,
        onFieldSubmitted: (value)
        {
          print(value);
        },
        
        keyboardType: TextInputType.emailAddress,
    
      decoration: InputDecoration
      (
        labelText: 'Email Address',
        border: OutlineInputBorder(),
        prefixIcon: Icon(Icons.email),
      ),
        ),
                          SizedBox(
                            height: 15,
                          ),
                          Container(
                            child: defaultFormField(
                              controller: passwordController,
                              type: TextInputType.visiblePassword,
                              validate: (String value) {
                                if (value.isEmpty) {
                                  return 'password is too short';
                                }
                                return null;
                              },
                              onSubmit: (value) {
                                if (formKey.currentState!.validate()) {
                                  ShopLoginCubit.get(context).userLogin(
                                    email: emailController.text,
                                    password: passwordController.text,
                                  );
                                }
                              },
                              label: 'password',
                              prefix: Icons.lock,
                              isPassword: ShopLoginCubit.get(context).isPassword,
                              suffix: ShopLoginCubit.get(context).suffix,
                              suffixPressed: () {
                                ShopLoginCubit.get(context)
                                    .changePasswordVisibility();
                              },
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          ConditionalBuilder(
                            condition: state is! ShopLoginLoadingState,
                            builder: (context) => defaultButton(
                              function: () {
                                if (formKey.currentState!.validate()) {
                                  ShopLoginCubit.get(context).userLogin(
                                    email: emailController.text,
                                    password: passwordController.text,
                                   
                                  );
                                }
                              },
                              text: 'login',
                              isUpperCase: true,
                            ),
                            fallback: (context) =>
                                Center(child: CircularProgressIndicator()),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Don\'t have an account?'),
                              TextButton(
                                  onPressed: () {
                                    navigateTo(context, ShopRegisteScreen());
                                  },
                                  child: Text('REGISTER'))
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ));
        },
      ),
    );
  }
}
