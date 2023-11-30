
import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:ltr/controller/global/globalValues.dart';
import 'package:ltr/services/apiController.dart';
import 'package:ltr/views/components/common/common.dart';
import 'package:ltr/views/styles/colors.dart';

class GameList extends StatefulWidget {
  const GameList({Key? key}) : super(key: key);

  @override
  State<GameList> createState() => _GameListState();
}

class _GameListState extends State<GameList> {
  
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
            Row(
              children: [
                Flexible(
                  child: Container(
                    margin: const EdgeInsets.all(5),
                    decoration: boxDecoration(g.wstrGameBColor, 30),
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.task_alt,color: Colors.white,size: 15,),
                        gapWC(5),
                        tcn('Update', Colors.white, 15)
                      ],
                    ),
                  ),
                ),
                gapWC(5),
                Bounce(
                  onPressed: (){
                    Navigator.pop(context);
                  },
                  duration: const Duration(milliseconds: 110),
                  child: Container(
                    margin: const EdgeInsets.all(5),
                    decoration: boxBaseDecoration(greyLight, 30),
                    padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.cancel_outlined,color: Colors.black,size: 15,),
                        gapWC(5),
                        tcn('Cancel', Colors.black, 15)
                      ],
                    ),
                  ),
                ),
              ],
            )
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
            if(selectedList.contains(code)){
              selectedList.remove(code);
            }else{
              selectedList.add(code);
            }
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
                tcn(text,selectedList.contains(code)? Colors.black:Colors.black.withOpacity(0.3), 30),
                //const Icon(Icons.navigate_next_sharp,color: Colors.white,size: 30,)
                Container(
                  decoration: boxDecoration(Colors.white.withOpacity(0.9), 30),
                  padding: const EdgeInsets.all(5),
                  child: Center(
                    child: Icon(Icons.task_alt,color:selectedList.contains(code)?Colors.black: greyLight,size: 15,),
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
