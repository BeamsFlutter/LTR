

import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:flutter_launcher_icons/xml_templates.dart';
import 'package:get/get.dart';
import 'package:ltr/controller/global/globalValues.dart';
import 'package:ltr/controller/navigation/navigation_controller.dart';
import 'package:ltr/views/components/common/common.dart';
import 'package:ltr/views/pages/booking/booking.dart';
import 'package:ltr/views/pages/booking/result.dart';
import 'package:ltr/views/pages/number/favnumber.dart';
import 'package:ltr/views/pages/number/numbercount.dart';
import 'package:ltr/views/pages/user/userlist.dart';
import 'package:ltr/views/styles/colors.dart';

class CountView extends StatefulWidget {
  const CountView({Key? key}) : super(key: key);

  @override
  State<CountView> createState() => _CountViewState();
}

class _CountViewState extends State<CountView> {


  //Global
  var g =  Global();
  var n =  NavigationController();
  final scaffoldKey = GlobalKey<ScaffoldState>();


  //Page variable
  var frDate = "";
  var frSoldCount = 0;
  var frTimeStatus = "";
  var fSelectedGame = "";

  //Game
  var gCountNum = 3;

  var txtNum = TextEditingController();
  var txtCount = TextEditingController();
  var fnNum = FocusNode();
  var fnCount = FocusNode();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fnGetPageData();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      key: scaffoldKey,
      body: Container(
        margin: MediaQuery.of(context).padding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
              decoration: boxDecorationC(g.wstrGameColor, 0,0,0,0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      tcn(("Result Count").toString(), Colors.white, 20),
                      tc((g.wstrSelectedGameName??"").toString(), Colors.white, 25),

                    ],
                  ),
                  // const Divider(
                  //   height: 10,
                  //   color: Colors.white,
                  //   thickness: 0.2,
                  // ),
                  // Row(
                  //   children: [
                  //     const Icon(Icons.access_time_sharp,color: Colors.white,size: 13,),
                  //     gapWC(5),
                  //     tcn(frDate.toString(), Colors.white, 13)
                  //   ],
                  // ),
                  // Row(
                  //   children: [
                  //     const Icon(Icons.confirmation_num_outlined,color: Colors.white,size: 13,),
                  //     gapWC(5),
                  //     tcn('${frSoldCount.toString()} SOLD', Colors.white, 13)
                  //   ],
                  // ),
                ],
              ),
            ),
            Expanded(
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: boxDecoration(Colors.white, 10),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Row(
                                children: [
                                  wNumberCard(1),
                                  gapWC(5),
                                  wNumberCard(2),
                                  gapWC(5),
                                  wNumberCard(3),
                                ],
                              ),
                              gapWC(10),
                              Expanded(
                                child: Row(
                                  children: [
                                    gCountNum == 3?
                                    Expanded(
                                      child: Row(
                                        children: [
                                          // wButton("BOTH",Colors.red),
                                          //  gapWC(5),
                                          wButton("BOX",Colors.pink),
                                          gapWC(5),
                                          wButton("SUPER",bgColorDark),
                                        ],
                                      ),
                                    ):
                                    gCountNum == 2?
                                    Expanded(
                                      child: Row(
                                        children: [
                                          wButton("AB",Colors.green),
                                          gapWC(5),
                                          wButton("BC",Colors.green),
                                          gapWC(5),
                                          wButton("AC",Colors.green),
                                          gapWC(5),
                                          wButton("ALL",bgColorDark),
                                        ],
                                      ),
                                    ):
                                    Expanded(
                                      child: Row(
                                        children: [
                                          wButton("A",Colors.orange),
                                          gapWC(5),
                                          wButton("B",Colors.orange),
                                          gapWC(5),
                                          wButton("C",Colors.orange),
                                          gapWC(5),
                                          wButton("ALL",bgColorDark),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          gapHC(10),
                          Row(
                            children: [
                              Flexible(
                                child: Container(
                                  height: 40,
                                  padding: const EdgeInsets.symmetric(horizontal: 15),
                                  decoration: boxBaseDecoration(greyLight, 5),
                                  child: TextFormField(
                                    controller: txtNum,
                                    focusNode: fnNum,
                                    maxLength: gCountNum,
                                    inputFormatters: mfnInputFormatters(),
                                    keyboardType: TextInputType.number,
                                    decoration: const InputDecoration(
                                      hintText: 'Num',
                                      counterText: "",
                                      border: InputBorder.none,
                                    ),
                                    onChanged: (val){

                                    },
                                  ),
                                ),
                              ),
                              gapWC(10),
                              Container(
                                margin: EdgeInsets.all(5),
                                padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                                decoration: boxBaseDecoration(greyLight, 10),
                                child: Row(
                                  children: [
                                    const Icon(Icons.calendar_month,color: grey,size: 18,),
                                    gapWC(5),
                                    tcn(frDate.toString(), Colors.black, 14)
                                  ],
                                ),
                              ),
                              gapWC(10),
                              GestureDetector(
                                onTap: (){

                                },
                                child: Container(
                                  height: 40,
                                  padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 20),
                                  decoration: boxBaseDecoration(g.wstrGameBColor, 30),
                                  child: Center(
                                    child: tcn('Search', g.wstrGameOTColor, 15),
                                  ),
                                ),
                              )
                            ],
                          ),

                        ],
                      ),
                    ),
                    Expanded(child: Container(
                      decoration: boxDecoration(Colors.white, 10),
                      margin: EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Row(),
                        ],
                      ),
                    ))
                  ],
                )
            )

          ],
        ),
      ),
    );
  }

  //===================================WIDGET

  Widget wMenuCard(text,nav){

    return GestureDetector(
      onTap: (){

        if(nav == 2){
          Navigator.push(context, MaterialPageRoute(builder: (context) =>   const Booking()));

        }else if(nav == 3){
          Navigator.push(context, MaterialPageRoute(builder: (context) =>   const Results()));

        }else if(nav == 5){
          Navigator.push(context, MaterialPageRoute(builder: (context) =>   const NumberCount()));

        }else if(nav == 6){
          Navigator.push(context, MaterialPageRoute(builder: (context) =>   const FavNumber()));

        } else{
          Navigator.push(context, MaterialPageRoute(builder: (context) =>   UserList(pRoleCode: text,)));

        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Row(
            children: [
              gapWC(10),
              tcn(text.toString(), Colors.black, 16),
            ],
          ),
          const Divider(
            thickness: 0.5,
            height: 15,
          ),
        ],
      ),
    );
  }

  Widget wNumberCard(num){
    return  Bounce(
      onPressed: (){
        if(mounted){
          setState(() {
            gCountNum = num;
            txtNum.clear();
          });
        }
      },
      duration: const Duration(milliseconds: 110),
      child: Container(
        height: 25,
        width: 25,
        alignment: Alignment.center,
        decoration: gCountNum == num?boxBaseDecoration(g.wstrGameBColor, 5):boxOutlineCustom1(Colors.white, 5, g.wstrGameBColor, 1.0),
        child: tc( num.toString(), gCountNum == num?g.wstrGameOTColor:g.wstrGameBColor, 15),
      ),
    );
  }

  Widget wButton(text,color){
    return Flexible(
      child: Bounce(
        onPressed: (){
          //fnButtonPres(text);
          //fnGenerateNumber(text);
          if(mounted){
            setState(() {
              fSelectedGame =text;
            });
          }
        },
        duration: const Duration(milliseconds: 110),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 5),
          decoration: fSelectedGame == text?boxBaseDecoration(g.wstrGameBColor, 5):boxOutlineCustom1(Colors.white, 5, g.wstrGameBColor, 1.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  text == "SUPER"?const Icon(Icons.star_border,color: Colors.white,size: 15,):gapHC(0),
                  text == "SUPER"?gapWC(5):gapHC(0),
                  tc(text.toString(),fSelectedGame == text? Colors.white :g.wstrGameTColor, 14)
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  //===================================PAGE FN

  fnGetPageData(){
    if(mounted){
      var now = DateTime.now();
      setState(() {
        frDate = setDate(6, DateTime.now());
      });
    }
  }

  fnGameDetailsFill(){
    if(mounted){
      setState(() {
        frSoldCount = 0;
      });
    }
  }

  //===================================API CALL

  apiGetGameDetails(){

  }
}
