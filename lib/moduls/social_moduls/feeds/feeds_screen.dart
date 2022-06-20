import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:first/models/social_models/post_model.dart';
import 'package:first/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../../layout/social_layout/cubit/cubit.dart';
import '../../../layout/social_layout/cubit/states.dart';
import '../../../shared/components/constants.dart';
import '../../../shared/styles/colors.dart';
import '../../../shared/styles/icon_broken.dart';
import '../comment_screen/comment_screen.dart';

class FeedsScreen extends StatelessWidget {
  var commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        // var indexNumber = SocialCubit.get(context).postsId[index];
        return ScreenTypeLayout(
          mobile: ConditionalBuilder(
              condition: SocialCubit.get(context).posts.length > 0 &&
                  SocialCubit.get(context).userModel != null,
              builder: (context) => SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        Card(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          elevation: 5,
                          margin: EdgeInsets.all(8.0),
                          child: Stack(
                            alignment: AlignmentDirectional.bottomEnd,
                            children: [
                              Image(
                                height: 200,
                                width: double.infinity,
                                image: NetworkImage(
                                    'https://images.pexels.com/photos/458886/pexels-photo-458886.jpeg?cs=srgb&dl=pexels-pixabay-458886.jpg&fm=jpg'),
                                fit: BoxFit.cover,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'communicate with friends',
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle1!
                                      .copyWith(color: Colors.white),
                                ),
                              )
                            ],
                          ),
                        ),
                        ListView.separated(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) => buildPostItem(
                              SocialCubit.get(context).posts[index],
                              context,
                              index),
                          separatorBuilder: (context, index) => SizedBox(
                            height: 8.0,
                          ),
                          itemCount: SocialCubit.get(context).posts.length,
                        ),
                        SizedBox(
                          height: 8.0,
                        ),
                      ],
                    ),
                  ),
              fallback: (context) =>
                  Center(child: CircularProgressIndicator())),
          desktop: Row(
            children: [
              Container(
                width: 500.0,
                child: ConditionalBuilder(
                condition: SocialCubit.get(context).posts.length > 0 &&
                    SocialCubit.get(context).userModel != null,
                builder: (context) => SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Column(
                        children: [
                          Card(
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            elevation: 5,
                            margin: EdgeInsets.all(8.0),
                            child: Stack(
                              alignment: AlignmentDirectional.bottomEnd,
                              children: [
                                Image(
                                  height: 200,
                                  width: double.infinity,
                                  image: NetworkImage(
                                      'https://images.pexels.com/photos/458886/pexels-photo-458886.jpeg?cs=srgb&dl=pexels-pixabay-458886.jpg&fm=jpg'),
                                  fit: BoxFit.cover,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'communicate with friends',
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle1!
                                        .copyWith(color: Colors.white),
                                  ),
                                )
                              ],
                            ),
                          ),
                          ListView.separated(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) => buildPostItem(
                                SocialCubit.get(context).posts[index],
                                context,
                                index),
                            separatorBuilder: (context, index) => SizedBox(
                              height: 8.0,
                            ),
                            itemCount: SocialCubit.get(context).posts.length,
                          ),
                          SizedBox(
                            height: 8.0,
                          ),
                        ],
                      ),
                    ),
                fallback: (context) =>
                    Center(child: CircularProgressIndicator())),
              ),
              Expanded(
                child: Container(
                  color: Colors.red,
                ),
              )  
            ],
          ),
          breakpoints:
              ScreenBreakpoints(desktop: 850.0, tablet: 600.0, watch: 100.0),
        );
      },
    );
  }

  Widget buildPostItem(PostModel model, context, index) => Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 5,
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
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
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            '${SocialCubit.get(context).userModel!.name}',
                            style: TextStyle(height: 1.4),
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          Icon(
                            Icons.check_circle_outline,
                            color: defultColor,
                            size: 15.0,
                          )
                        ],
                      ),
                      Text(
                        '${model.dateTime}',
                        style: Theme.of(context)
                            .textTheme
                            .caption!
                            .copyWith(height: 1.4),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    IconBroken.More_Circle,
                  ),
                  iconSize: 18.0,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              child: Container(
                width: double.infinity,
                height: 1.0,
                color: Colors.grey[300],
              ),
            ),
            Text(
              '${model.text}',
              style: Theme.of(context).textTheme.subtitle1,
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 5.0,
                bottom: 10.0,
              ),
              child: Container(
                width: double.infinity,
                child: Wrap(
                  children: [
                    Padding(
                      padding: const EdgeInsetsDirectional.only(
                        end: 6,
                      ),
                      child: Container(
                        height: 25.0,
                        child: MaterialButton(
                          minWidth: 1.0,
                          onPressed: () {},
                          padding: EdgeInsetsDirectional.zero,
                          child: Text('#flutter',
                              style: Theme.of(context)
                                  .textTheme
                                  .caption!
                                  .copyWith(color: defultColor)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (model.postImage != '')
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Container(
                  height: 140,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4.0),
                      image: DecorationImage(
                          image: NetworkImage('${model.postImage}'),
                          fit: BoxFit.cover)),
                ),
              ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 10.0,
              ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: Expanded(
                      child: InkWell(
                        child: Row(
                          children: [
                            Icon(
                              IconBroken.Heart,
                              size: 14.0,
                              color: Colors.red,
                            ),
                            SizedBox(
                              width: 5.0,
                            ),
                            Text(
                              '${SocialCubit.get(context).likes[index]}',
                              style: Theme.of(context).textTheme.caption,
                            )
                          ],
                        ),
                        onTap: () {},
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 200,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: InkWell(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(
                            IconBroken.Chat,
                            size: 14.0,
                            color: Colors.amber,
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          Text(
                            '${SocialCubit.get(context).comments[index]} comments',
                            style: Theme.of(context).textTheme.caption,
                          )
                        ],
                      ),
                      onTap: () {},
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                bottom: 10.0,
              ),
              child: Container(
                width: double.infinity,
                height: 1.0,
                color: Colors.grey[300],
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      navigateTo(context, SocialCommentScreen());
                      indexNumber = SocialCubit.get(context).postsId[index];
                      print(indexNumber);
                    },
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: 18.0,
                          backgroundImage: NetworkImage(
                            '${model.image}',
                          ),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 10.0,
                          ),
                          child: Row(
                            children: [
                              Text('write a comment'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  child: Row(
                    children: [
                      Icon(
                        IconBroken.Heart,
                        size: 14.0,
                        color: Colors.red,
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      Text(
                        'Like',
                        style: Theme.of(context).textTheme.caption,
                      )
                    ],
                  ),
                  onTap: () {
                    SocialCubit.get(context).likePost(
                        postId: SocialCubit.get(context).postsId[index]);
                  },
                ),
              ],
            ),
          ],
        ),
      ));
}
