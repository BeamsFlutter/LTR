

import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:get/get.dart';
import 'package:ltr/controller/global/globalValues.dart';
import 'package:ltr/controller/navigation/navigation_controller.dart';
import 'package:ltr/services/apiController.dart';
import 'package:ltr/views/components/common/common.dart';
import 'package:ltr/views/pages/home/mainscreen.dart';
import 'package:ltr/views/styles/colors.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  //Global
  var g = Global();
  var n =  NavigationController();
  var apiCall = ApiCall();
  late Future<dynamic> futureForm;

  //Page Variable
  var gameList  = [];

  var webController = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..setBackgroundColor(const Color(0x00000000))
    ..setNavigationDelegate(
      NavigationDelegate(
        onProgress: (int progress) {
          // Update loading bar.
        },
        onPageStarted: (String url) {},
        onPageFinished: (String url) {},
        onWebResourceError: (WebResourceError error) {},
        onNavigationRequest: (NavigationRequest request) {
          if (request.url.startsWith('https://www.youtube.com/')) {
            return NavigationDecision.prevent;
          }
          return NavigationDecision.navigate;
        },
      ),
    )
    ..loadRequest(Uri.parse('https://www.airtel.in/'));

  @override
  void initState() {
    // TODO: implement initState
    fnGetPageData();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      endDrawer:  Drawer(
        width: 240,
        child: Container(
          margin: MediaQuery.of(context).padding,
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                children: [
                  tcn('Select Game', Colors.black, 15),
                ],
              ),
              gapHC(5),
              Expanded(child: SingleChildScrollView(
                child: Column(
                  children: wGameList(),
                ),
              ))
            ],
          ),
        ),
      ),
      // Disable opening the end drawer with a swipe gesture.
      endDrawerEnableOpenDragGesture: false,
      body: Container(
        decoration: boxBaseDecoration(greyLight, 0),
        margin: MediaQuery.of(context).padding,
        child: Container(
          decoration: boxDecoration(Colors.white, 0),
          child: Stack(
            children: [
              WebViewWidget(
                controller: webController,
              ),
              Positioned(
                top: 10,
                left:10 ,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: (){
                        //Navigator.pop(context);
                      },
                      onLongPress: (){
                        _scaffoldKey.currentState!.openEndDrawer();
                      },
                      child: const Icon(Icons.menu,color: Colors.white,size: 30,),
                    ),
                    // GestureDetector(
                    //   onTap: (){
                    //     Navigator.pop(context);
                    //   },
                    //   child: Container(
                    //     decoration: boxBaseDecoration(Colors.grey.withOpacity(0.1), 30),
                    //     padding: const EdgeInsets.all(5),
                    //     child: const Icon(Icons.power_settings_new,color: Colors.black,size: 30,),
                    //   ),
                    // )
                  ],
                ),),


            ],
          ),
        ),
      ),
    );
  }

  //================================WIDGET
    Widget wLotCard(color,text,start,e,bcolor,tcolor,otcolor){
      var code = g.mfnTxt(e["CODE"]);
      var name = g.mfnTxt(e["DESCP"]);
      var link = g.mfnTxt(e["LIVE_LINK"]);
      var editTime = g.mfnTxt(e["EDIT_MINUT"]);
      var end = g.mfnTxt(e["END_TIME"]);
      return Bounce(
        onPressed: (){
          fnSelectGame(code,name,color,bcolor,tcolor,otcolor,link,editTime,end);
        },
        duration: const Duration(milliseconds: 110),
        child: Container(
          decoration: boxBaseDecoration(color, 10),
          padding: const EdgeInsets.all(5),
          margin: const EdgeInsets.only(bottom: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  tc(text, Colors.white, 15),
                  const Icon(Icons.navigate_next_sharp,color: Colors.white,size: 30,)
                ],
              ),
            ],
          ),
        ),
      );
    }

    List<Widget> wGameList(){
      List<Widget> rtnList  = [];
      var srno =1;
      for(var e in gameList){

        var code = g.mfnTxt(e["CODE"]);
        var name = g.mfnTxt(e["DESCP"]);

        var start = "";
        var colorCode  =  g.mfnTxt(e["CODE"]);
       // var color  =  colorCode == "1PM"?Colors.blueAccent:colorCode == "3PM"?Colors.amber:colorCode == "6PM"?Colors.green:colorCode == "8PM"?Colors.redAccent:Colors.amber;
        var color  =  colorCode == "1PM"?oneColor:colorCode == "3PM"?threeColor:colorCode == "6PM"?sixColor:colorCode == "8PM"?eightColor:Colors.amber;
        var bcolor  =  colorCode == "1PM"?oneButtonColor:colorCode == "3PM"?threeButtonColor:colorCode == "6PM"?sixButtonColor:colorCode == "8PM"?eightButtonColor:Colors.amber;
        var tcolor  =  colorCode == "1PM"?oneTextColor:colorCode == "3PM"?threeTextColor:colorCode == "6PM"?sixTextColor:colorCode == "8PM"?eightTextColor:Colors.amber;
        var otcolor  =  colorCode == "1PM"?oneOnTextColor:colorCode == "3PM"?threeOnTextColor:colorCode == "6PM"?sixOnTextColor:colorCode == "8PM"?eightOnTextColor:Colors.amber;

        rtnList.add(wLotCard(color,name,start,e,bcolor,tcolor,otcolor));
        srno =srno+1;
      }
      return rtnList;
    }

  //================================PAGE FN
  fnGetPageData(){
    apiGetGameList();
  }

  fnSelectGame(code,name,color,bcolor,tcolor,otcolor,link,editTime,end){
    if(mounted){
      setState(() {
        g.wstrSelectedGame = code;
        g.wstrSelectedGameName = name;
        g.wstrGameColor = color;
        g.wstrGameBColor = bcolor;
        g.wstrGameTColor = tcolor;
        g.wstrGameOTColor = otcolor;
        g.wstrSGameLink = link;
        g.wstrSGameEdit = editTime;
        g.wstrSGameEnd = end;
      });
    }
      Navigator.push(context, n.pageRoute(1));
  }

  //================================API CALL
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
        }
      });

    }
  }
}
