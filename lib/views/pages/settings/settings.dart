

import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:ltr/controller/global/globalValues.dart';
import 'package:ltr/views/components/common/common.dart';
import 'package:ltr/views/pages/number/favnumber.dart';
import 'package:ltr/views/pages/number/globalprize.dart';
import 'package:ltr/views/pages/number/globalsalescommission.dart';
import 'package:ltr/views/pages/settings/gameSettings.dart';
import 'package:ltr/views/pages/number/gamelist.dart';
import 'package:ltr/views/pages/number/globalcount.dart';
import 'package:ltr/views/pages/number/numbercount.dart';
import 'package:ltr/views/pages/settings/blockedusers.dart';
import 'package:ltr/views/pages/settings/emergency.dart';
import 'package:ltr/views/pages/settings/gametime.dart';
import 'package:ltr/views/pages/settings/lockedusers.dart';
import 'package:ltr/views/styles/colors.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _ReportsState();
}

class _ReportsState extends State<Settings> {

  //Global
  var g = Global();

  //Page Variable
  var settingsList = [];

  @override
  void initState() {
    // TODO: implement initState
    fnGetPageData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: MediaQuery.of(context).padding,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 13,horizontal: 10),
              decoration: boxDecoration(g.wstrGameBColor, 0),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Container(
                      //decoration: boxBaseDecoration(greyLight,10),
                      padding: const EdgeInsets.all(5),
                      child: const Icon(Icons.arrow_back_ios_rounded,color: Colors.white,size: 20,),
                    ),
                  ),
                  gapWC(5),
                  tcn("Settings", Colors.white, 20)
                ],
              ),
            ),
            gapHC(15),
            Expanded(child: Container(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: wReportList(),
              ),
            ))
          ],
        ),
      ),
    );
  }

  //===============================WIDGET

  List<Widget> wReportList(){
    List<Widget> rtnList = [];
    for(var e in settingsList){
      rtnList.add(Bounce(
        onPressed: (){
          if(e["CODE"] == 001){
            Navigator.push(context, MaterialPageRoute(builder: (context) =>   const EmergencySettings()));
          }else if(e["CODE"] == 002){
            Navigator.push(context, MaterialPageRoute(builder: (context) =>   const GameSettings()));
          }else if(e["CODE"] == 003){
            Navigator.push(context, MaterialPageRoute(builder: (context) =>   const LockedUsers()));
          }else if(e["CODE"] == 004){
            Navigator.push(context, MaterialPageRoute(builder: (context) =>   const GlobalPrize()));
          }else if(e["CODE"] == 005){
            Navigator.push(context, MaterialPageRoute(builder: (context) =>   const GlobalSalesRate()));
          }else if(e["CODE"] == 006){
            Navigator.push(context, MaterialPageRoute(builder: (context) =>   const GlobalPrize()));
          }else if(e["CODE"] == 007){
            Navigator.push(context, MaterialPageRoute(builder: (context) =>   const FavNumber()));
          }
          else if(e["CODE"] == 008){
            Navigator.push(context, MaterialPageRoute(builder: (context) =>   const GlobalGameCount()));
          }
          else if(e["CODE"] == 009){
            Navigator.push(context, MaterialPageRoute(builder: (context) =>   const NumberCount()));
          }
          else if(e["CODE"] == 010){
            Navigator.push(context, MaterialPageRoute(builder: (context) =>   const GameTimeSettings()));
          }
        },
        duration: const Duration(milliseconds: 110),
        child: Container(
          margin: const EdgeInsets.only(bottom: 5),
          decoration: boxDecoration(Colors.white, 10),
          padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(e["ICON"],color: Colors.black,size: 20,),
                  gapWC(10),
                  tcn(e["NAME"], Colors.black , 15)
                ],
              ),
              const Icon(Icons.navigate_next_sharp,color: Colors.black,size: 20,),
            ],
          ),
        ),
      ));
    }

    return rtnList;
  }

  //===============================PAGE FN

  fnGetPageData(){
    if(mounted){
      setState(() {
        settingsList = [
          {
            "CODE":001,
            "NAME":"Emergency Settings",
            "ICON":Icons.warning_amber_outlined
          },
          {
            "CODE":010,
            "NAME":"Game Time Settings",
            "ICON":Icons.access_time_rounded
          },
          {
            "CODE":002,
            "NAME":"Games Settings",
            "ICON":Icons.token_outlined
          },
          {
            "CODE":003,
            "NAME":"Locked Users",
            "ICON":Icons.lock
          },
          {
            "CODE":004,
            "NAME":"Prize and commission",
            "ICON":Icons.price_change_outlined
          },
          {
            "CODE":005,
            "NAME":"Ticket Prize",
            "ICON":Icons.currency_rupee
          },

          {
            "CODE":006,
            "NAME":"Sales commission",
            "ICON":Icons.currency_rupee
          },

          {
            "CODE":007,
            "NAME":"Favorite Number",
            "ICON":Icons.favorite_border
          },
          {
            "CODE":008,
            "NAME":"Global Count Limit",
            "ICON":Icons.format_list_numbered_rounded
          },
          {
            "CODE":009,
            "NAME":"Global Number Count",
            "ICON":Icons.numbers_sharp
          },
        ];
      });
    }
  }

//===============================API CALL



}
