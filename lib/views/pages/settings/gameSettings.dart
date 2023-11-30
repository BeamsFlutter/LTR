
import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:ltr/controller/global/globalValues.dart';
import 'package:ltr/services/apiController.dart';
import 'package:ltr/views/components/common/common.dart';
import 'package:ltr/views/styles/colors.dart';

class GameSettings extends StatefulWidget {
  const GameSettings({Key? key}) : super(key: key);

  @override
  State<GameSettings> createState() => _GameSettingsState();
}

class _GameSettingsState extends State<GameSettings> {
  
  //Global
  var g = Global();
  var apiCall  = ApiCall();
  late Future<dynamic> futureForm;
  
  //Page Variables
  var gameList = [];
  var selectedList  = [];



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
                      decoration: boxBaseDecoration(Colors.white,10),
                      padding: const EdgeInsets.all(5),
                      child: const Icon(Icons.arrow_back,color: Colors.black,size: 20,),
                    ),
                  ),
                  gapWC(5),
                  tcn("Games", Colors.white, 20)
                ],
              ),
            ),
            gapHC(5),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.all(10),
                decoration: boxDecoration(Colors.white, 10),
                child: Column(
                  children: wGameList(),
                ),
              ),
            ),
            gapHC(5),
          ],
        ),
      ),
    );
  }

  //===========================================WIDGET

    List<Widget> wGameList(){
      List<Widget> rtnList  =  [];
      rtnList.add( Row());
      for(var e in gameList){
        var code = g.mfnTxt(e["CODE"]);
        var name = g.mfnTxt(e["DESCP"]);
        var sts = g.mfnTxt(e["STATUS"]);
        var start = "";
        var colorCode  =  g.mfnTxt(e["CODE"]);
        var color  =  colorCode == "1PM"?oneColor:colorCode == "3PM"?threeColor:colorCode == "6PM"?sixColor:colorCode == "8PM"?eightColor:Colors.amber;

        rtnList.add(wLotCard(color,name,start,e,sts));

      }

      return rtnList;
    }

  Widget wLotCard(color,text,start,e,sts){
    var code = g.mfnTxt(e["CODE"]);
    var name = g.mfnTxt(e["DESCP"]);
    return GestureDetector(
      onTap: (){
        //fnSelectGame(code,name,color);
        if(mounted){
          setState(() {

          });
        }
      },
      child: Container(
        decoration: boxBaseDecoration(selectedList.contains(code)?greyLight:greyLight, 10),
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.only(bottom: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                tcn(text, Colors.black, 30),
                //const Icon(Icons.navigate_next_sharp,color: Colors.white,size: 30,)
                Container(
                  decoration: boxBaseDecoration(Colors.white.withOpacity(0.9), 30),
                  padding: const EdgeInsets.all(5),
                  child: const Center(
                    child: Icon(Icons.navigate_next_outlined,color:Colors.black,size: 15,),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  //===========================================PAGE FN

    fnGetPageData(){
      apiGetGameList();
    }


  //===========================================API CALL

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
          for(var e in gameList){
            var code = g.mfnTxt(e["CODE"]);
            selectedList.add(code);
          }
        }
      });

    }
  }
}
