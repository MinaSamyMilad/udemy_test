import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:first/layout/shop_layout/layout/shop_layout.dart';
import 'package:first/layout/social_layout/social_layout.dart';
import 'package:first/moduls/shop_moduls/register_screen/cubit/cubit.dart';
import 'package:first/moduls/shop_moduls/register_screen/cubit/states.dart';
import 'package:first/moduls/shop_moduls/shop_login_screen/cubit/states.dart';
import 'package:first/moduls/social_moduls/social_login_screen/cubit/states.dart';
import 'package:first/moduls/social_moduls/social_register_screen/cubit/cubit.dart';
import 'package:first/moduls/social_moduls/social_register_screen/cubit/states.dart';

import 'package:first/shared/components/components.dart';
import 'package:first/shared/components/constants.dart';
import 'package:first/shared/network/local/cache_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SocialRegisteScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SocialRegisterCubit(),
      child: BlocConsumer<SocialRegisterCubit, SocialRegisterStates>(
           listener: (context, state) {
             if(state is SocialCreateUserSuccessState)
             {
               navigateAndFinish(context, SocialLayout());
             }
//              if(state is SocialRegisterSuccessState)
//           {
//             if(state.registerModel.status== true)
//             {
//               print(state.registerModel.message);
//               print(state.registerModel.data!.token);
//               CacheHelper.saveData(key: 'token', value: state.registerModel.data!.token!).then((value) {
//                token = state.registerModel.data!.token!;

//                 navigateAndFinish(context, SocialLayout());
//               });
//             }
//             else{

// showToase(message: state.registerModel.message, state: ToastStates.ERRoR);
              
//                 print(state.registerModel.message);
//             }
//            }
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
                              Text(
                                'REGISTER',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline4!
                                      .copyWith(
                                        color: Colors.black,
                                      )),
                              Text('Register now to communicate with friends',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(
                                        color: Colors.grey,
                                      )),
                              SizedBox(
                                height: 30.0,
                              ),
                              defaultFormField(
                                  controller: nameController,
                                  type: TextInputType.name,
                                  validate: (String value) {
                                    if (value.isEmpty) {
                                      return 'please entre your Name';
                                    }
                                    return null;
                                  },
                                
                                  label: 'User Name',
                                  prefix: Icons.person,
                                ),
                              
                           SizedBox(
                                height: 15.0,
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
                                      return 'please entre your password';
                                    }
                                    return null;
                                  },
                                  onSubmit: (value) {
                                    
                                  },
                                  label: 'password',
                                  prefix: Icons.lock,
                                  isPassword: SocialRegisterCubit.get(context).isPassword,
                                  suffix: SocialRegisterCubit.get(context).suffix,
                                  suffixPressed: () {
                                    SocialRegisterCubit.get(context)
                                        .changePasswordVisibility();
                                  },
                                ),
                              ),
                                SizedBox(
                                height: 15.0,
                              ),
                                 defaultFormField(
                                  controller: phoneController,
                                  type: TextInputType.phone,
                                  validate: (String value) {
                                    if (value.isEmpty) {
                                      return 'please entre your phone number';
                                    }
                                    return null;
                                  },
                                
                                  label: 'Phone',
                                  prefix: Icons.phone,
                                ),
                              SizedBox(
                                height: 30,
                              ),
                              ConditionalBuilder(
                                condition: state is! SocialRegisterLoadingState,
                                builder: (context) => defaultButton(
                                  function: () {
                                    if (formKey.currentState!.validate()) {
                                      SocialRegisterCubit.get(context).userRegister(
                                        name: nameController.text,
                                        phone: phoneController.text,
                                        email: emailController.text,
                                        password: passwordController.text,
                                       
                                      );
                                    }
                                  },
                                  text: 'register',
                                  isUpperCase: true,
                                ),
                                fallback: (context) =>
                                    Center(child: CircularProgressIndicator()),
                              ),
                             
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
        );
           }
  
  )
    );
  }

  
}