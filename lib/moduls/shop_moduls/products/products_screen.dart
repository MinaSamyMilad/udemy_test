import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:first/layout/shop_layout/shop_cubit/cubit.dart';
import 'package:first/layout/shop_layout/shop_cubit/states.dart';
import 'package:first/models/shop_models/categories_model.dart';
import 'package:first/models/shop_models/home_models.dart';
import 'package:first/shared/components/components.dart';
import 'package:first/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart';

class ProductsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state){
        if(state is ShopSuccessChangeFavoritesState){
          if(state.model.status == false)
          {
              showToase(
                message: state.model.message,
                 state: ToastStates.ERRoR,
                 );
          }
        }
      },
      builder: (context, state)
      {
        return ConditionalBuilder(
          condition: ShopCubit.get(context).homeModel != null && ShopCubit.get(context).categoriesModel != null,
           builder: (context)=> bulderWidget(ShopCubit.get(context).homeModel!, ShopCubit.get(context).categoriesModel!, context),
            fallback: (context)=> Center(child: CircularProgressIndicator())
            );
      }
    );
 
  }
  Widget bulderWidget(HomeModel model, CategoriesModel categoriesmodel, context)=> SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CarouselSlider(
          items: model.data!.banners.map((e) => Image(
            image: NetworkImage('${e.image}'),
           width: double.infinity,
           fit: BoxFit.cover,
            )).toList(),
            
          
           options: CarouselOptions(
             height: 250.0,
             initialPage: 0,
             viewportFraction: 1.0,
             enableInfiniteScroll: true,
             reverse: false,
             autoPlay: true,
             autoPlayInterval: Duration(seconds: 3),
             autoPlayAnimationDuration: Duration(seconds: 1),
             autoPlayCurve: Curves.fastOutSlowIn,
             scrollDirection: Axis.horizontal,
           )),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Categories',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w800
                ),
              ),
               SizedBox(
                height: 10,
               ),
              Container(
                height: 100.0,
                child: ListView.separated(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) =>buildCategoryItem(categoriesmodel.data!.data![index]), 
                separatorBuilder: (context, index) => SizedBox(
                  width:20.0
                  ), 
                itemCount: categoriesmodel.data!.data!.length,
                ),
              ),
               SizedBox(
                height: 20,
                 ),
              Text(
                'New Products',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w800
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),      
        Container(
       color: Colors.grey[300],
       child: GridView.count(
         shrinkWrap: true,
         physics:NeverScrollableScrollPhysics(),
         crossAxisCount: 2,
         mainAxisSpacing: 1,
         crossAxisSpacing: 1,
         childAspectRatio: 1 / 1.58,
         children: List.generate(
           model.data!.products.length, 
           (index) => buildGridProduct(model.data!.products[index], context)
           
           )
         ),
     )    
  ],
    ),
  );
  }

Widget buildCategoryItem(DataModel model)=>Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        Image(
          image: NetworkImage(model.image!),
            height: 100.0,
            width: 100.0,
            fit: BoxFit.cover,
            ),
     Container(
       color: Colors.black.withOpacity(0.8),
       width: 100,
       child: Text(
         model.name!,
         textAlign: TextAlign.center,
         maxLines: 1,
         overflow: TextOverflow.ellipsis,
         style: TextStyle(
           color: Colors.white,
         ),
         
       ),
     ),
      ],
    );
        

  Widget buildGridProduct(productModel model, context)=>Container(
    color: Colors.white,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               Stack(
                 alignment: AlignmentDirectional.bottomStart,
                 children: [
                   Image(image: NetworkImage(model.image!),
                   width: double.infinity,
                   height: 200,
                   ),
                   if(model.disCount != 0)
                   Container(
                    color: Colors.red,
                     child: Padding(
                       padding: const EdgeInsets.symmetric(horizontal: 5.0),
                       child: Text(
                         'DISCOUNT',
                         style: TextStyle(
                           fontSize: 8.0,
                           color: Colors.white
                         ),
                       ),
                     ),
                   )
                 ],
               ),
             Padding(
               padding: const EdgeInsets.all(12.0),
               child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   Text(
                     model.name!,
                     maxLines:2,
                     overflow: TextOverflow.ellipsis,
                     style: TextStyle(
                       fontSize: 14.0,
                       height: 1.3
                       ),
                   ),
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
                   if(model.disCount != 0)
                       Text(
                         '${model.oldPrice.round()}',
                         style: TextStyle(
                           fontSize: 10.0,
                           color: Colors.grey,
                           decoration: TextDecoration.lineThrough
                           ),
                   ),
                   
                   Spacer(),

                   CircleAvatar(
                     radius: 15,
                     child: IconButton(
                       onPressed: ()
                       {
                        ShopCubit.get(context).changeFavorites(model.id);
                       },
                        icon: Icon(
                          Icons.favorite_border,
                          size: 14,
                          color: ShopCubit.get(context).favourits[model.id] == true? defultColor : Colors.grey,
                          )
                        ),
                   )
                        
                     
                      ],
                    ),
                 ],
               ),
             )
             
             ],
           ),
  );


