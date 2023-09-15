
import 'package:flutter/material.dart';
import 'package:ltr/controller/global/globalValues.dart';
import 'package:ltr/controller/navigation/navigation_controller.dart';
import 'package:ltr/views/components/common/common.dart';
import 'package:ltr/views/pages/booking/booking.dart';
import 'package:ltr/views/pages/booking/bookingview.dart';
import 'package:ltr/views/pages/booking/othersales.dart';
import 'package:ltr/views/pages/booking/publishresult.dart';
import 'package:ltr/views/pages/booking/retailbooking.dart';
import 'package:ltr/views/pages/home/countview.dart';
import 'package:ltr/views/pages/number/favnumber.dart';
import 'package:ltr/views/pages/number/gamelist.dart';
import 'package:ltr/views/pages/number/numbercount.dart';
import 'package:ltr/views/pages/payment/paymentDetails.dart';
import 'package:ltr/views/pages/report/report.dart';
import 'package:ltr/views/pages/settings/appUpdate.dart';
import 'package:ltr/views/pages/settings/settings.dart';
import 'package:ltr/views/pages/user/currentuserprize.dart';
import 'package:ltr/views/pages/user/currentusersalesrate.dart';
import 'package:ltr/views/pages/user/specialUserList.dart';
import 'package:ltr/views/pages/user/userlist.dart';

import '../number/globalcount.dart';

class SpecialHome extends StatefulWidget {
  const SpecialHome({Key? key}) : super(key: key);

  @override
  State<SpecialHome> createState() => _SpecialHomeState();
}

class _SpecialHomeState extends State<SpecialHome> {

  //Global
  var g =  Global();
  var n =  NavigationController();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  late Future<dynamic> futureForm;


  //Page Variable
  var frDate = "";
  var fMenu =[];


  @override
  void initState() {
    // TODO: implement initState
    fnGetPageData();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: Container(
        margin: MediaQuery.of(context).padding,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
              decoration: boxDecorationC(Colors.black, 0,0,0,0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      tcn("SUPER ADMIN", Colors.white, 20),
                      gapHC(0)
                      // GestureDetector(
                      //   onTap: (){
                      //     scaffoldKey.currentState?.openEndDrawer();
                      //   },
                      //   child: const Icon(Icons.segment,color: Colors.white,size: 30,),
                      // ),
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
                    wMenuCard('Reports',9),
                    gapHC(5),

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
      child: Container(
        decoration: boxDecoration(Colors.white, 10),
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.only(bottom: 5),
        child: Row(
          children: [
            gapWC(10),
            Expanded(
              child: tcn(text.toString(), Colors.black, 16),
            ),
            Icon(Icons.navigate_next,color: Colors.black,size: 15,)
          ],
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

    }
  }
 //===================================API CALL
}
