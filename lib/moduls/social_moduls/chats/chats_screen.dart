import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:first/layout/social_layout/cubit/cubit.dart';
import 'package:first/layout/social_layout/cubit/states.dart';
import 'package:first/models/social_models/social_user_model.dart';
import 'package:first/shared/components/components.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/styles/colors.dart';
import '../chats_details/chats_details_screen.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
            condition: SocialCubit.get(context).users.length > 0,
            builder: (context) => ListView.separated(
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) => buildChatItem(
                    context, SocialCubit.get(context).users[index]),
                separatorBuilder: (context, index) => myDivider(),
                itemCount: SocialCubit.get(context).users.length),
            fallback: (context) => Center(child: CircularProgressIndicator()));
      },
    );
  }
}

Widget buildChatItem(context, SocialUserModel model) => InkWell(
      onTap: () {
        navigateTo(
            context,
            ChatsDetailsScreen(
              userModel: model,
            ));
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 25,
              backgroundImage: NetworkImage('${model.image}'),
            ),
            SizedBox(
              width: 15,
            ),
            Text(
              '${model.name}',
              style: TextStyle(height: 1.4),
            ),
          ],
        ),
      ),
    );
    
//hi