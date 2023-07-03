





import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:get/get.dart';
import 'package:ltr/controller/global/globalValues.dart';
import 'package:ltr/views/components/common/common.dart';
import 'package:ltr/views/pages/booking/booking.dart';
import 'package:ltr/views/pages/login/login.dart';
import 'package:ltr/views/styles/colors.dart';

class HomeTheme extends StatefulWidget {
  const HomeTheme({Key? key}) : super(key: key);

  @override
  _HomeThemeState createState() => _HomeThemeState();
}

class _HomeThemeState extends State<HomeTheme> {


  //Global
  var g = Global();

  var lstrNumber = "";
  int first = 0, second =0;
  String res = "", text = "";
  String opp= "";

  @override
  void initState() {
    // TODO: implement initState
    g.wstrCompany = "01";
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: MediaQuery.of(context).padding,
        decoration: boxBaseDecoration(Colors.black, 0),
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                gapWC(5),
                Container(
                  padding: const EdgeInsets.all(3),
                  decoration: boxBaseDecoration(Colors.white, 10),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: boxBaseDecoration(Colors.grey.withOpacity(0.5), 10),
                        child: const Icon(Icons.wb_sunny_outlined,color: Colors.black,size: 12,),
                      ),
                      gapWC(5),
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: boxBaseDecoration(Colors.white.withOpacity(0.5), 10),
                        child: const Icon(Icons.nightlight_outlined,color: Colors.black,size: 12,),
                      )

                    ],
                  ),
                ),
                const Icon(Icons.menu,color:Colors.white,size: 25,)
              ],
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(),
                  tcn(lstrNumber.toString(), Colors.white  , 30)
                ],
              ),
            ),
            gapHC(20),
            Row(
              children: [
                wButton("AC","O"),
                wButton("<","O"),
                wButton("%","O"),
                wButton("/","O"),
              ],
            ),
            gapHC(5),
            Row(
              children: [
                wButton("7","B"),
                wButton("8","B"),
                wButton("9","B"),
                wButton("x","O"),
              ],
            ),
            gapHC(5),
            Row(
              children: [
                wButtonSpcl("4","B"),
                wButton("5","B"),
                wButton("6","B"),
                wButton("-","O"),
              ],
            ),
            gapHC(5),
            Row(
              children: [
                wButton("1","B"),
                wButton("2","B"),
                wButton("3","B"),
                wButton("+","O"),
              ],
            ),
            gapHC(5),
            Row(
              children: [
                wButton("C","O"),
                wButton("0","B"),
                wButton(".","B"),
                wButton("=","O"),
              ],
            )


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
          fnGoLogin();
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


  fnGoLogin(){
    if(mounted){
      Get.to(const LoginPage());
    }
  }

}
