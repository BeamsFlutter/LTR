

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:ltr/controller/global/globalValues.dart';
import 'package:ltr/services/apiController.dart';
import 'package:ltr/views/components/common/common.dart';
import 'package:ltr/views/styles/colors.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class Results extends StatefulWidget {
  const Results({Key? key}) : super(key: key);

  @override
  State<Results> createState() => _ResultsState();
}
enum Menu { itemOne, itemTwo, itemThree, itemFour }
class _ResultsState extends State<Results> {
  
  //Global
  var g =  Global();
  var apiCall = ApiCall();
  late Future<dynamic> futureForm;
  
  //Page Variable
  var frResultData = [];
  var fResDate = DateTime.now();
  var fLiveLink  = "";

  var frGameList = [];
  var fGame = "";

  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fnGetPageData();
  }
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: MediaQuery.of(context).padding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 13,horizontal: 10),
              decoration: boxDecoration(g.wstrGameBColor, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: (){
                          Navigator.pop(context);
                        },
                        child: Container(
                          decoration: boxBaseDecoration(Colors.white,10),
                          padding: const EdgeInsets.all(5),
                          child: const Icon(Icons.arrow_back,color: Colors.black,size: 20,),
                        ),
                      ),
                      gapWC(5),
                      tcn("Results (${fGame.toString()})", Colors.white, 20)
                    ],
                  ),
                  GestureDetector(
                    onTap: (){
                      fnShare();
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 5),
                      decoration: boxDecoration(Colors.white, 30),
                      child: Row(
                        children: [
                          tcn('Share', grey, 15),
                          gapWC(5),
                          const Icon(Icons.share_outlined,color: grey,size: 15,)
                        ],
                      ),
                    ),
                  )

                ],
              ),
            ),
            gapHC(5),
            // Row(
            //   children: [
            //     gapWC(10),
            //     tcn('Last published date $today', grey, 10),
            //   ],
            // ),
            Row(
              children: [
                Expanded(
                  child: PopupMenuButton<Menu>(
                    position: PopupMenuPosition.under,
                    tooltip: "",
                    onSelected: (Menu item) {

                    },
                    shape:  RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    itemBuilder: (BuildContext context) => <PopupMenuEntry<Menu>>[
                      PopupMenuItem<Menu>(
                        value: Menu.itemOne,
                        padding: const EdgeInsets.symmetric(vertical: 0,horizontal: 0),
                        child: wGamePopup(),
                      ),
                    ],
                    child:   Container(
                      margin:const  EdgeInsets.symmetric(horizontal: 5),
                      padding: const EdgeInsets.all(10),
                      decoration: boxOutlineCustom1(Colors.white, 5, Colors.black, 1.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              tcn('Select Game ', Colors.black, 10),
                              tc(fGame.toString(), Colors.black, 13),
                            ],
                          ),
                          const Icon(Icons.search,color: Colors.grey,size: 18,)
                        ],
                      ),
                    ),
                  ),
                )

              ],
            ),
            gapHC(2),
            GestureDetector(
              onTap: (){
                _selectResultDate(context);
              },
              child: Container(
                margin: const EdgeInsets.all(5),
                padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                decoration: boxDecoration(Colors.white, 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.calendar_month,color: grey,size: 18,),
                        gapWC(5),
                        tcn('Choose Date', grey, 15),
                      ],
                    ),
                    tcn(setDate(6, fResDate).toString(), Colors.black, 15)
                  ],
                ),
              ),
            ),
            Expanded(
                child: Container(
                  padding: const EdgeInsets.all(5),
                  child: SingleChildScrollView(
                    child: Column(children: [
                      wResultCard(1,Colors.amber.withOpacity(0.5)),
                      wResultCard(2,Colors.red.withOpacity(0.5)),
                      wResultCard(3,Colors.green.withOpacity(0.5)),
                      wResultCard(4,Colors.orange.withOpacity(0.5)),
                      wResultCard(5,Colors.blue.withOpacity(0.5)),
                      gapHC(5),
                      tcn('COMPLIMENTS', Colors.black, 13),
                      gapHC(5),
                      Row(
                        children: [
                          w30Card(6),
                          gapWC(3),
                          w30Card(7),
                          gapWC(3),
                          w30Card(8),

                        ],
                      ),
                      gapHC(3),
                      Row(
                        children: [
                          w30Card(9),
                          gapWC(3),
                          w30Card(10),
                          gapWC(3),
                          w30Card(11),
                        ],
                      ),
                      gapHC(3),
                      Row(
                        children: [
                          w30Card(12),
                          gapWC(3),
                          w30Card(13),
                          gapWC(3),
                          w30Card(14),
                        ],
                      ),
                      gapHC(3),
                      Row(
                        children: [
                          w30Card(15),
                          gapWC(3),
                          w30Card(16),
                          gapWC(3),
                          w30Card(17),
                        ],
                      ),
                      gapHC(3),
                      Row(
                        children: [
                          w30Card(18),
                          gapWC(3),
                          w30Card(19),
                          gapWC(3),
                          w30Card(20),
                        ],
                      ),
                      gapHC(3),
                      Row(
                        children: [

                          w30Card(21),
                          gapWC(3),
                          w30Card(22),
                          gapWC(3),
                          w30Card(23),
                        ],
                      ),
                      gapHC(3),
                      Row(
                        children: [
                          w30Card(24),
                          gapWC(3),
                          w30Card(25),
                          gapWC(3),
                          w30Card(26),
                        ],
                      ),
                      gapHC(3),
                      Row(
                        children: [
                          w30Card(27),
                          gapWC(3),
                          w30Card(28),
                          gapWC(3),
                          w30Card(29),
                        ],
                      ),
                      gapHC(3),
                      Row(
                        children: [
                          w30Card(31),
                          gapWC(3),
                          w30Card(31),
                          gapWC(3),
                          w30Card(32),
                        ],
                      ),
                      gapHC(3),
                      Row(
                        children: [
                          w30Card(33),
                          gapWC(3),
                          w30Card(34),
                          gapWC(3),
                          w30Card(35),
                        ],
                      )

                    ],),
                  ),
                )
            ),
            Bounce(
              onPressed: () async{
                await _launchURL();
              },
              duration: const Duration(milliseconds: 110),
              child: Container(
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                decoration: boxDecoration(Colors.redAccent, 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    tcn('Live Result', Colors.white, 18),
                    gapWC(5),
                    const Icon(Icons.live_tv_outlined,color: Colors.white,size: 18,)
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  //=================================================WIDGET
    Widget wResultCard(pos,color){
    var num = fnGetNumber(pos);
      return Container(
        decoration: boxBaseDecoration(color , 1),
        padding: const EdgeInsets.all(5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                tcn(pos.toString(), Colors.black, 15)
              ],
            ),),
            gapWC(10),
            tcn(':', Colors.black, 15),
            gapWC(10),
            Expanded(child: tc(num.toString(), Colors.black, 15))
          ],
        ),
      );
    }
    Widget w30Card(pos){
    var num = fnGetNumber(pos);
      return Expanded(child:
      Container(
        padding: const EdgeInsets.all(4),
        decoration: boxBaseDecoration(Colors.blueGrey.withOpacity(0.1 ), 0),
        child: Center(
          child: tc(num.toString(), Colors.black, 15),
        ),
      ));
    }

  Widget wGamePopup(){
    return Container(
      width: 200,
      decoration: boxBaseDecoration(Colors.white, 0),
      padding: const EdgeInsets.only(left: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: wBranchCard(),
      ),
    );
  }
  List<Widget> wBranchCard(){
    List<Widget> rtnList  =  [];
    for(var e in frGameList){
      var colorCode = (e["CODE"]??"").toString();
      var color  =  colorCode == "1PM"?oneColor:colorCode == "3PM"?threeColor:colorCode == "6PM"?sixColor:colorCode == "8PM"?eightColor:Colors.amber;

      rtnList.add(GestureDetector(
        onTap: (){
          Navigator.pop(context);
          setState(() {
            fGame = (e["CODE"]??"").toString();
          });
          apiGetResultData();
        },
        child: Container(
          decoration: boxBaseDecoration(color, 5),
          padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 5),
          margin: const EdgeInsets.only(bottom: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.confirmation_num,color:Colors.white,size: 15,),
              gapWC(5),
              tcn((e["CODE"]??"").toString(), Colors.white, 15)
            ],
          ),
        ),
      ));
    }

    return rtnList;
  }
  //=================================================PAGE FN

  fnGetPageData(){
    if(mounted){
      setState(() {
        fGame = g.wstrSelectedGame;
        fLiveLink = g.wstrSGameLink;
      });

      apiGetGameList();
      apiGetResultData();
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
    apiGetResultData();
  }
  fnFill(){

  }
  fnGetNumber(index){
    var num  = "";
    for(var e in frResultData){
      if(e["RANK"].toString() == (index).toString()){
        num =  (e["NUMBER"]??"").toString();
      }
    }
    return num;
  }
  _launchURL() async {
    var url = fLiveLink;
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }
  fnShare() {


    var result = "";
    var index  = 0;
    var k = 0;
    for(var e in frResultData){
      var num = "";

      if(e["RANK"].toString() == (index+1).toString()){
        num =  (e["NUMBER"]??"").toString();
        if((index)<5){
          result = "$result\n*${index+1}*.$num";
        }else if((index) == 5){
          result = "$result\n \n ";
          result = "${result}*COMPLEMENTS* \n";
          result = "$result $num,";
          k= 1;
        }else{
          if(k == 3){
            k = 1;
            result = "$result \n $num,";
          }else{
            result = "$result $num,";
            k= k+1;
          }

        }

      }

      index= index+1;
    }


    Share.share('*RESULT $fGame* \n ${setDate(6, fResDate)}\n$result');
  }



  //=================================================API CALL

  apiGetResultData(){
    setState(() {
      frResultData = [];
    });
    futureForm =  ApiCall().apiGetLiveResult(fGame, setDate(2, fResDate));
    futureForm.then((value) => apiGetResultDataRes(value));
  }
  apiGetResultDataRes(value){
    if(mounted){
      if(g.fnValCheck(value)){
        var sts = (value["STATUS"]??"").toString();
        var msg = (value["MSG"]??"").toString();
        if(sts == "1"){
          //Result already entered
          var header = (value["HEADER"]?? {});
          var det = (value["DET"]?? {});
          var gameDet = (value["GAME_DET"]?? {});
          setState(() {
             frResultData = det??[];
            // try{
            //   fLiveLink = gameDet[0]["LIVE_LINK"];
            // }catch(e){
            //   fLiveLink = "";
            //   dprint(e);
            // }
          });
          fnFill();
        }else{
          errorMsg(context, "Result not published!");
        }
      }else{
        errorMsg(context, "Result not published!");
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
        frGameList = [];
        if(g.fnValCheck(value)){
          frGameList = value;
        }
      });
    }
  }

}
