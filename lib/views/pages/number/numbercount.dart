

import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:ltr/controller/global/globalValues.dart';
import 'package:ltr/services/apiController.dart';
import 'package:ltr/views/components/common/common.dart';
import 'package:ltr/views/styles/colors.dart';

class NumberCount extends StatefulWidget {
  const NumberCount({Key? key}) : super(key: key);

  @override
  State<NumberCount> createState() => _NumberCountState();
}

class _NumberCountState extends State<NumberCount> {


  //Global
  var g = Global();
  var apiCall = ApiCall();
  late Future<dynamic> futureForm;

  //Game
  var gCountNum = 3;


  //Page Variables
  var fSelectedGame = "";
  var fNumberLimit = [];
  var gameList = [];


  var txtNum = TextEditingController();
  var txtCount = TextEditingController();

  var fnNum = FocusNode();
  var fnCount = FocusNode();

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
          crossAxisAlignment: CrossAxisAlignment.start,
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
                  tcn("Global Number Count", Colors.white, 20)
                ],
              ),
            ),
            gapHC(10),
            Expanded(
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: boxDecoration(Colors.white, 10),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Row(
                                children: [
                                  wNumberCard(1),
                                  gapWC(5),
                                  wNumberCard(2),
                                  gapWC(5),
                                  wNumberCard(3),
                                ],
                              ),
                              gapWC(30),
                              Expanded(
                                child: Row(
                                  children: [
                                    gCountNum == 3?
                                    Expanded(
                                      child: Row(
                                        children: [
                                          // wButton("BOTH",Colors.red),
                                          //  gapWC(5),
                                          wButton("BOX",Colors.pink),
                                          gapWC(5),
                                          wButton("SUPER",bgColorDark),
                                        ],
                                      ),
                                    ):
                                    gCountNum == 2?
                                    Expanded(
                                      child: Row(
                                        children: [
                                          wButton("AB",Colors.green),
                                          gapWC(5),
                                          wButton("BC",Colors.green),
                                          gapWC(5),
                                          wButton("AC",Colors.green),
                                          // gapWC(5),
                                          // wButton("ALL",bgColorDark),
                                        ],
                                      ),
                                    ):
                                    Expanded(
                                      child: Row(
                                        children: [
                                          wButton("A",Colors.orange),
                                          gapWC(5),
                                          wButton("B",Colors.orange),
                                          gapWC(5),
                                          wButton("C",Colors.orange),
                                          // gapWC(5),
                                          // wButton("ALL",bgColorDark),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              )

                            ],
                          ),
                          gapHC(10),
                          Row(
                            children: [
                              Flexible(
                                child: Container(
                                  height: 40,
                                  padding: const EdgeInsets.symmetric(horizontal: 15),
                                  decoration: boxBaseDecoration(greyLight, 5),
                                  child: TextFormField(
                                    controller: txtNum,
                                    focusNode: fnNum,
                                    maxLength: gCountNum,
                                    inputFormatters: mfnInputFormatters(),
                                    keyboardType: TextInputType.number,
                                    decoration: const InputDecoration(
                                      hintText: 'Number',
                                      counterText: "",
                                      border: InputBorder.none,
                                    ),
                                    onChanged: (val){
                                      if(txtNum.text.length == gCountNum){
                                        fnCount.requestFocus();
                                      }
                                    },
                                  ),
                                ),
                              ),
                              gapWC(10),
                              Flexible(
                                child: Container(
                                  height: 40,
                                  padding: const EdgeInsets.symmetric(horizontal: 15),
                                  decoration: boxBaseDecoration(greyLight, 5),
                                  child: TextFormField(
                                    controller: txtCount,
                                    focusNode: fnCount,
                                    inputFormatters: mfnInputFormatters(),
                                    keyboardType: TextInputType.number,
                                    decoration: const InputDecoration(
                                      hintText: 'Count',
                                      border: InputBorder.none,
                                    ),
                                    onFieldSubmitted: (val){

                                    },
                                  ),
                                ),
                              ),
                              gapWC(10),
                              GestureDetector(
                                onTap: (){
                                  fnAddNumber();
                                },
                                child: Container(
                                  height: 40,
                                  padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 20),
                                  decoration: boxBaseDecoration(g.wstrGameBColor, 30),
                                  child: Center(
                                    child: tcn('Add', g.wstrGameOTColor, 15),
                                  ),
                                ),
                              )
                            ],
                          )

                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: const
                        EdgeInsets.all(10),
                        padding: const EdgeInsets.all(10),
                        decoration: boxDecoration(Colors.white, 10),
                        child: SingleChildScrollView(
                          child: Column(
                            children: wNumberList(),
                          ),
                        ),
                      ),
                    )
                  ],
                )
            )

          ],
        ),
      ),
    );
  }

  //=====================================WIDGET

  Widget wNumberCard(num){
    return  Bounce(
      onPressed: (){
        if(mounted){
          setState(() {
            gCountNum = num;
            txtNum.clear();
            fSelectedGame ="";
          });
        }
      },
      duration: const Duration(milliseconds: 110),
      child: Container(
        height: 25,
        width: 25,
        alignment: Alignment.center,
        decoration: gCountNum == num?boxBaseDecoration(g.wstrGameBColor, 5):boxOutlineCustom1(Colors.white, 5, g.wstrGameBColor, 1.0),
        child: tc(num.toString(), gCountNum == num?g.wstrGameOTColor:g.wstrGameTColor, 15),
      ),
    );
  }
  Widget wButton(text,color){
    return Flexible(
      child: Bounce(
        onPressed: (){
          //fnButtonPres(text);
          //fnGenerateNumber(text);
          if(mounted){
            setState(() {
              fSelectedGame =text;
            });
          }
        },
        duration: const Duration(milliseconds: 110),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 5),
          decoration: fSelectedGame == text?boxBaseDecoration(g.wstrGameBColor, 5):boxOutlineCustom1(Colors.white, 5, g.wstrGameBColor, 1.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  text == "SUPER"? Icon(Icons.star_border,color: g.wstrGameOTColor,size: 15,):gapHC(0),
                  text == "SUPER"?gapWC(5):gapHC(0),
                  tc(text.toString(),fSelectedGame == text? g.wstrGameOTColor :g.wstrGameTColor, 14)
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
  List<Widget> wNumberList(){
    List<Widget> rtnList = [];
    rtnList.add( Row());
    var srNo  = 1;
    for(var e in fNumberLimit){
      if(g.mfnDbl(e["COUNT"].toString()) != -1){
        rtnList.add(Container(
          margin:const  EdgeInsets.only(bottom: 5),
          padding: const EdgeInsets.all(5),
          decoration: boxBaseDecoration(bgColorDark.withOpacity(0.1), 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    decoration: boxGradientDecorationBase(20, 5),
                    padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 20),
                    child: Column(
                      children: [
                        tcn("NUMBER", Colors.white, 8),
                        tc((e["NUMBER"]??"").toString(), Colors.white, 20),
                      ],
                    ),
                  ),
                  gapWC(15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      tc("${e["TYPE"]??""}", Colors.black, 15),
                      tcn(g.mfnDbl(e["COUNT"].toString()).toStringAsFixed(0)+" NOS", Colors.black, 18),
                    ],
                  ),

                ],
              ),
              GestureDetector(
                  onTap: (){
                    if(mounted){
                      apiRemoveNumberCount((e["TYPE"]??""),(e["NUMBER"]??""));
                    }
                  },
                  child: const Icon(Icons.close,color: Colors.grey,size: 25,))
            ],
          ),
        ));
      }

    }

    return rtnList;
  }


  //=====================================PAGE FN

  fnGetPageData(){
    apiGetDetails();
  }
  fnAddNumber(){

    var txt =  txtNum.text;
    var count =  txtCount.text;

    if(txtNum.text.isEmpty){
      errorMsg(context, "Enter Number");
      return;
    }
    if(fSelectedGame.isEmpty){
      errorMsg(context, "Select Type");
      return;
    }
    if(g.mfnDbl(txtCount.text) <= 0){
      errorMsg(context, "Enter Count");
      return;
    }

    if(mounted){
      apiAddNumberCount(fSelectedGame);
      setState(() {
        // fNumberLimit.removeWhere((element) => element["TYPE"] == fSelectedGame && element["NUMBER"] == txt);
        // fNumberLimit.add({
        //   "TYPE":fSelectedGame,
        //   "NUMBER":txt,
        //   "COUNT":g.mfnDbl(g.mfnDbl(txtCount.text)),
        // });

        txtCount.clear();
        txtNum.clear();
      });
    }
  }
  fnFill(value){
    if(mounted){
      setState(() {
        fNumberLimit = value??[];
      });
    }
  }



  //======================================API CALL

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


  apiAddNumberCount(type){
    futureForm = apiCall.apiSaveGlobalNumberCount( "ALL", type, txtNum.text , txtCount.text);
    futureForm.then((value) => apiAddNumberCountRes(value));
  }
  apiAddNumberCountRes(value){
    if(mounted){
      if(g.fnValCheck(value)){
        //[{STATUS: 1, MSG: ADDED}]
        var sts = (value[0]["STATUS"]??"").toString();
        var msg = (value[0]["MSG"]??"").toString();
        if(sts == "1"){
          //successMsg(context, "Success");
          //after success directly move to the user details page
          apiGetDetails();
        }else{
          errorMsg(context, msg.toString());
        }

      }else{
        errorMsg(context, "Please try again");
      }
    }
  }



  apiRemoveNumberCount(type,num){
    futureForm = apiCall.apiRemoveGlobalNumberCountLimit( "ALL", type, num);
    futureForm.then((value) => apiRemoveNumberCountRes(value));
  }
  apiRemoveNumberCountRes(value){
    if(mounted){
      if(g.fnValCheck(value)){
        //[{STATUS: 1, MSG: ADDED}]
        var sts = (value[0]["STATUS"]??"").toString();
        var msg = (value[0]["MSG"]??"").toString();
        if(sts == "1"){
          //successMsg(context, "Success");
          //after success directly move to the user details page
          apiGetDetails();
        }else{
          errorMsg(context, msg.toString());
        }

      }else{
        errorMsg(context, "Please try again");
      }
    }
  }


  apiGetDetails(){
    futureForm  = apiCall.apiGetGlobalDetails(g.wstrCompany, "NUMBER_COUNTLIMIT");
    futureForm.then((value) => apiGetDetailsRes(value));
  }
  apiGetDetailsRes(value){
    if(mounted){
      if(g.fnValCheck(value)){
        fnFill(value);
      }
    }
  }




}
