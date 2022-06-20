import 'dart:io';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:first/layout/social_layout/cubit/cubit.dart';
import 'package:first/layout/social_layout/cubit/states.dart';
import 'package:first/shared/components/components.dart';
import 'package:first/shared/styles/icon_broken.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var nameController = TextEditingController();
    var bioController = TextEditingController();
    var phoneController = TextEditingController();
    var profileImage = SocialCubit.get(context).profileImage;
    var coverImage = SocialCubit.get(context).coverImage;
    var model = SocialCubit.get(context).userModel;
    nameController.text = model!.name!;
    bioController.text = model.bio!;
    phoneController.text = model.phone!;
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {
        // if (profileImage == null) {
        //   profileImageShow = NetworkImage(
        //       'https://images.pexels.com/photos/136255/pexels-photo-136255.jpeg?cs=srgb&dl=pexels-monicore-136255.jpg&fm=jpg');
        // }else
        // {
        //   profileImageShow = FileImage(profileImage);
        // }

        // if(coverImage == null)
        // {
        //     coverImageShow = NetworkImage(
        //         'https://images.pexels.com/photos/136255/pexels-photo-136255.jpeg?cs=srgb&dl=pexels-monicore-136255.jpg&fm=jpg',
        //                  );
        // }else
        // {
        //   coverImageShow = FileImage(coverImage);
        // }
      },
      builder: (context, state) {
        return Scaffold(
          appBar:
              defaultAppBar(context: context, title: 'Edit Profile', actions: [
            TextButton(
                onPressed: () {
                  SocialCubit.get(context).updateUser(
                      name: nameController.text,
                      phone: phoneController.text,
                      bio: bioController.text);
                },
                child: Text('update'.toUpperCase())),
            SizedBox(
              width: 15.0,
            )
          ]),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                if (state is SocialUpdateUserLoadingState)
                  LinearProgressIndicator(),
                  SizedBox(height: 5.0,),
                  // if (state is SocialUpdateUserLoadingState)
                Container(
                  height: 190.0,
                  child: Stack(
                    alignment: AlignmentDirectional.bottomCenter,
                    children: [
                      Align(
                        child: Stack(
                          alignment: AlignmentDirectional.topEnd,
                          children: [
                            Container(
                              height: 140.0,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(
                                    4.0,
                                  ),
                                  topRight: Radius.circular(
                                    4.0,
                                  ),
                                ),
                                image: DecorationImage(
                                  image:NetworkImage(
                                    '${model.cover}',
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            IconButton(
                                onPressed: () {
                                  SocialCubit.get(context).getCoverImage();
                                },
                                icon: CircleAvatar(
                                    radius: 20.0,
                                    child: Icon(
                                      IconBroken.Camera,
                                      size: 14.0,
                                    )))
                          ],
                        ),
                        alignment: AlignmentDirectional.topCenter,
                      ),
                      Stack(
                        alignment: AlignmentDirectional.bottomEnd,
                        children: [
                          CircleAvatar(
                            radius: 64.0,
                            backgroundColor:
                                Theme.of(context).scaffoldBackgroundColor,
                            child: CircleAvatar(
                              radius: 60.0,
                              backgroundImage: NetworkImage(
                                '${model.image}',
                              ),
                            ),
                          ),
                          IconButton(
                              onPressed: () {
                                SocialCubit.get(context).getProfileImage();
                              },
                              icon: CircleAvatar(
                                  radius: 20.0,
                                  child: Icon(
                                    IconBroken.Camera,
                                    size: 14.0,
                                  )))
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                if (SocialCubit.get(context).profileImage != null ||
                    SocialCubit.get(context).coverImage != null)
                  Row(
                    children: [
                      if (SocialCubit.get(context).profileImage != null)
                        Expanded(
                          child: Column(
                            children: [
                              defaultButton(
                                  function: () {
                                    SocialCubit.get(context).uploadProfileImage(
                                        name: nameController.text,
                                        phone: phoneController.text,
                                        bio: bioController.text);
                                  },
                                  text: 'upload profile'),
                              if (state is SocialUpdateUserLoadingState)
                                SizedBox(
                                  height: 5.0,
                                ),
                              if (state is SocialUpdateUserLoadingState)
                                LinearProgressIndicator()
                            ],
                          ),
                        ),
                      SizedBox(
                        width: 5.0,
                      ),
                      if (SocialCubit.get(context).coverImage != null)
                        Expanded(
                          child: Column(
                            children: [
                              defaultButton(
                                  function: () {
                                    SocialCubit.get(context).uploadCoverImage(
                                      name: nameController.text,
                                      phone: phoneController.text,
                                      bio: bioController.text,
                                    );
                                  },
                                  text: 'upload cover'),
                              if (state is SocialUpdateUserLoadingState)
                                SizedBox(
                                  height: 5.0,
                                ),
                              if (state is SocialUpdateUserLoadingState)
                                LinearProgressIndicator()
                            ],
                          ),
                        )
                    ],
                  ),
                SizedBox(
                  height: 20.0,
                ),
                // if (SocialCubit.get(context).profileImage != null ||
                //     SocialCubit.get(context).coverImage != null)
                defaultFormField(
                    controller: nameController,
                    type: TextInputType.name,
                    validate: (String value) {
                      if (value.isEmpty) {
                        return 'name must not be empty';
                      }
                      return null;
                    },
                    label: 'Name',
                    prefix: IconBroken.User),
                SizedBox(
                  height: 10.0,
                ),
                defaultFormField(
                    controller: bioController,
                    type: TextInputType.text,
                    validate: (String value) {
                      if (value.isEmpty) {
                        return 'bio must not be empty';
                      }
                      return null;
                    },
                    label: 'Bio',
                    prefix: IconBroken.Info_Circle),
                SizedBox(
                  height: 10.0,
                ),
                defaultFormField(
                    controller: phoneController,
                    type: TextInputType.phone,
                    validate: (String value) {
                      if (value.isEmpty) {
                        return 'phone must not be empty';
                      }
                      return null;
                    },
                    label: 'Phone',
                    prefix: IconBroken.Call),
              ],
            ),
          ),
        );
      },
    );
  }
}
