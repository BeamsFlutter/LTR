

import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:flutter_launcher_icons/xml_templates.dart';
import 'package:get/get.dart';
import 'package:ltr/controller/global/globalValues.dart';
import 'package:ltr/controller/navigation/navigation_controller.dart';
import 'package:ltr/services/apiController.dart';
import 'package:ltr/views/components/common/common.dart';
import 'package:ltr/views/pages/booking/booking.dart';
import 'package:ltr/views/pages/booking/result.dart';
import 'package:ltr/views/pages/home/countview.dart';
import 'package:ltr/views/pages/number/favnumber.dart';
import 'package:ltr/views/pages/number/gamelist.dart';
import 'package:ltr/views/pages/number/globalcount.dart';
import 'package:ltr/views/pages/number/numbercount.dart';
import 'package:ltr/views/pages/report/report.dart';
import 'package:ltr/views/pages/settings/settings.dart';
import 'package:ltr/views/pages/user/userlist.dart';
import 'package:ltr/views/styles/colors.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {


  //Global
  var g =  Global();
  var n =  NavigationController();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  late Future<dynamic> futureForm;


  //Page variable
  var frDate = "";
  var frSoldCount = 0;
  var frTimeStatus = "";
  var fSelectedGame = "";
  var today = "";

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
      endDrawer: Container(
          margin: MediaQuery.of(context).padding,
          width:size.width * 0.8,
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding:const EdgeInsets.symmetric(vertical: 15,horizontal: 10),
                decoration: boxDecoration(g.wstrGameColor, 0),
                child: Column(
                  children: [
                      Row(
                        children: [
                          const CircleAvatar(
                            backgroundColor: Colors.white,
                            child:  Icon(Icons.person,color: grey,),
                          ),
                          gapWC(10),
                          Expanded(child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              tc((g.wstrUserCd??"").toString(), g.wstrGameOTColor, 15),
                              tc((g.wstrUserRole??"").toString(), g.wstrGameOTColor, 10)
                            ],
                          ))
                        ],
                      ),
                    gapHC(5),
                    const Divider(
                      height: 8,
                      color: Colors.white,
                      thickness: 0.2,
                    ),
                    gapHC(5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            tcn("GAME", Colors.white  , 15),gapWC(5),
                            tc((g.wstrSelectedGameName??"").toString(), Colors.white  , 15)
                          ],
                        ),
                        Bounce(
                          onPressed: (){
                            Navigator.pop(context);
                            Navigator.pop(context);
                          },
                          duration: const Duration(milliseconds: 110),
                          child: Container(
                            decoration: boxBaseDecoration(greyLight, 30),
                            padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 20),
                            child: tcn('Change Game', Colors.black, 13),
                          ),
                        ),
                      ],
                    ),

                  ],
                ),
              ),
              Expanded(child: Container(
                padding: const EdgeInsets.all(10),
                decoration: boxDecoration(Colors.white, 0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      tc('Booking', Colors.black , 14),
                      gapHC(5),
                      const Divider(
                        thickness: 0.5,
                        height: 15,
                      ),
                      gapHC(5),
                      wMenuCard('Booking',2),
                      wMenuCard('Results',3),
                      wMenuCard('Count View',7),
                      g.wstrUserRole != "AGENT"?
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          tc('Users', Colors.black , 14),
                          gapHC(5),
                          const Divider(
                            thickness: 0.5,
                            height: 15,
                          ),
                          g.wstrUserRole == "ADMIN"?
                          wMenuCard('Stockist',4):gapHC(0),
                          (g.wstrUserRole == "ADMIN" || g.wstrUserRole == "STOCKIST")?
                          wMenuCard('Dealer',4):gapHC(0),
                          (g.wstrUserRole == "ADMIN" || g.wstrUserRole == "STOCKIST" || g.wstrUserRole == "DEALER")?
                          wMenuCard('Agent',4):gapHC(0),
                          g.wstrUserRole == "ADMIN"?
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              tc('Global', Colors.black , 14),
                              gapHC(5),
                              const Divider(
                                thickness: 0.5,
                                height: 15,
                              ),
                              wMenuCard('Games',8),
                              wMenuCard('Game Count',10),
                              wMenuCard('Number Count',5),
                              wMenuCard('Favorite Numbers',6),
                            ],
                          ):gapHC(0),
                        ],
                      ):gapHC(5),
                      tc('Reports', Colors.black , 14),
                      gapHC(5),
                      const Divider(
                        thickness: 0.5,
                        height: 15,
                      ),
                      gapHC(5),
                      wMenuCard('All Reports',9),
                      tc('Settings', Colors.black , 14),
                      gapHC(5),
                      const Divider(
                        thickness: 0.5,
                        height: 15,
                      ),
                      gapHC(5),
                      wMenuCard('App Settings',11),
                      wMenuCard('Update',4),


                    ],
                  ),
                ),
              )),
              Container(
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                decoration: boxBaseDecoration(grey, 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.power_settings_new,color: Colors.white,size: 18,),
                    gapWC(10),
                    tcn('Exit', Colors.white, 18)
                  ],
                ),
              )
            ],
          ),

        ),
      body: Container(
        //padding: MediaQuery.of(context).padding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
           Container(
             padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
             decoration: boxDecorationC(g.wstrGameColor, 0,0,0,0),
             child: Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 gapHC(25),
                 Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                     tc((g.wstrSelectedGameName??"").toString(), Colors.white, 25),
                     GestureDetector(
                       onTap: (){
                         scaffoldKey.currentState?.openEndDrawer();
                       },
                       child: const Icon(Icons.segment,color: Colors.white,size: 30,),
                     ),
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
          apiValidateGame();
         // Navigator.push(context, MaterialPageRoute(builder: (context) =>   const Booking()));

        }else if(nav == 3){
          Navigator.push(context, MaterialPageRoute(builder: (context) =>   const Results()));

        }else if(nav == 5){
          Navigator.push(context, MaterialPageRoute(builder: (context) =>   const NumberCount()));

        }else if(nav == 6){
          Navigator.push(context, MaterialPageRoute(builder: (context) =>   const FavNumber()));

        } else if(nav == 7){
          Navigator.push(context, MaterialPageRoute(builder: (context) =>   const CountView()));

        } else if(nav == 8){
          Navigator.push(context, MaterialPageRoute(builder: (context) =>   const GameList()));

        } else if(nav == 9){
          Navigator.push(context, MaterialPageRoute(builder: (context) =>   const Reports()));

        } else if(nav == 10){
          Navigator.push(context, MaterialPageRoute(builder: (context) =>   const GlobalGameCount()));

        } else if(nav == 11){
          Navigator.push(context, MaterialPageRoute(builder: (context) =>   const Settings()));

        }  else{
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
                  text == "SUPER"?gapWC(5):gapWC(0),
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

    apiValidateGame(){
      futureForm =  ApiCall().apiValidateGame(g.wstrCompany, g.wstrUserCd, g.wstrSelectedGame, setDate(2, DateTime.now()));
      futureForm.then((value) => apiValidateGameRes(value));
    }
    apiValidateGameRes(value){
      if(mounted){
        if(g.fnValCheck(value)){
          try{
            var sts  =  (value[0]["STATUS"]??"").toString();
            var msg  =  value[0]["MSG"];
            if(sts == "1"){
              var docno  =   value[0]["DOCNO"];
              var doctype  =   value[0]["DOCTYPE"];
              var startTime  =   value[0]["START_TIME"];
              var endTime  =   value[0]["END_TIME"];
                setState(() {
                  g.wstrSGameDocNo = docno;
                  g.wstrSGameDoctype = doctype;
                  g.wstrSGameStart = startTime;
                  g.wstrSGameEnd = endTime;
                });
               Navigator.push(context, MaterialPageRoute(builder: (context) =>   const Booking()));
            }else{
              errorMsg(context, "TRY AGAIN");
            }
          }catch(e){
            errorMsg(context, "Booking not active!");
            dprint(e);
          }
        }else{
          Get.back();
          //Navigator.push(context, MaterialPageRoute(builder: (context) =>   const Booking()));
          errorMsg(context, "Booking not active!");
        }
      }

    }

}
