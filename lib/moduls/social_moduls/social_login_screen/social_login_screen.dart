import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:first/layout/social_layout/social_layout.dart';
import 'package:first/moduls/shop_moduls/register_screen/cubit/cubit.dart';
import 'package:first/moduls/shop_moduls/register_screen/shop_register_screen.dart';
import 'package:first/moduls/social_moduls/social_login_screen/cubit/cubit.dart';
import 'package:first/moduls/social_moduls/social_login_screen/cubit/states.dart';
import 'package:first/moduls/social_moduls/social_register_screen/social_register_screen.dart';

import 'package:first/shared/components/components.dart';
import 'package:first/shared/styles/icon_broken.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/network/local/cache_helper.dart';

class SocialLoginScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SocialLoginCubit(),
      child: BlocConsumer<SocialLoginCubit, SocialLoginStates>(
        listener: (context, state) {
          if (state is SocialLoginSuccessState) {
            CacheHelper.saveData(key: 'uId', value: state.uId).then((value) {
              navigateAndFinish(context, SocialLayout());
            });
          }
          if (state is SocialLoginErrorState) {
            showToase(
              message: state.error.toString(),
              state: ToastStates.ERRoR,
            );
          }
        },
        builder: (context, state) {
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
                          Text('Login now to communicate with friends',
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
                            onFieldSubmitted: (value) {
                              print(value);
                            },
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
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
                                  SocialLoginCubit.get(context).userLogin(
                                    email: emailController.text,
                                    password: passwordController.text,
                                  );
                                }
                              },
                              label: 'password',
                              prefix: Icons.lock,
                              isPassword:
                                  SocialLoginCubit.get(context).isPassword,
                              suffix: SocialLoginCubit.get(context).suffix,
                              suffixPressed: () {
                                SocialLoginCubit.get(context)
                                    .changePasswordVisibility();
                              },
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          ConditionalBuilder(
                            condition: state is! SocialLoginLoadingState,
                            builder: (context) => defaultButton(
                              function: () {
                                if (formKey.currentState!.validate()) {
                                  SocialLoginCubit.get(context).userLogin(
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
                                    navigateTo(context, SocialRegisteScreen());
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
