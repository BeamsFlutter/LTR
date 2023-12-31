

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:flutter_dynamic_icon/flutter_dynamic_icon.dart';
import 'package:get/get.dart';
import 'package:ltr/controller/global/globalValues.dart';
import 'package:ltr/services/MQTTClientManager.dart';
import 'package:ltr/services/apiController.dart';
import 'package:ltr/views/components/alertDialog/alertDialog.dart';
import 'package:ltr/views/components/common/common.dart';
import 'package:ltr/views/pages/booking/booking.dart';
import 'package:ltr/views/pages/login/login.dart';
import 'package:ltr/views/styles/colors.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HomeTheme extends StatefulWidget {
  const HomeTheme({Key? key}) : super(key: key);

  @override
  _HomeThemeState createState() => _HomeThemeState();
}

class _HomeThemeState extends State<HomeTheme> {


  //Global
  var g = Global();
  var apiCall  = ApiCall();
  late Future<dynamic> futureForm;
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  var lstrNumber = "";
  int first = 0, second =0;
  String res = "", text = "";
  String opp= "";

  var blInternet = true;


  //===================MQTT
  MQTTClientManager mqttClientManager = MQTTClientManager();



  var webController = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..setBackgroundColor(Colors.white)
    ..setNavigationDelegate(
      NavigationDelegate(
        onProgress: (int progress) {
          // Update loading bar.

        },
        onPageStarted: (String url) {

        },
        onPageFinished: (String url) {},
        onWebResourceError: (WebResourceError error) {

        },
        onNavigationRequest: (NavigationRequest request) {
          if (request.url.startsWith('https://www.google.com/')) {
            return NavigationDecision.prevent;
          }
          return NavigationDecision.navigate;
        },
      ),
    )
    ..loadRequest(Uri.parse('https://www.google.com/'));



  var subscription;

  @override
  void initState() {
    // TODO: implement initState
    g.wstrCompany = "03";
    g.wstrCompanyMqKey = "dxbltrker6";
    g.wstrThemeUrl = "https://www.google.com/";
    g.wstrBaseUrl = "http://68.178.174.207:1100/";

    fnGetPageData();
    setupMqttClient();
    fnShowListen();
    subscription = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      // Got a new connectivity status!
      fnUpdateNetwork(result);
    });
    super.initState();


  }

  @override
  dispose() {
    mqttClientManager.disconnect();
    subscription.cancel();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: MediaQuery.of(context).padding,
        decoration: boxBaseDecoration(Colors.white, 0),
        child: blInternet?Stack(
          children: [

            WebViewWidget(
              controller: webController,
            ),
            Positioned(
              top: 10,
              right:10 ,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: (){
                      //Navigator.pop(context);
                    },
                    onLongPress: (){
                      apiCheckAppBlock();
                    },
                    child: const Icon(Icons.menu,color: Colors.transparent,size: 50,),
                  ),
                ],
              ),),


          ],
        ):Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(),
            tcn('No Internet ', Colors.grey, 25)
          ],
        ),
      ),
    );
  }

  //===============================Widget
  Widget wButton(text,color){
    return Flexible(
      child: Bounce(
        onPressed: (){
          fnUpdate(text);
        },
        duration:const  Duration(milliseconds: 110),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 15),
          decoration: boxBaseDecoration(color == "O"? Colors.orange:Colors.grey.withOpacity(0.2), 100),
          margin: const EdgeInsets.symmetric(horizontal: 2),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(),
              tcn(text, color == "O"? Colors.white:Colors.white, 22),
            ],
          ),
        ),
      ),
    );
  }
  Widget wButtonSpcl(text,color){
    return Flexible(
      child: GestureDetector(
        onTap: (){
          fnUpdate(text);
        },
        onLongPress: (){
          apiCheckAppBlock();
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 15),
          decoration: boxBaseDecoration(color == "O"? Colors.orange:Colors.grey.withOpacity(0.2), 100),
          margin: const EdgeInsets.symmetric(horizontal: 2),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(),
              tcn(text, color == "O"? Colors.white:Colors.white, 22),
            ],
          ),
        ),
      ),
    );
  }

  //=====================================Page Fn


  fnGetPageData() async{
    final result = await (Connectivity().checkConnectivity());
    fnUpdateNetwork(result);
    getDataFromSession();
  }

  fnUpdate(btnText){
    if(mounted){
      try{
        if (btnText == "C" || btnText == "AC") {
          res = "";
          text = "";
          first = 0;
          second = 0;
        }else if (btnText == "<" ) {
          res =  lstrNumber.substring(0,lstrNumber.length-1);
        }
        else if (btnText == "+" ||
            btnText == "-" ||
            btnText == "x" ||
            btnText == "/") {
          first = int.parse(lstrNumber);
          res = first.toString()+btnText.toString();
          opp = btnText;
        } else if (btnText == "=") {
          var numbers  = lstrNumber.split(opp);
          if(numbers.length > 1){
            second = int.parse(numbers[1].toString());
            if (opp == "+") {
              res = (first + second).toString();
            }
            if (opp == "-") {
              res = (first - second).toString();
            }
            if (opp == "x") {
              res = (first * second).toString();
            }
            if (opp == "/") {
              res = (first ~/ second).toString();
            }
          }

        } else {
          res = (lstrNumber.toString() + btnText).toString();
        }
      }catch(e){
        dprint(e);
      }
      setState(() {
        lstrNumber = res;
      });
    }
  }

  fnUpdateNetwork(result){
    if(mounted){
      var sts = false;
      if (result == ConnectivityResult.mobile) {
        // I am connected to a mobile network.
        sts = true;
      } else if (result == ConnectivityResult.wifi) {
        // I am connected to a wifi network.
        sts = true;
      }
     setState(() {
       blInternet = sts;
     });
    }
  }


  fnGoLogin(){
    if(mounted){
      Get.to(()=>const LoginPage());
    }
  }


  //=======================================================================API
  apiCheckAppBlock(){
    futureForm = apiCall.apiCheckAppBlock(g.wstrCompany, "APP");
    futureForm.then((value) => apiCheckAppBlockRes(value));
  }
  apiCheckAppBlockRes(value){
    if(mounted){
      dprint("*******************************************");
      dprint(value);
      if(g.fnValCheck(value)){
        var sts = value[0]["STATUS"];
        var block = value[0]["BLOCK_YN"];
        if(block == "Y"){
          //Bocked
          //errorMsg(context, "Sorry, Try Later !!");
        }else{
          fnGoLogin();
        }

      }else{
        fnGoLogin();
      }

    }
  }
  getDataFromSession() async{
    final SharedPreferences prefs = await _prefs;
    var theme = prefs.getString("wstrThemeUrl");

    if(mounted && theme.toString().isNotEmpty){
      setState(() {
        g.wstrThemeUrl = theme;
      });
    }
  }


  //========================================MQTT

  Future<void> setupMqttClient() async {
    await mqttClientManager.connect();
    mqttClientManager.subscribe(g.wstrCompanyMqKey.toString().toLowerCase());

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
        dprint("home theme");
        setState(() {
          //g.wstrBaseUrl = (pt??"").toUpperCase();
          // if(g.wstrBaseUrl.toString().isEmpty){
          //   //SystemNavigator.pop();
          // }
        });
      }
    });
  }

  //=================================ICON CHANGE
  changeAppIcon() async {
    // try {
    //   debugPrint("start");
    //
    //   if (await FlutterDynamicIcon.supportsAlternateIcons) {
    //     await FlutterDynamicIcon.setAlternateIconName("applogo2");
    //     debugPrint("App icon change successful");
    //     return;
    //   }
    // } catch (e) {
    //   debugPrint("Exception: ${e.toString()}");
    // }
    // debugPrint("Failed to change app icon ");
  }

}
