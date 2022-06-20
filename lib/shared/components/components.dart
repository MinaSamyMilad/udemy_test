import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:first/layout/shop_layout/shop_cubit/cubit.dart';
import 'package:first/shared/cubit/cubit.dart';
import 'package:first/shared/styles/colors.dart';
import 'package:first/shared/styles/icon_broken.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

Widget defaultButton({
  double width = double.infinity,
  Color background = Colors.blue,
  bool isUpperCase = true,
  double radius = 3.0,
  required Function function,
  required String text,
}) =>
    Container(
      width: width,
      height: 40.0,
      child: MaterialButton(
        onPressed: () {
          function();
        },
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          radius,
        ),
        color: background,
      ),
    );

//     Widget defaultTextButton({
//   required Function function,
//   required String text,
// }) =>
//     TextButton(
//       onPressed: function,
//       child: Text(
//         text.toUpperCase(),
//       ),
//     );
Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  Function? onSubmit,
  Function? onChange,
  Function? onTap,
  bool isPassword = false,
  required Function validate,
  required String label,
  required IconData prefix,
  IconData? suffix,
  Function? suffixPressed,
  bool isClickable = true,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      enabled: isClickable,
      onFieldSubmitted: (s) {
        onSubmit!(s);
      },
      onChanged: (s) {
        onChange!(s);
      },
      onTap: () {
        onTap!();
      },
      validator: (s) {
        validate(s);
      },
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(
          prefix,
        ),
        suffixIcon: suffix != null
            ? IconButton(
                onPressed: () {
                  suffixPressed!();
                },
                icon: Icon(
                  suffix,
                ),
              )
            : null,
        border: OutlineInputBorder(),
      ),
    );
// Widget buildTaskItem(Map model, context) => Dismissible(
//   key: Key(model['id'].toString()),
//   child:   Padding(

//       padding: const EdgeInsets.all(20.0),

//       child: Row(

//         children: [

//           CircleAvatar(

//             radius: 35,

//             child: Text('${model['title']}'),

//           ),

//           SizedBox(

//             width: 16,

//           ),

//           Expanded(

//             child: Column(

//               mainAxisSize: MainAxisSize.min,

//               children: [

//                 Text(

//                   '${model['time']}',

//                   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),

//                 ),

//                 Text('${model['date']}', style: TextStyle(color: Colors.grey))

//               ],

//             ),

//           ),

//           SizedBox(

//             width: 20,

//           ),

//           IconButton(onPressed: () {

//             AppCubit.get(context).updateData(states: 'dane', id: model['id'], status: '');

//           }, icon: Icon(Icons.check_box),

//           color: Colors.green,

//           ),

//           IconButton(onPressed: () {

//             AppCubit.get(context).updateData(status: 'archive', id: model['id'],);

//           }, icon: Icon(Icons.archive),

//           color: Colors.black45,

//           )

//         ],

//       )),
// onDismissed: (direction)
// {
//   AppCubit.get(context).deleteData(id: model['id']);
// },
// );
// Widget tasksItem({
//   required tasks,
// })=> ConditionalBuilder(
//          condition: tasks.length > 0,
//          builder: (BuildContext context) => ListView.separated(
//              itemBuilder: (context, index)=> buildTaskItem(tasks[index],context),
//              separatorBuilder: (context, index)=> myDivider(),
//               itemCount: tasks.length
//               ),
//          fallback: (context) => Center(
//            child: Column(
//              mainAxisAlignment: MainAxisAlignment.center,
//              children: [
//                Icon(Icons.menu,
//                size: 60,
//                color: Colors.grey,
//                ),
//                Text('No Tasks Yet, Please Add Some Tasks',
//                style: TextStyle(color: Colors.grey,
//                fontWeight: FontWeight.bold,
//                fontSize: 16,
//                ),
//                )
//              ],
//            )
//          ),
//           );

//         Widget buildArticleItem(article, context) => InkWell(
//           onTap: () {
//            navigateTo(context,WebviewScreen(
//               '${article['url']}'
//               )
//               );
//           },
//           child: Padding(
//           padding: const EdgeInsets.all(20.0),
//           child: Row(
//             children: [
//               Container(
//           width: 120.0,
//           height: 120.0,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(10.0,),
//             image: DecorationImage(
//               image: NetworkImage('${article['urlToImage']}'),
//               fit: BoxFit.cover,
//             ),
//           ),
//               ),
//               SizedBox(
//           width: 20.0,
//               ),
//               Expanded(
//           child: Container(
//             height: 120.0,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisAlignment: MainAxisAlignment.start,
//               children:
//               [
//                 Expanded(
//                   child: Text(
//                     '${article['title']}',
//                     style: Theme.of(context).textTheme.bodyText1,
//                     maxLines: 3,
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                 ),
//                 Text(
//                   '${article['publishedAt']}',
//                   style: TextStyle(
//                     color: Colors.grey,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//               ),
//               SizedBox(
//           width: 15.0,
//               ),
//             ],
//           ),
//         ),
//         );

Widget myDivider() =>
    Container(width: double.infinity, height: 1, color: Colors.grey);

//              Widget articleBuilder(List list, context, {isSearch: false}) =>ConditionalBuilder(
//         condition: list.length>0,
//          builder: (context) =>ListView.separated(
//            physics: BouncingScrollPhysics(),
//            itemBuilder: (context,index)=> buildArticleItem(list[index], context),
//             separatorBuilder: (context,index)=> myDivider(),
//              itemCount: 10,
//              ),
//           fallback:(context) => isSearch? Container() : Center(child: CircularProgressIndicator()) ,
//           );

void navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );

void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ),
    (route) => false);

void showToase({
  required message,
  required ToastStates state,
}) =>
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: color,
      textColor: Colors.white,
      fontSize: 16.0,
    );

enum ToastStates { SUCCESS, ERRoR, WARING }

Color? color;

Color? chooseColorToast(ToastStates state) {
  switch (state) {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.ERRoR:
      color = Colors.red;
      break;
    case ToastStates.WARING:
      color = Colors.amber;
      break;
  }
  return null;
}

Widget buildListProduct(model, context, {bool OldPrice = true}) => Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        height: 120,
        child: Row(
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                  image: NetworkImage(model.image!),
                  width: 120,
                  height: 120,
                ),
                if (model.discount != 0 && OldPrice == true)
                  Container(
                    color: Colors.red,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: Text(
                        'DISCOUNT',
                        style: TextStyle(fontSize: 8.0, color: Colors.white),
                      ),
                    ),
                  )
              ],
            ),
            SizedBox(
              width: 20,
            ),
            Expanded(
              child: Column(
                children: [
                  Text(
                    model.name!,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 14.0, height: 1.3),
                  ),
                  Spacer(),
                  Row(
                    children: [
                      Text(
                        '${model.price.round()}',
                        style: TextStyle(
                          fontSize: 12.0,
                          color: defultColor,
                        ),
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      if (model.discount != 0 && OldPrice == true)
                        Text(
                          '${model.oldPrice.round()}',
                          style: TextStyle(
                              fontSize: 10.0,
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough),
                        ),
                      Spacer(),
                      CircleAvatar(
                        radius: 15,
                        child: IconButton(
                            onPressed: () {
                              ShopCubit.get(context).changeFavorites(model.id!);
                            },
                            icon: Icon(
                              Icons.favorite_border,
                              size: 14,
                              color:
                                  ShopCubit.get(context).favourits[model.id] ==
                                          true
                                      ? defultColor
                                      : Colors.grey,
                            )),
                      )
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );

PreferredSizeWidget defaultAppBar({
  required BuildContext context,
  String? title,
  List<Widget>? actions,
}) =>
    AppBar(
      leading: IconButton(
        onPressed: ()
        {
          Navigator.pop(context);
        },
        icon: Icon(
          IconBroken.Arrow___Left_2
        ),
      ),
      title: Text(title!),
      actions: actions,
    );
