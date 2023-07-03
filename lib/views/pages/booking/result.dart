

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:ltr/controller/global/globalValues.dart';
import 'package:ltr/services/apiController.dart';
import 'package:ltr/views/components/common/common.dart';
import 'package:ltr/views/styles/colors.dart';
import 'package:url_launcher/url_launcher.dart';

class Results extends StatefulWidget {
  const Results({Key? key}) : super(key: key);

  @override
  State<Results> createState() => _ResultsState();
}

class _ResultsState extends State<Results> {
  
  //Global
  var g =  Global();
  var apiCall = ApiCall();
  late Future<dynamic> futureForm;
  
  //Page Variable
  var frResultData = [];
  var fResDate = DateTime.now();
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
                          //decoration: boxBaseDecoration(greyLight,10),
                          padding: const EdgeInsets.all(5),
                          child: const Icon(Icons.arrow_back_ios_rounded,color: Colors.white,size: 20,),
                        ),
                      ),
                      gapWC(5),
                      tcn("Results (${g.wstrSelectedGame.toString()})", Colors.white, 20)
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 5),
                    decoration: boxDecoration(Colors.white, 30),
                    child: Row(
                      children: [
                          tcn('Share', grey, 15),
                          gapWC(5),
                          const Icon(Icons.share_outlined,color: grey,size: 15,)
                      ],
                    ),
                  )
                ],
              ),
            ),
            gapHC(10),
            // Row(
            //   children: [
            //     gapWC(10),
            //     tcn('Last published date $today', grey, 10),
            //   ],
            // ),
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
                  padding: const EdgeInsets.all(10),
                  child: SingleChildScrollView(
                    child: Column(children: [
                      wResultCard(1,Colors.amber.withOpacity(0.5)),
                      wResultCard(2,Colors.red.withOpacity(0.5)),
                      wResultCard(3,Colors.green.withOpacity(0.5)),
                      wResultCard(4,Colors.orange.withOpacity(0.5)),
                      wResultCard(5,Colors.blue.withOpacity(0.5)),
                      wResultCard(6,Colors.indigo.withOpacity(0.5)),
                      gapHC(10),
                      Row(
                        children: [
                          w30Card(7),
                          gapWC(5),
                          w30Card(8),
                          gapWC(5),
                          w30Card(9),
                        ],
                      ),
                      gapHC(5),
                      Row(
                        children: [
                          w30Card(10),
                          gapWC(5),
                          w30Card(11),
                          gapWC(5),
                          w30Card(12),
                        ],
                      ),
                      gapHC(5),
                      Row(
                        children: [
                          w30Card(13),
                          gapWC(5),
                          w30Card(14),
                          gapWC(5),
                          w30Card(15),
                        ],
                      ),
                      gapHC(5),
                      Row(
                        children: [
                          w30Card(16),
                          gapWC(5),
                          w30Card(17),
                          gapWC(5),
                          w30Card(18),
                        ],
                      ),
                      gapHC(5),
                      Row(
                        children: [
                          w30Card(19),
                          gapWC(5),
                          w30Card(20),
                          gapWC(5),
                          w30Card(21),
                        ],
                      ),
                      gapHC(5),
                      Row(
                        children: [
                          w30Card(22),
                          gapWC(5),
                          w30Card(23),
                          gapWC(5),
                          w30Card(24),
                        ],
                      ),
                      gapHC(5),
                      Row(
                        children: [
                          w30Card(25),
                          gapWC(5),
                          w30Card(26),
                          gapWC(5),
                          w30Card(27),
                        ],
                      ),
                      gapHC(5),
                      Row(
                        children: [
                          w30Card(28),
                          gapWC(5),
                          w30Card(29),
                          gapWC(5),
                          w30Card(30),
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
        padding: const EdgeInsets.all(10),
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
        padding: const EdgeInsets.all(5),
        decoration: boxBaseDecoration(Colors.blueGrey.withOpacity(0.1 ), 0),
        child: Center(
          child: tc(num.toString(), Colors.black, 15),
        ),
      ));
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
    var url = 'https://www.youtube.com/';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }
  //=================================================PAGE FN

  Future<void> _selectResultDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: fResDate,
        firstDate: DateTime(2020),
        lastDate: DateTime.now());
    if (pickedDate != null && pickedDate != fResDate) {
      setState(() {
        fResDate = pickedDate;
      });

    }
    apiGetResultData();
  }
  fnFill(){

  }
  //=================================================API CALL
  apiGetResultData(){
    setState(() {
      frResultData = [];
    });
    futureForm =  ApiCall().apiGetResultData(g.wstrSelectedGame, setDate(2, fResDate));
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
          setState(() {
            frResultData = det??[];
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

}
