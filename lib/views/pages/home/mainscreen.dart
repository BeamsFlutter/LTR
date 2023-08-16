

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:flutter_launcher_icons/xml_templates.dart';
import 'package:get/get.dart';
import 'package:ltr/controller/global/globalValues.dart';
import 'package:ltr/controller/navigation/navigation_controller.dart';
import 'package:ltr/services/MQTTClientManager.dart';
import 'package:ltr/services/apiController.dart';
import 'package:ltr/views/components/common/common.dart';
import 'package:ltr/views/pages/booking/booking.dart';
import 'package:ltr/views/pages/booking/bookingview.dart';
import 'package:ltr/views/pages/booking/publishresult.dart';
import 'package:ltr/views/pages/booking/result.dart';
import 'package:ltr/views/pages/home/countview.dart';
import 'package:ltr/views/pages/number/favnumber.dart';
import 'package:ltr/views/pages/number/gamelist.dart';
import 'package:ltr/views/pages/number/globalcount.dart';
import 'package:ltr/views/pages/number/numbercount.dart';
import 'package:ltr/views/pages/report/report.dart';
import 'package:ltr/views/pages/settings/appUpdate.dart';
import 'package:ltr/views/pages/settings/settings.dart';
import 'package:ltr/views/pages/theme/home_theme.dart';
import 'package:ltr/views/pages/user/createpermissionuser.dart';
import 'package:ltr/views/pages/user/currentuserprize.dart';
import 'package:ltr/views/pages/user/currentusersalesrate.dart';
import 'package:ltr/views/pages/user/specialUserList.dart';
import 'package:ltr/views/pages/user/userlist.dart';
import 'package:ltr/views/pages/user/usersearch.dart';
import 'package:ltr/views/styles/colors.dart';
import 'package:mqtt_client/mqtt_client.dart';

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
  var fResDate = DateTime.now();


  var fStockistCode = "ALL";
  var fDealerCode = "ALL";
  var fAgentCode = "ALL";

  var fTotalCountReport  = [];

  //Game
  var gCountNum = 3;

  var txtNum = TextEditingController();
  var txtCount = TextEditingController();

  var fnNum = FocusNode();
  var fnCount = FocusNode();

  var fMenu =[];

  //===================MQTT
  MQTTClientManager mqttClientManager = MQTTClientManager();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setupMqttClient();

    fnGetPageData();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    mqttClientManager.disconnect();
    super.dispose();
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
                      wMenuCard('Booking Extended',2),
                      wMenuCard('Bill Edit/Delete',13),
                      wMenuCard('Result View',3),
                      wMenuCard('Reports',9),
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
                              // wMenuCard('Games',8),
                              wMenuCard('Game Count',10),
                              wMenuCard('Number Count',5),
                              wMenuCard('Favorite Numbers',6),
                              wMenuCard('Result Publish',12)
                            ],
                          ):gapHC(0),
                        ],
                      ):gapHC(5),
                      // tc('Reports', Colors.black , 14),
                      // gapHC(5),
                      // const Divider(
                      //   thickness: 0.5,
                      //   height: 15,
                      // ),
                      // gapHC(5),
                      // wMenuCard('All Reports',9),
                      // // wMenuCard('Count View',7),
                      tc('Details', Colors.black , 14),
                      gapHC(5),
                      const Divider(
                        thickness: 0.5,
                        height: 15,
                      ),
                      gapHC(5),
                      wMenuCard('Sales Rate',16),
                      wMenuCard('Prize and DC',17),
                      tc('Settings', Colors.black , 14),
                      gapHC(5),
                      const Divider(
                        thickness: 0.5,
                        height: 15,
                      ),
                      gapHC(5),
                      g.wstrUserRole == "ADMIN"?
                      wMenuCard('App Settings',11):gapHC(0),
                      g.wstrUserRole == "ADMIN"?
                      wMenuCard('Special User',19):gapHC(0),
                      wMenuCard('App Update',18),


                    ],
                  ),
                ),
              )),
              Bounce(
                onPressed: (){
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) =>   const HomeTheme()), (route) => false);
                },
                duration: const Duration(milliseconds: 110),
                child: Container(
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
                ),
              )
            ],
          ),

        ),
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
                     tcn("Total Count (${g.wstrSelectedGameName??""})", Colors.white, 20),
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
                                       wButton("ALL",Colors.pink),
                                         gapWC(5),
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
                                       wButton("ALL",bgColorDark),
                                       gapWC(5),
                                       wButton("AB",Colors.green),
                                       gapWC(5),
                                       wButton("BC",Colors.green),
                                       gapWC(5),
                                       wButton("AC",Colors.green),
                                     ],
                                   ),
                                 ):
                                 Expanded(
                                   child: Row(
                                     children: [
                                       wButton("ALL",bgColorDark),
                                       gapWC(5),
                                       wButton("A",Colors.orange),
                                       gapWC(5),
                                       wButton("B",Colors.orange),
                                       gapWC(5),
                                       wButton("C",Colors.orange),
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
                           GestureDetector(
                             onTap: (){
                               _selectResultDate(context);
                             },
                             child: Container(
                               margin: const EdgeInsets.all(5),
                               padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                               decoration: boxBaseDecoration(greyLight, 10),
                               child: Row(
                                 children: [
                                   const Icon(Icons.calendar_month,color: grey,size: 18,),
                                   gapWC(5),
                                   tcn(setDate(6, fResDate).toString(), Colors.black, 14)
                                 ],
                               ),
                             ),
                           ),

                         ],
                       ),
                       Row(
                         children: [
                           (g.wstrUserRole == "ADMIN")?
                           Expanded(child: Bounce(
                             onPressed: (){
                               Navigator.push(context, MaterialPageRoute(builder: (context) =>   UserSearch(pRoleCode: "Stockist", pUserCode: g.wstrUserCd.toString(), pFnCallBack: fnSearchCallBack,pAllYn: "Y")));
                             },
                             duration: const Duration(milliseconds: 110),
                             child: Container(
                               margin:const  EdgeInsets.symmetric(horizontal: 2),
                               padding: const EdgeInsets.all(5),
                               decoration: boxOutlineCustom1(Colors.white, 5, Colors.black, 1.0),
                               child: Row(
                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                 children: [
                                   Row(
                                     children: [
                                       tcn('Stockist ', Colors.black, 10),
                                       tc(fStockistCode.toString(), Colors.black, 13),
                                     ],
                                   ),
                                   const Icon(Icons.search,color: Colors.grey,size: 18,)
                                 ],
                               ),
                             ),
                           )):gapHC(0),
                           ( g.wstrUserRole.toString().toUpperCase() == "STOCKIST")?
                           Expanded(child: Bounce(
                             onPressed: (){

                               if(fStockistCode.isEmpty){
                                 errorMsg(context, "Choose Stockist");
                                 return;
                               }

                               Navigator.push(context, MaterialPageRoute(builder: (context) =>   UserSearch(pRoleCode: "Dealer", pUserCode: fStockistCode, pFnCallBack: fnSearchCallBack,pAllYn: "Y")));

                             },
                             duration: const Duration(milliseconds: 110),
                             child: Container(
                               margin:const  EdgeInsets.symmetric(horizontal: 2),
                               padding: const EdgeInsets.all(5),
                               decoration: boxOutlineCustom1(Colors.white, 5, Colors.black, 1.0),
                               child: Row(
                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                 children: [
                                   Row(
                                     children: [
                                       tcn('Dealer ', Colors.black, 10),
                                       tc(fDealerCode.toString(), Colors.black, 13),
                                     ],
                                   ),
                                   const Icon(Icons.search,color: Colors.grey,size: 18,)
                                 ],
                               ),
                             ),
                           )):gapHC(0),
                           (g.wstrUserRole.toString().toUpperCase() == "DEALER")?
                           Expanded(child: Bounce(
                             onPressed: (){

                               if(fDealerCode.isEmpty){
                                 errorMsg(context, "Choose Dealer");
                                 return;
                               }

                               Navigator.push(context, MaterialPageRoute(builder: (context) =>   UserSearch(pRoleCode: "Agent", pUserCode: fDealerCode, pFnCallBack: fnSearchCallBack,pAllYn: "Y",)));

                             },
                             duration: const Duration(milliseconds: 110),
                             child: Container(
                               margin:const  EdgeInsets.symmetric(horizontal: 2),
                               padding: const EdgeInsets.all(5),
                               decoration: boxOutlineCustom1(Colors.white, 5, Colors.black, 1.0),
                               child: Row(
                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                 children: [
                                   Row(
                                     children: [
                                       tcn('Agent ', Colors.black, 10),
                                       tc(fAgentCode.toString(), Colors.black, 13),
                                     ],
                                   ),
                                   Icon(Icons.search,color: Colors.grey,size: 18,)
                                 ],
                               ),
                             ),
                           )):gapHC(0),
                           gapWC(10),
                           Bounce(
                             onPressed: (){
                               apiCountReport();
                             },
                             duration: const Duration(milliseconds: 110),
                             child: Container(
                               height: 40,
                               padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 40),
                               decoration: boxBaseDecoration(g.wstrGameBColor, 30),
                               child: Center(
                                 child: tcn('Search', g.wstrGameOTColor, 15),
                               ),
                             ),
                           )
                         ],
                       )
                     ],
                   ),
                 ),
                 Expanded(child: Container(
                   decoration: boxDecoration(Colors.white, 10),
                   margin: const EdgeInsets.all(10),
                   child: Column(
                     children: [
                       Row(),
                       Container(
                         decoration: boxBaseDecorationC(Colors.blueGrey, 10,10,0,0),
                         padding: EdgeInsets.all(5),
                         child: Row(
                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                           children: [
                             tc('Count', Colors.white, 12),
                             tc('Total', Colors.white, 12),
                           ],
                         ),
                       ),
                       Container(
                         decoration: boxBaseDecoration(greyLight, 0),
                         padding: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                         child: Row(
                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                           children: [
                             Flexible(
                               flex: 3,
                               child: Row(
                                 children: [
                                   tc('Game', Colors.black, 15),
                                 ],
                               ),
                             ),
                             Flexible(
                               flex: 3,
                               child: Row(
                                 children: [
                                   tc('Number', Colors.black, 15),
                                 ],
                               ),
                             ),
                             Flexible(
                               flex: 2,
                               child: Row(
                                 children: [
                                   tc('Count', Colors.black, 15),
                                 ],
                               ),
                             ),
                             Flexible(
                               flex: 2,
                               child: Row(
                                 children: [
                                   tc('Amount', Colors.black, 15),
                                 ],
                               ),
                             ),
                           ],
                         ),
                       ),
                       Expanded(
                         child: ListView.builder(
                             padding: const EdgeInsets.all(0),
                             physics: const AlwaysScrollableScrollPhysics(),
                             itemCount: fTotalCountReport.length,
                             itemBuilder: (context, index) {
                               var e = fTotalCountReport[index];
                               return  Container(
                                 decoration: boxBaseDecoration(index%2==0?greyLight.withOpacity(0.5):blueLight.withOpacity(0.5), 0),
                                 margin: EdgeInsets.symmetric(vertical: 2),
                                 padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                                 child: Row(
                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                   children: [
                                     Flexible(
                                       flex: 3,
                                       child: Row(
                                         children: [
                                           tcn((e["GAME_TYPE"]??"").toString(), Colors.black, 14),
                                         ],
                                       ),
                                     ),
                                     Flexible(
                                       flex: 3,
                                       child: Row(
                                         children: [
                                           tcn((e["NUMBER"]??"").toString(), Colors.black, 14),
                                         ],
                                       ),
                                     ),
                                     Flexible(
                                       flex: 2,
                                       child: Row(
                                         children: [
                                           tcn((e["COUNT"]??"").toString(), Colors.black, 14),
                                         ],
                                       ),
                                     ),
                                     Flexible(
                                       flex: 2,
                                       child: Row(
                                         children: [
                                           tcn((e["AMT"]??"").toString(), Colors.black, 14),
                                         ],
                                       ),
                                     ),
                                   ],
                                 ),
                               );
                             }

                         ),
                       )
                       // Expanded(child: SingleChildScrollView(
                       //   child: Column(
                       //     children: wNumberList(),
                       //   ),
                       // ))
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
          //apiValidateGame();
          Navigator.push(context, MaterialPageRoute(builder: (context) =>   const Booking()));

        }else if(nav == 3){
          apiCheckResultBlock();

        }else if(nav == 5){
          Navigator.push(context, MaterialPageRoute(builder: (context) =>   const NumberCount()));

        }else if(nav == 6){
          Navigator.push(context, MaterialPageRoute(builder: (context) =>   const FavNumber()));

        } else if(nav == 7){
          Navigator.push(context, MaterialPageRoute(builder: (context) =>   const CountView()));

        } else if(nav == 8){
          Navigator.push(context, MaterialPageRoute(builder: (context) =>   const GameList()));

        } else if(nav == 9){
          apiCheckReportBlock();


        } else if(nav == 10){
          Navigator.push(context, MaterialPageRoute(builder: (context) =>   const GlobalGameCount()));

        } else if(nav == 11){
          Navigator.push(context, MaterialPageRoute(builder: (context) =>   const Settings()));

        } else if(nav == 12){

          Navigator.push(context, MaterialPageRoute(builder: (context) =>   const PublishResult()));

        }else if(nav == 13){
          Navigator.push(context, MaterialPageRoute(builder: (context) =>   const BookingView()));

        }else if(nav == 16){
          Navigator.push(context, MaterialPageRoute(builder: (context) =>   const CurrentUserSalesRate(pUserCode: "")));

        }
        else if(nav == 17){

          Navigator.push(context, MaterialPageRoute(builder: (context) =>   const CurrentUserPrize(pUserCode: "")));

        }

        else if(nav == 18){
          Navigator.push(context, MaterialPageRoute(builder: (context) =>   const AppUpdate()));

        }
        else if(nav == 19){
          Navigator.push(context, MaterialPageRoute(builder: (context) =>  const  SpecialUserList(pRoleCode: 'SPECIAL',)));

        }
        else{
          Navigator.push(context, MaterialPageRoute(builder: (context) =>   UserList(pRoleCode: text,)));

        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Row(
            children: [
              gapWC(10),
              Expanded(
                child: tcn(text.toString(), Colors.black, 16),
              )
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
            fSelectedGame = "ALL";
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
                  text == "ALL"?
                  Icon(Icons.star_border,color:fSelectedGame == text? Colors.white :g.wstrGameTColor,size: 15,):
                  tc(text.toString(),fSelectedGame == text? Colors.white :g.wstrGameTColor, 14)
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
  List<Widget> wNumberList(){
    List<Widget> rtnList =[];
    var srno =1;
    for(var e in fTotalCountReport){
      rtnList.add(
          Container(
            decoration: boxBaseDecoration(srno%2==0?greyLight.withOpacity(0.5):blueLight.withOpacity(0.5), 0),
            margin: EdgeInsets.symmetric(vertical: 2),
            padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  flex: 3,
                  child: Row(
                    children: [
                      tcn((e["GAME_TYPE"]??"").toString(), Colors.black, 14),
                    ],
                  ),
                ),
                Flexible(
                  flex: 3,
                  child: Row(
                    children: [
                      tcn((e["NUMBER"]??"").toString(), Colors.black, 14),
                    ],
                  ),
                ),
                Flexible(
                  flex: 2,
                  child: Row(
                    children: [
                      tcn((e["COUNT"]??"").toString(), Colors.black, 14),
                    ],
                  ),
                ),
                Flexible(
                  flex: 2,
                  child: Row(
                    children: [
                      tcn((e["AMT"]??"").toString(), Colors.black, 14),
                    ],
                  ),
                ),
              ],
            ),
          )
      );
      srno =srno+1;
    }
    return rtnList;
  }

  //===================================PAGE FN

    fnGetPageData(){
      if(mounted){
        var now = DateTime.now();
        setState(() {
          frDate = setDate(6, DateTime.now());
          fMenu = [
            {
              "MENU":"Booking",
              "CODE":"1",
              "PARENT_CODE":"000"
            },
            {
              "MENU":"BOOKING",
              "CODE":"011",
              "PARENT_CODE":"1"
            },
            {
              "MENU":"EDIT/DELETE",
              "CODE":"012",
              "PARENT_CODE":"1"
            },
            {
              "MENU":"RESULT",
              "CODE":"013",
              "PARENT_CODE":"1"
            },
            {
              "MENU":"RESULT PUBLISH",
              "CODE":"014",
              "PARENT_CODE":"1"
            },
            {
              "MENU":"Users",
              "CODE":"2",
              "PARENT_CODE":"000"
            },
            {
              "MENU":"Stockist",
              "CODE":"021",
              "PARENT_CODE":"2"
            },
            {
              "MENU":"Dealer",
              "CODE":"022",
              "PARENT_CODE":"2"
            },
            {
              "MENU":"Agent",
              "CODE":"023",
              "PARENT_CODE":"2"
            },
          ];
        });

        if(g.wstrUserRole.toString().toUpperCase() == "STOCKIST" ){
          setState(() {
            fStockistCode = g.wstrUserCd;
          });
        }else if( g.wstrUserRole.toString().toUpperCase() == "DEALER" ){
          setState(() {
            fDealerCode = g.wstrUserCd;
          });
        }else if( g.wstrUserRole.toString().toUpperCase() == "AGENT" ){
          setState(() {
            fAgentCode = g.wstrUserCd;
          });
        }

      }
    }

    fnGameDetailsFill(){
      if(mounted){
        setState(() {
          frSoldCount = 0;
        });
      }
    }

  fnSearchCallBack(rolecode,usercd){
    if(mounted){
      setState(() {
        if(rolecode == "Stockist"){
          if(fStockistCode != usercd){
            fDealerCode = "";
            fAgentCode = "";
          }
          fStockistCode = usercd;
        }else if(rolecode == "Dealer"){
          if(fDealerCode != usercd){
            fAgentCode = "";
          }
          fDealerCode = usercd;

        }else if(rolecode == "Agent"){
          fAgentCode = usercd;

        }
      });
    }
  }

  Future<void> _selectResultDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: fResDate,
        firstDate: DateTime(2020),
        lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: g.wstrGameColor,
            ),
          ),
          child: child!,
        );
      },
    );


    if (pickedDate != null && pickedDate != fResDate) {
      setState(() {
        fResDate = pickedDate;
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
              var sysTime  =   value[0]["SYS_TIME"];
              var currTime  =   DateTime.now();
                setState(() {
                  g.wstrSGameDocNo = docno;
                  g.wstrSGameDoctype = doctype;
                  g.wstrSGameStart = startTime;
                  g.wstrSGameEnd = endTime;
                  try{
                    g.wstrSysTime = DateTime.parse(sysTime.toString());
                  }catch(e){
                    dprint(e);
                  }
                  g.wstrCurrTime = currTime;
                });
               Navigator.push(context, MaterialPageRoute(builder: (context) =>   const Booking()));
            }else{
              errorMsg(context, msg.toString());
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



  apiCountReport(){


    var stockist = fStockistCode.isEmpty || fStockistCode == "ALL"?null:fStockistCode;
    var dealer = fDealerCode.isEmpty || fDealerCode == "ALL"?null:fDealerCode;
    var agent = fAgentCode.isEmpty || fAgentCode == "ALL"?null:fAgentCode;
    var type = fSelectedGame.isEmpty || fSelectedGame == "ALL"?null:fSelectedGame;
    var number = txtNum.text.isEmpty ?null:txtNum.text;
    var typeList = [];
    if(gCountNum > 0){
      if(fSelectedGame.isEmpty || fSelectedGame == "ALL"){
        if(gCountNum == 3){
          typeList.add({"COL_VAL":"BOX"});
          typeList.add({"COL_VAL":"SUPER"});
        }else  if(gCountNum == 2){
          typeList.add({"COL_VAL":"AB"});
          typeList.add({"COL_VAL":"BC"});
          typeList.add({"COL_VAL":"AC"});
        }else  if(gCountNum == 1){
          typeList.add({"COL_VAL":"A"});
          typeList.add({"COL_VAL":"B"});
          typeList.add({"COL_VAL":"C"});
        }
      }else{
        typeList.add({"COL_VAL":fSelectedGame});
      }
    }

    futureForm =  ApiCall().apiCountReport(g.wstrCompany, setDate(2, fResDate), g.wstrSelectedGame, stockist, dealer, agent, null, number,typeList);
    futureForm.then((value) => apiCountReportRes(value));
  }

  apiCountReportRes(value){
    if(mounted){
      setState(() {
        fTotalCountReport = [];
        if(g.fnValCheck(value)){
          fTotalCountReport =  value;
        }
      });
    }
  }


  apiCheckResultBlock(){
    futureForm = ApiCall().apiCheckAppBlock(g.wstrCompany, "RESULT");
    futureForm.then((value) => apiCheckResultBlockRes(value));
  }
  apiCheckResultBlockRes(value){
    if(mounted){
      dprint("*******************************************");
      dprint(value);
      if(g.fnValCheck(value)){
        // {STATUS: 1, BLOCK_YN: Y, COMPANY: 03, MODE: REPORT, NOTE: , CREATE_DATE: 2023-08-01T23:58:12.183, CREATE_USER: ADM3, REMARK: , USER_COMPANY: 03}
        var sts = value[0]["STATUS"];
        var block = value[0]["BLOCK_YN"];
        if(block != "Y"){
          //Bocked
          Navigator.push(context, MaterialPageRoute(builder: (context) =>   const Results()));

        }else{
          errorMsg(context, "Sorry, Try again Later !!");
        }
      }else{
        Navigator.push(context, MaterialPageRoute(builder: (context) =>   const Results()));

      }

    }
  }


  apiCheckReportBlock(){
    futureForm = ApiCall().apiCheckAppBlock(g.wstrCompany, "REPORT");
    futureForm.then((value) => apiCheckReportBlockRes(value));
  }
  apiCheckReportBlockRes(value){
    if(mounted){
      dprint("*******************************************");
      dprint(value);
      if(g.fnValCheck(value)){
        // {STATUS: 1, BLOCK_YN: Y, COMPANY: 03, MODE: REPORT, NOTE: , CREATE_DATE: 2023-08-01T23:58:12.183, CREATE_USER: ADM3, REMARK: , USER_COMPANY: 03}
        var sts = value[0]["STATUS"];
        var block = value[0]["BLOCK_YN"];
        if(block != "Y"){
          //Bocked
          Navigator.push(context, MaterialPageRoute(builder: (context) =>   const Reports()));
        }else{
          errorMsg(context, "Sorry, Try again Later !!");
        }
      }else{

        Navigator.push(context, MaterialPageRoute(builder: (context) =>   const Reports()));

      }

    }
  }

  //========================================MQTT

  Future<void> setupMqttClient() async {
    await mqttClientManager.connect();
    mqttClientManager.subscribe(g.wstrCompanyMqKey.toString().toLowerCase());
    fnShowListen();
  }

  fnShowListen(){
    mqttClientManager
        .getMessagesStream()!
        .listen((List<MqttReceivedMessage<MqttMessage?>>? c) {
      final recMess = c![0].payload as MqttPublishMessage;
      final pt =
      MqttPublishPayload.bytesToStringAsString(recMess.payload.message);
      dprint('MQTTClient::Message received on topic: <${c[0].topic}> is $pt\n');

      if(mounted){
        dprint("main screen");
        setState(() {
          // g.wstrBaseUrl = (pt??"").toUpperCase();
          // if(g.wstrBaseUrl.toString().isEmpty){
          //   SystemNavigator.pop();
          // }
        });
      }
    });
  }

}
