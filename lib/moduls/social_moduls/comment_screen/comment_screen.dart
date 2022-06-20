import 'package:first/layout/social_layout/cubit/states.dart';
import 'package:first/shared/components/components.dart';
import 'package:first/shared/components/constants.dart';
import 'package:first/shared/styles/icon_broken.dart';
import 'package:floor/floor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../layout/social_layout/cubit/cubit.dart';

class SocialCommentScreen extends StatelessWidget {
  var commentController = TextEditingController();
  
  @override
  Widget build(BuildContext context,) 
  {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        Widget commentScreen(commentController, context) => Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  if (state is SocialCommentPostLoadingState)
                    LinearProgressIndicator(),
                  SizedBox(
                    height: 5.0,
                  ),
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 25,
                        backgroundImage: NetworkImage(
                            '${SocialCubit.get(context).userModel!.image}'),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Expanded(
                        child: Text(
                          '${SocialCubit.get(context).userModel!.name}',
                          style: TextStyle(height: 1.4),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  // IconButton(
                  //     onPressed: () {
                  //       SocialCubit.get(context).commentPost(
                  //           postId: SocialCubit.get(context).postsId[index],
                  //           comment: commentController.text);
                  //     },
                  //     icon: Icon(IconBroken.Send)),
                  Row(
                    children: [
                      Container(
                        width: 400,
                        child: TextFormField(
                          controller: commentController,
                          decoration: InputDecoration(
                              hintText: 'write a comment',
                              border: InputBorder.none),
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            SocialCubit.get(context).commentPost(
                                postId: indexNumber,
                                comment: commentController.text);
                          },
                          icon: Icon(IconBroken.Send)),
                    ],
                  ),
                ],
              ),
            );

        return Scaffold(
            appBar: AppBar(
              title: Text('Comment'),
            ),
            body: commentScreen(commentController, context)
            );
      },
    );
  }
}
