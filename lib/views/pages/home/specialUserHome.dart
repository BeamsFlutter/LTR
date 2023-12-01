
import 'package:flutter/material.dart';
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
import 'package:ltr/views/pages/number/numbercount.dart';
import 'package:ltr/views/pages/payment/paymentDetails.dart';
import 'package:ltr/views/pages/report/report.dart';
import 'package:ltr/views/pages/settings/appUpdate.dart';
import 'package:ltr/views/pages/settings/settings.dart';
import 'package:ltr/views/pages/user/currentuserprize.dart';
import 'package:ltr/views/pages/user/currentusersalesrate.dart';
import 'package:ltr/views/pages/user/specialUserList.dart';
import 'package:ltr/views/pages/user/userlist.dart';
import 'package:ltr/views/styles/colors.dart';

import '../number/globalcount.dart';

class SpecialUserHome extends StatefulWidget {
  const SpecialUserHome({Key? key}) : super(key: key);

  @override
  State<SpecialUserHome> createState() => _SpecialHomeState();
}

class _SpecialHomeState extends State<SpecialUserHome> {

  //Global
  var g =  Global();
  var n =  NavigationController();
  var apiCall = ApiCall();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  late Future<dynamic> futureForm;


  //Page Variable
  var frDate = "";
  var fMenu =[];
  var fUserMenu  = [];
  var gameList  = [];


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
                      tcn("SPECIAL", Colors.white, 20),
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
                  children: wMenuList(),
                ),
              ),
            )),
          ],
        ),
      ),
    );
  }

  //===================================WIDGET

  List<Widget> wMenuList(){
    List<Widget> rtnList  = [];
    rtnList.add(Row());

    for(var e in fUserMenu){

      var menuCode  =  (e["MENU_CODE"]??"").toString();
      if(menuCode  == "M01"){
        rtnList.add(wMenuCard('Booking',2));
        rtnList.add(gapHC(5));
      }else if(menuCode  == "M02"){
        rtnList.add(wMenuCard('Reports',9));
        rtnList.add(gapHC(5));
      }else if(menuCode  == "M03"){
        rtnList.add( wMenuCard('Result View',3));
        rtnList.add(gapHC(5));
        rtnList.add(  wMenuCard('Result Publish',12));
        rtnList.add(gapHC(5));
      }

    }
    return rtnList;
  }

  Widget wMenuCard(text,nav){

    return GestureDetector(
      onTap: (){

        if(nav == 2){
          //apiValidateGame();
          Navigator.push(context, MaterialPageRoute(builder: (context) =>   const Booking()));

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


      apiGetMenuList();

    }
  }



 //===================================API CALL

  apiGetMenuList(){
    futureForm = apiCall.apiGetUserDetails(g.wstrCompany, g.wstrUserCd, "USERDET", "");
    futureForm.then((value) => apiGetMenuListRes(value));
  }
  apiGetMenuListRes(value){
    if(mounted){
      if(g.fnValCheck(value)){
        setState(() {
          fUserMenu = value["USERMENU"]??[];
        });
        apiGetGameList();
      }
    }
  }

  apiGetGameList(){
    //api for get user wise game list
    futureForm = apiCall.apiGetUserGames(g.wstrCompany, g.wstrUserCd, "");
    futureForm.then((value) => apiGetGameListRes(value));
  }
  apiGetGameListRes(value){
    if(mounted){
      setState(() {
        gameList = [];
        if(g.fnValCheck(value)){
          gameList = value;
          var e = gameList[0];
          var code = g.mfnTxt(e["CODE"]);
          var name = g.mfnTxt(e["DESCP"]);
          var link = g.mfnTxt(e["LIVE_LINK"]);
          var editTime = g.mfnTxt(e["EDIT_MINUT"]);
          var end = g.mfnTxt(e["END_TIME"]);

          var colorCode  =  g.mfnTxt(e["CODE"]);
          // var color  =  colorCode == "1PM"?Colors.blueAccent:colorCode == "3PM"?Colors.amber:colorCode == "6PM"?Colors.green:colorCode == "8PM"?Colors.redAccent:Colors.amber;
          var color  =  colorCode == "1PM"?oneColor:colorCode == "3PM"?threeColor:colorCode == "6PM"?sixColor:colorCode == "8PM"?eightColor:Colors.amber;
          var bcolor  =  colorCode == "1PM"?oneButtonColor:colorCode == "3PM"?threeButtonColor:colorCode == "6PM"?sixButtonColor:colorCode == "8PM"?eightButtonColor:Colors.amber;
          var tcolor  =  colorCode == "1PM"?oneTextColor:colorCode == "3PM"?threeTextColor:colorCode == "6PM"?sixTextColor:colorCode == "8PM"?eightTextColor:Colors.amber;
          var otcolor  =  colorCode == "1PM"?oneOnTextColor:colorCode == "3PM"?threeOnTextColor:colorCode == "6PM"?sixOnTextColor:colorCode == "8PM"?eightOnTextColor:Colors.amber;


          g.wstrSelectedGame = code;
          g.wstrSelectedGameName = name;
          g.wstrGameColor = color;
          g.wstrGameBColor = bcolor;
          g.wstrGameTColor = tcolor;
          g.wstrGameOTColor = otcolor;
          g.wstrSGameLink = link;
          g.wstrSGameEdit = editTime;
          g.wstrSGameEnd = end;
        }
      });
    }
  }


}
