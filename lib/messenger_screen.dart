import 'dart:html';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class MessengerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        titleSpacing: 20,
        leading: IconButton(onPressed: ()
        {
          Navigator.pop(context);
        }, 
        icon: Icon(Icons.keyboard_arrow_left),
        color: Colors.black,
        iconSize: 30,
        ),
        title: Row(children: [
          CircleAvatar(
            radius: 20,
            backgroundImage: NetworkImage(
                'data:image/png;base64,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'),
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            'Chats',
            style: TextStyle(color: Colors.black),
          ),
        ]),
        actions: [
          IconButton(
            onPressed: () {},
            iconSize: 20,
            icon: CircleAvatar(
              radius: 15,
              child: Icon(
                Icons.camera_alt,
                size: 14,
              ),
            ),
          ),
          IconButton(
              onPressed: () {},
              iconSize: 20,
              icon: CircleAvatar(
                radius: 15,
                child: Icon(
                  Icons.edit,
                  size: 14,
                ),
              ))
        ],
      ),
      body: SingleChildScrollView(child:Padding(
        padding: EdgeInsetsDirectional.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.grey,
              ),
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.only(start: 10),
                      child: Icon(Icons.search),
                    ),
                    SizedBox(width: 10),
                    Text('Search'),
                  ],
                ),
              ),
            ),
SizedBox(height: 20,),
             Container(
               height: 100,
               child: ListView.separated
            (
                scrollDirection: Axis.horizontal,
                itemBuilder: (context,index,)=>buildStoryItem(),
                separatorBuilder: (context,index,)=>SizedBox
                (
                  width: 20,
                ),
                 itemCount: 10
                 ),
                 
             ),  
          
          SizedBox
          (
            height:10
          ),

Container(

  child:   
  
  ListView.separated(
  
    
  
    physics: NeverScrollableScrollPhysics(),
  
    shrinkWrap: true,
  
    itemBuilder: (context,index)=> buildChatItem(),
  
     separatorBuilder: (context,index)=> SizedBox
  
     (height: 15,),
  
      itemCount: 15,
  
      ),
),
          ],
        ),
      ), 
      ), 
    );
  }

Widget buildStoryItem() =>  Container(
                      width: 60,
                      child: Column(
                        children: [
                          Stack(
                            alignment: AlignmentDirectional.bottomEnd,
                            children: [
                              CircleAvatar(
                                radius: 30,
                                backgroundImage: NetworkImage(
                                    'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAOEAAADhCAMAAAAJbSJIAAAAjVBMVEX///8xMTEuLi4sLCwAAAApKSkmJiYiIiI7OzsbGxv39/czMzNRUVEfHx/7+/tzc3N6enpKSkpaWlrt7e1GRkaSkpI3NzeBgYFhYWFAQEDi4uJUVFRnZ2fOzs5tbW0UFBSYmJiGhoaxsbGjo6OXl5cQEBDDw8Pb29umpqa3t7fo6OjHx8fc3NzS0tK8vLyPBEfkAAAWeklEQVR4nO1d6ZaivBaFhIRZwhBmGUURxfd/vJsgKlaVllZ3F353uX90a4mubHJy5gRBeOONN95444033njjjTfeeOONN95444033njjtxD327Zti6Lt48XcY/kHWFISZLYOMZZlVVWyw/8XSa0mdenIGOm6OAAgFRT/Pxy1VVAFqgmcLHV0ACEEA0kTHeYe2V9CRbYWlj3LSnyoGGGaZYaCIOeY07nH9jfgWtvSlCMrVRAQdU/R9SghKxpCxDiqwdzD+3McggphPw0hFM8ACCe0zviSVE+z2NdBmpZ1P+tgf4KiJiaImHieyI3LEMCkcPhybHb8sm2kMjWEsKwq1J17zE+hrG0sKgo40oMI2GHKoAxclSNlV9DCHJznV1bruUf9BKwCX4aOlKykQRo6ieFdJFZEdisjcQrV+M9MIykvQ0deUIY+SKySehgxUUUInmZN/ACE9nMP/TEE5Dx26AelbSpkFYSGkwUlISQgqf6R2nm+8WbuwT+C0sKnEeOUGjIgZSLbpCSOjzhApNxiyCjGcw//e7TWWX/6QQaQHRjYKS0PAcUzHMcxIgh8eE3srJNEKGpzE/gOS+e0BmFEDYQci/FLdZg4tu1FiuIlWWArqXk9dVECRo7ImZvBN3DDs4mwSx/C0FGCDEHgAeBHkRcxCWVyikirInDFMTPGOyNbc3O4DxKdCBolAMCxQ8K8Nt9j4snpKUpkO2wZqoclU7BTijDNRopqMTeJezjY8EQwYHKnR8TBKArZ2mPz6HuGPUyhKOpgIdTX1gKF5SipzXJuGrfhnkQNeAHk/xIfe6GBoG47CdMxisJ8GzZ5wIjqkaF/WoBsBdLjtAL8upafnpUjAXweMwhCB6DISSI2bs6eSa5iORBXhuCB45URPM/iSh/+hoy5idxCfJ6PcBDUEPlZhBTHHhxvq4QnJqlZar16nG2/DE/2E6VUHH7BLOemcgMnXSH6fOi2g6OMxRIG4w1QWNPkIo8pEorTMsRZII6fYELHpbiem8uXiJup+vcc7GXIH6wHjMrAnpgHlCqHYpw5HWCDniQVUDL8GcCXXIoBnhCMHBRlyBtiQZQEHpqGwkxqnT4fXxJbVmiCxq/VznAdTudm8wVcdUJBD6FOkJ3AYd2FGCDPiiafi3lnj3OqB4GOyxSNs1sfXQa1mpvPZ6ym9i0UIRENY8g7OTYESpZOLLyCRfOwO90RlFDHJOMiRvQYegHz5RzUxYQBSCIUGsZxljwFgCScOtvAqHNMhPDsousBUa1jSMI+MwA3GvjlklXbiTOtJDCyPGOkDBRHgcxciOessBTXjSMcjt8Y6KQlso6ziMsV9vm9aV4tVowmU+iIyDquQY6Iud2inRHLH99bBybTumAdxdELmSZlkiqScPAJvDpEhv96UcZJNQ4UbGhnzomgz8TXSRP/lL3ww4BQV9idlSn7FLA4koJgEGtUrkQYslfqbm5SV8guqRngMAcmnKgdEIlRSBwIjj4PQEhmrqd9XplQIcx3talO9WEltszMMLLQnpvUFN3EVCg2iErlIrRQCUlmKL7CwqdTikZeLSffAICkLFguI+6vi5gWOnTYi/yV8sT0Yu2HVXiWUTaBKfNrwoAWNcMpCwec6+AJkwyjzEq5foUZM/ss6hdRNjetCzT9MmV6wqbkLLOKY7CwqOb0ioIGZ/1qu+ZVBIyDDKHSCJTBsSnBsBLzbm5iZ0xMBTAUkDin0esRCFdlWlLLiWz2yenvKhXWCEGsnuceUAPq1OMKFpVlAhRGEb9OjSq52HOQAGid84XYWAWeYRmmR2hJTo6aKIfMY3Fdt9vT/Bw01z5KLYtZHZjWDoCpzizpqxRTu0lU4ScAkVOo4AdM5YS2nDB2aMhfiMzyQ2kSHGnOuCCRVWJIIybgTExTBXCv/WUMRnvRGkzPiP6YMkVGaSDdYFF9KB5jJyDKado4LZl+2xq/7RcGCoOUxf6AWjaAGdM1r5J4CydC6rDI6LgMmW7k6w7Z6THCBSr0TKYe++yDUz2mWJHFNHIRZczDISWLm1nsLOavIabatTFEZDDcIhmCPmDw9BTEvukdhPDLsE+Tj+vTr21sWZkvMu3EbpLORMHc/jaZL7G+MAS2IsIAcXfbOhr9iKkOpKYrr2ZW84bQjaoYBQFWCpuR8+skEqGlv4pJLCfmPjnee+Blp+SLCBsr3oax4Fo3sy9HXczcAB9Tg4kpLkIbAC9lk/gSYaJ9be4jC7KA4WzzzaRbWK0gVPT2mhpdOFwn2CIpm/TSYosQMSfOfIXOFHcyhXbEFl6IvIuBVAthbXWCG9x1ModsACNGsFEwhw1m3PuBzDi+hJj2k2WY6MxeG4p3mlUgLYWSaYvqm0ao40qE6QrrhRcyPUoZQ5CkEOgvIKb11BryO69clqDYbQJX6Mi38Xp+FIFawTRkDJWVzf0iprNewehbk4YDxhCR87JEdlxXzCF4oJPtqK382sAkMBQRrWweXBBFxC+Q/55MIb/xMDitQez0dLeJLbYCv6V4FHW0CnFGbQ8gmiTcQWX+A/4NDnfhXvIXYHBmTmVubLVF1VfEFbQHkkpjBsPCRs0cPUQYOeagMjHNZ2/Q2KnXDJWRIUyDolgGhSBsHikIDqsZWQGOWj1kkQWxffYbLGI2Z88NF/J53flcAXrZyDALqyJgnszuoYpnnA/fKbFSG8yo2iUzPGwhMoGd3fvO5HO8y/NHIAnHt8nWqNqF0D5Y0uUmFIYUg1XIlqCyEvmPORmzFzN73wtd2cona+hzSR0zFSCw14Ur3Lf0E3AxBQbFiGZ8Ca4gv3GAiencuYxOqquR4ZBbYQEvGBXNrtoL4cOZax5GA6/AzLExmMtNFX6nUKnM7rhVkuadQvqU1wqzY/YbOof1zrWfuP889I0KhIKS96RYTjIsTAfIMzctZnQpHlNr6nLIBY5JGmT19cZ+ptDZyizmYgwtyrw+GGaRNzQ7oJldU81fgD41dV7604Z671ieQDtS2U/piJj5pkoBYUoVHjoFQ30GlRDO27hwWNaHnUQJdyB33sBwdG+ckHz/9SswbeoXbPYKhef0KXIGoU+Q909G/ihcoXfVVjAA8IWCpy2gNRoL8+nl07JJLJhGrjlDVIq8tYGJKRbnLuqHveCa3EMuPUc/Od5AfT7D0uXMSOggaoeUfhAlg7QHojyzuaiwK+xLlHcV1VsWsg6ON8A/qaqECK4UANrIGbxufZhE28rnbTrdNzx/Rs1UsLdNFYEhD/XDRoPKRJTdo5ono4Bh4WMnh4XmZZg2vXtYgKbfgK20ZTPAy0tA/9FvaQ2iHsCrkBt7vcTOUIxT0lmjC1eVqeTWeSZYLW2WbGScYf7DwNwyqQ1QmTlDJKV4g3sEjVmbFTdlkluCCl1X1fw8lkWfSak8xuXaszmWZcMZWpahDLEJOibT4WHOTMZyE0tLC8GsJkJj7k0QEXQsTy+JjQ1BWz+lCCOezndKMIS/pewMe1B0rTvMl4/aukLJ+yp97Nay3qswtJDKNMPazzHTq16j1jUtHdg++HPEAcw5xdyHZ863ng5tquyDZT8Xx1pjjhvXC8XOhPZGNbcZ8gWB5IAn3HjFSZYxhgDWG+2B5bSgTDCZuuF7MmAYyEMlKuT5SG2znGePbaHVwoGF58pBhVLVmtFgOFyAVBXgPFflU0uimdhK/62RXGw4QyvjmTYRFR7mzdQpbQd74W42/e8b/1aTOsHCIGyIcehk5qq1eSBsGmNQDt2yJQbjyvspMUaSRD8LW+lqxDaWWpmFO7qPGUMWYcjZkPahyCuBMnXafn8aC02qhYWPeOfyOvKY+1E1pbCdBjza0jZRlFgkKmN6XZzRyFqhaxHjtAWyHtBtKOk6EjFJfd6gg4LADKkPvTlj4NJtmObs/NzYGsFSFBcCizQW4fSSxWLJYuEvv91JjWnzpgxdBqLPjD3tu4w0dr6yowwCoBdkHSRI/hUqNxD0Kk9oLtpiq21NbDE3TqqLC59WyZtGNU1VlYzis/fVU5rzpmmIzdw7fR5re7oy9MzGatq2panOavHLtYlXw6suowk39W5TjKKoBYei4YoGcMEjuWymX2Rt6iICitWurz/a1EFKi9rtSmZsZo0t6NZkMfiO3f2dQPGQvV2Pt3yvWE7DW9WAQ8zApNscoOZDFWKbmpjvxoQoXF3NcExpXe1it9ArWpQzut4arWT1IEgOnzH1qlC0lyKUOwKLanGxlNauSnrGxZz2VMa+NBgTgJnxq21jYkyqxlyv60pY68uCie2vEfqErihMQ+gVtBs62Sc1BhcAhKta4M33SGY6dmNmPWbh3uXLcUP20THDpgCkrHvj0hfcq+qa24a9389bfNrXpXQQltWO+zFIbC6fWJJs7UNNiFUEIDORgqaotMZwMoewEsJyozJ3oVbyuJZSbZucZktTj/WKOOqfTff8XfSVpQwvFryOiCeDIXHiMsldC3EGbJ6y2SeNdJDl4nwFEz/K+PKyB+bm1M2k5eKsNkNzaGrr7JkZ7rbpMR+z3Aopulbrbspo94fu7Id0XYHVqclfSmrPfD7E/LthCe7kS2qgUIeKjOv087a077ZkkKuORUwK+tDUG/P+PEFzz57WPr/eZKDt1uztMvOt0VQsLnahbwZ5XpB+3gbFXcubDLVOhDJFnyp9C3p9Gk2JwOOlsuaYCF7vHgy8/hGGG2wPGyTQV/sG3StFn+/Uxz1MyxO4z71Yz1shdbmLXcpjp943Fy/LTnrcstVAiLiSOcxceuJLbzO0l+Jvdw3GQh1+c8kEvbmgPLqvZ243cfik8A09Zk2+T+MrT+wr7ORFyy0RmfkQghUfs9uIwBDib/P4a/jEL3e+cOAM52772hDOa6fyxp5v3Sv1GbUYR0LF2c24OWjQnAtjKNTT3F4IyTdxHFWf8aA3jkDYT2sz7rUsuYDuzErthKVgNaFg3NcjbvOU7d7Wi4T9181o8CupbMMcpa1aMSNAGh/f36hUSU9FsuWm4jrmMKM51GQsQ1HMN4aaM4ktVe9+BSV7rpZrHN0hyheBW8xjFNvBDiLiyg2fHcO7r2v04pkf10YdajhZqD/hCv0tHFVGObS05V0c8fd7iUh3vtJLHxXRXb1zONqeTjWscoZMlNYeC0vDpnp0CuBs+V6nZIg+Mtqt7lxuHZ3c4mRk+9/NBRfck7JIcOxKMEevo83vBKtr6ZNDsLBva5HFuGjB+L59wt/7G7AC4UBbH582uxz/Gku3/baF/JW1t2/K35idqdRgHcfx1v7tXQm9VLpr4njjHrXmaAYW+m2G7dfOl3XL6VwN07vwATZVhkxb/PLBpztf8iySKEOyE0ijqjNuW+dbDW63WmW8IeqnY0+gEljSr1v+/ZZalkVooubKTkgHGfSUm5c/610OkfPy3GCNmtnyUV1V7RbCWjWjjHgwv3mdHT+f19VOp4VAGRd/NMo/xgIBfoYQENWbXk0LtV6mHzjeXlnDhSECas5h1HNvCOabnPieLvFOlcjLd4IjTRRqV+aSf+vqLGkrZzgBVJu7qY2DmryYWTKGd9p5Y1UthMPlfF0qqeC2M6YiWYYAvMjRGCuVt/cM5yHc23wto7wUtNHs91HlEvPmjO+PKgbg2XcicBQ53ydzPP0I3dF4ZYjyFa+l9t0yzBZCFd5ehuPGYoxye/5tT6V8bF863vR7AdJGBmrLnAUp91nsTO5lNI4nDqHCUnIJZtWMuahuaQx3Wz9tdVLv6AWtxKLquG43XHNvI824sRjYrhD3691mvvKhBvIP53Te3MKjLQW3xhBJF6nb3pyaw7jRCDRzn58cSyq6Pm4V3vRdFu6hSsJgWre46QJcjtXAKGzX7owl4M2mOm8XHeCrX07MOEZNeCgjrE2PxYSympszbn0i0vUxpEbwpTbddFr3lfx+bQ9303PRxIlnPwv2ypQisLWvD67UnhkjQVcEZX/OfpolkK8ZCrsnS7ZfyG0+5QfkldvOWUJcnw/VGRkK1icv+cmgYnoumgh8UpJZrb62TeE1Q+2L+GLhbtyHQ3Rn+oPKdnbPO20+zOFHcAPvSJJkpnS3mdDs+uVu94Xm7a/0DLDpfO3BI6qJrvmKIRszMxfLdRmqjGcDvcRxbL2RjsCfllh6/rnhYQpYMutZN5G6dZ3cn8MLFvG2CA3b9mw7Ie221ziWHzbrL43TeWB6FiEYpbOf36Ko30jpk/Dc04lF5k5wH1+9/w4dmh7M+sdbBYvlRZfmLxIAu9mF4W239EFwz+B0oA80m+392sYvQeuL8+Mc4N/IvQ9OG8Bm2LpC/QoPLumli5jCv1GS5sfxAIMuNxWR7tVufg/OhSH6luEuTQzDsIs7lwwHDkG1kcDc0eEJmq2ihxmWOQQANfeErz/OYfsiekbged1tpiBTNR85rVLzkSjbQXpndjbM81Zfhx6D2x4qElabnWE+sHU+tk1yX0HyM0CAt929gho9QRvcy7WxxZdgfHkzC/Pd4nL58RG5NG/T5RU6XoDutky5G9VlDhfKT+dAa0QgvtYzLpZbSqtea+24n0hpFf3U42pe8DDvXUWzsGL/j1K64ZG7/VMHpxGbVzpB+Ihxx+/52M6y5NspnvBwpomBHM57TsQ9BOeWIZIthKJ5uHOymkq0+QpntN1Adqk9EWUheOqDXty1dTfnbim9A3viq9Bms29k4xF1U1xbBvQSNbUvoeXnsWkLYSWtA4S9j3Yx/uSx1R+qjtELmcIPcC99TzGbvEoy+CP/dh8v+kDo07mtd/3yebGepN8L5ApLEw0FpOurdtePWHE+NTSGL2cNz2inx1gTHAtdwiMh074yb3EuXShs9M8iab3iQ2aOCJupRFqcb5Wraq5K00S4tlyeHLpFaX5h24MXe7LFGcw65FfuZC0FTJPuYq0yJCn7TKWj0pctt/RFn9kV1wv/mqGwlMVRbHdGo3qrSfJ60VVOk30df9Bk9uMuv8SafmIoaERyRmNe5QCrpkNKSmlJQlWSV7canWh6s2VxVuzoRynliB3JOf4xbUyEsNo0ktQYVnVnmkiRvVSIf0KcCclXjy7cZJI9uJ3dljhpXR3i7+ry4sF7gVT3Z2iqUH5qVh/QrZqGPB7SapKr/rVR/VU48fpmwb0vgRQ8mHlpyXLezc03URWL/M6Gi7iyEvLIaUhgX77mwwEFTRasb04x0+Lvc7xbW/hxiudfI9h20h8HPpoab1/gCO+v0SkCAX+qBVkQDebuCL4NWi/UP2ypryJh+6J6ZgDueumPjPWu0bTXeKTFDfSRUOE/GOCSRVzW6+YwOFaWQH9ey182e2H7yxucnkZKheKn2c5KdoXNU3uFZ4FRC230I2VoDafZvGRUcQ2FCv0Peuw3YsuPg37dXPAETsrzwc8NVbOSjrcE/CcIcnqxsHH04uEqvFZ43BNtX+qRjnfRSoUg7MsHO0U0GnGhXqT66/oyn9DZ4NHwYJk5w6Xt11mp10XdeA+sqT11hmzN4iAq/xkJPcEtpaj9xrbt6JCtcQvw5zHJHHDLXAqr79ZW1yaS/7qlmG+gtbbU2PTQfR1SafE2iKQ8+4+YiBuIa5t3AodkVa2Xfb/Z7/ebfrlcV6Vl5OwT6/AinV1/Am1HM1H6BNMJti+ZFv0ZFlq/rVpKLIsEtK62h/7p08zfeOONN95444033njjjTfeeOONN95444033njjjTfeeOONf43/AR5QlDZ3bOGBAAAAAElFTkSuQmCC'),
                              ),
                              CircleAvatar(
                                radius: 7,
                                backgroundColor: Colors.green,
                              )
                            ],
                          )

                        ]
                      )
);

Widget buildChatItem() =>  Row(
  children: [
    Stack(
      alignment: AlignmentDirectional.bottomEnd,
      children: [
        CircleAvatar(
          radius: 30,
          backgroundImage: NetworkImage(
              'data:image/png;base64,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'),
        ),
        CircleAvatar(
          radius: 7,
          backgroundColor: Colors.green,
        )
      ],
    ),
    SizedBox(
      width: 10,
    ),
    Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'karim Samy Mylad',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Text('Hello Karim'),
              SizedBox(
                width: 5,
              ),
              Container(
                height: 5,
                width: 5,
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: Colors.blue),
              ),
              SizedBox(
                width: 5,
              ),
              Text('03:00 pm'),
            ],
          )
        ],
      ),
    ),
  ],
);
}
