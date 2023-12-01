

import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:ltr/controller/global/globalValues.dart';
import 'package:ltr/controller/navigation/navigation_controller.dart';
import 'package:ltr/services/apiController.dart';
import 'package:ltr/views/components/common/common.dart';
import 'package:ltr/views/pages/booking/booking.dart';
import 'package:ltr/views/pages/booking/bookingview.dart';
import 'package:ltr/views/pages/booking/othersales.dart';
import 'package:ltr/views/pages/booking/publishresult.dart';
import 'package:ltr/views/pages/booking/result.dart';
import 'package:ltr/views/pages/booking/retailbooking.dart';
import 'package:ltr/views/pages/home/countview.dart';
import 'package:ltr/views/pages/number/favnumber.dart';
import 'package:ltr/views/pages/number/gamelist.dart';
import 'package:ltr/views/pages/number/globalcount.dart';
import 'package:ltr/views/pages/number/numbercount.dart';
import 'package:ltr/views/pages/payment/paymentDetails.dart';
import 'package:ltr/views/pages/report/report.dart';
import 'package:ltr/views/pages/settings/appUpdate.dart';
import 'package:ltr/views/pages/settings/settings.dart';
import 'package:ltr/views/pages/theme/home_theme.dart';
import 'package:ltr/views/pages/user/currentuserprize.dart';
import 'package:ltr/views/pages/user/currentusersalesrate.dart';
import 'package:ltr/views/pages/user/specialUserList.dart';
import 'package:ltr/views/pages/user/userlist.dart';
import 'package:ltr/views/styles/colors.dart';

class SideDrawer extends StatefulWidget {
  const SideDrawer({Key? key}) : super(key: key);

  @override
  _SideDrawerState createState() => _SideDrawerState();
}

class _SideDrawerState extends State<SideDrawer> {

  //Global
  var g = Global();
  var n =  NavigationController();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  late Future<dynamic> futureForm;


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
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
                  //wMenuCard('Booking Extended',2),
                  wMenuCard('Retail Sales',20),
                  // wMenuCard('Other Sales',21),
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
                  tc('Payment & Receipt', Colors.black , 14),
                  gapHC(5),
                  const Divider(
                    thickness: 0.5,
                    height: 15,
                  ),
                  gapHC(5),
                  wMenuCard('Payment & Receipt',22),
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
              decoration: boxBaseDecoration(Colors.black, 30),
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

    );
  }

  //===============================TODO WIDGET
  Widget wMenuCard(text,nav){

    return GestureDetector(
      onTap: (){

        // if(nav != 3 && nav != 9){
        //   //apiValidateGame();
        //   Navigator.pop(context);
        //
        // }

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
        else if(nav == 20){
          Navigator.push(context, MaterialPageRoute(builder: (context) =>   const RetailBooking()));
        }
        else if(nav == 21){
          Navigator.push(context, MaterialPageRoute(builder: (context) =>   const OtherSales()));
        } else if(nav == 22){
          Navigator.push(context, MaterialPageRoute(builder: (context) =>   const PaymentDetails()));
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
  //===============================TODO FUNCTION
  //===============================TODO API CALL
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


}
