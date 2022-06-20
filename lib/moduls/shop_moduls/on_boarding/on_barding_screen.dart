import 'package:first/moduls/shop_moduls/shop_login_screen/shop_login_screen.dart';
import 'package:first/shared/components/components.dart';
import 'package:first/shared/network/local/cache_helper.dart';
import 'package:first/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BoardingModel{
  final String image;
  final String title;
  final String body;

  BoardingModel(
    {
    required this.image,
    required this.title,
    required this.body,
    }
  );

  }


class OnBoardingScreen extends StatefulWidget {
  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
 List<BoardingModel> boarding=[
   BoardingModel(
     image: 'https://static.vecteezy.com/system/resources/previews/002/268/082/large_2x/happy-women-jumping-and-holding-shopping-bags-illustration-free-vector.jpg',
      title: 'On Boarding 1 Title',
       body: 'On Boarding 1 Body'
       ),
 BoardingModel(
     image: 'https://static.vecteezy.com/system/resources/previews/002/268/082/large_2x/happy-women-jumping-and-holding-shopping-bags-illustration-free-vector.jpg',
      title: 'On Boarding 2 Title',
       body: 'On Boarding 2 Body'
       ),
 BoardingModel(
     image: 'https://static.vecteezy.com/system/resources/previews/002/268/082/large_2x/happy-women-jumping-and-holding-shopping-bags-illustration-free-vector.jpg',
      title: 'On Boarding 3 Title',
       body: 'On Boarding 3 Body'
       )
 
 ];

 void submit(){
   CacheHelper.saveData(key: 'onBoarding', value: true).then((value) 
   {
     if(value==true){
        navigateAndFinish(context, ShopLoginScreen());

     }
     null;
   });
   

 }
 bool isLast = false;
  var boardController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(onPressed: submit, child: Text(
            'SKIP'
            ),),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                physics: BouncingScrollPhysics(),
                onPageChanged: (int index){
                  if(index == boarding.length-1)
                  {
                    setState(() {
                      isLast = true;
                    });
                  }
                  else{
                    setState(() {
                      isLast = false;
                    });
                  }
                },
                controller: boardController,
                itemBuilder: (context,index)=> buildBoardingItem(boarding[index]),
                itemCount: boarding.length,
                ),
            ),
            SizedBox(
              height: 40.0,
            ),
              Row(
                children: [
                  Center(
                    child: SmoothPageIndicator(
                      controller: boardController,
                       count: boarding.length,
                       effect: ExpandingDotsEffect(
                         dotColor: Colors.grey,
                         activeDotColor: defultColor,
                         dotHeight: 10,
                         expansionFactor: 4,
                         dotWidth: 10,
                         spacing: 5,
                       ),
                       ),
                  ),
                  Spacer(),
                  FloatingActionButton(
                    onPressed: (){
                      if(isLast==true){
                        submit;                      
                         }
                      else{
                        boardController.nextPage(
                        duration: Duration(
                          milliseconds: 750,
                        ),
                         curve: Curves.fastLinearToSlowEaseIn,
                         );
                      }
                      
                    },
                    child: Icon(Icons.arrow_forward_ios),
                    )
                ],
              )
          ],
        ),
      )
      );
  }
}

Widget buildBoardingItem(BoardingModel model)=>  Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: Image(image: NetworkImage('${model.image}'))),
        SizedBox(
          height: 30.0,
          ),
        Center(
          child: Text(
            '${model.title}',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(
          height: 15.0,
          ),
      Center(
        child: Text(
            '${model.body}',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
      ),
         SizedBox(
          height: 15.0,
          ),
        ],
      );
  