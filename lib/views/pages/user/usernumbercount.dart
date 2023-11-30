

import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:ltr/controller/global/globalValues.dart';
import 'package:ltr/services/apiController.dart';
import 'package:ltr/views/components/common/common.dart';
import 'package:ltr/views/styles/colors.dart';

class UserNumberCount extends StatefulWidget {
  final String pUserCode;
  final String pUserRole;
  const UserNumberCount({Key? key, required this.pUserCode, required this.pUserRole}) : super(key: key);

  @override
  State<UserNumberCount> createState() => _NumberCountState();
}

class _NumberCountState extends State<UserNumberCount> {



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
  bool blAllGame  = false;

  var txtNum = TextEditingController();
  var txtNumTo = TextEditingController();
  var txtDiff = TextEditingController();
  var txtCount = TextEditingController();
  var txtBoxCount = TextEditingController();
  var txtName = TextEditingController();
  var txtChangeQty = TextEditingController();

  var fnNum = FocusNode();
  var fnNumTo = FocusNode();
  var fnDiff = FocusNode();
  var fnCount = FocusNode();
  var fnBoxCount = FocusNode();
  var fnName = FocusNode();

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
                      decoration: boxBaseDecoration(Colors.white,10),
                      padding: const EdgeInsets.all(5),
                      child: const Icon(Icons.arrow_back,color: Colors.black,size: 20,),
                    ),
                  ),
                  gapWC(5),
                  tcn("Number Count", Colors.white, 20)
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
                                  height: 35,
                                  padding: const EdgeInsets.symmetric(horizontal: 15),
                                  decoration: boxBaseDecoration(greyLight, 5),
                                  child: TextFormField(
                                    controller: txtNum,
                                    focusNode: fnNum,
                                    maxLength: gCountNum,
                                    inputFormatters: mfnInputFormatters(),
                                    keyboardType: TextInputType.number,
                                    decoration: const InputDecoration(
                                      hintText: 'Num',
                                      counterText: "",
                                      border: InputBorder.none,
                                    ),
                                    onChanged: (val){
                                      if(val.toString().length == gCountNum){
                                        fnNumTo.requestFocus();
                                      }
                                    },
                                  ),
                                ),
                              ),
                              gapWC(5),
                              Flexible(
                                child: Container(
                                  height: 35,
                                  padding: const EdgeInsets.symmetric(horizontal: 15),
                                  decoration: boxBaseDecoration(greyLight, 5),
                                  child: TextFormField(
                                    controller: txtNumTo,
                                    focusNode: fnNumTo,
                                    maxLength: gCountNum,
                                    inputFormatters: mfnInputFormatters(),
                                    keyboardType: TextInputType.number,
                                    decoration: const InputDecoration(
                                      hintText: 'To',
                                      counterText: "",
                                      border: InputBorder.none,
                                    ),
                                    onChanged: (val){
                                      if(val.toString().length == gCountNum){
                                        fnDiff.requestFocus();
                                      }
                                    },
                                  ),
                                ),
                              ),
                              gapWC(5),
                              Flexible(
                                child: Container(
                                  height: 35,
                                  padding: const EdgeInsets.symmetric(horizontal: 15),
                                  decoration: boxBaseDecoration(greyLight, 5),
                                  child: TextFormField(
                                    controller: txtDiff,
                                    focusNode: fnDiff,
                                    inputFormatters: mfnInputFormatters(),
                                    keyboardType: TextInputType.number,
                                    decoration: const InputDecoration(
                                      hintText: 'Diff',
                                      border: InputBorder.none,
                                    ),
                                    onFieldSubmitted: (val){
                                      fnBoxCount.requestFocus();
                                    },
                                  ),
                                ),
                              ),
                              gapWC(5),
                              Flexible(
                                child: Container(
                                  height: 35,
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
                                      fnBoxCount.requestFocus();
                                    },
                                  ),
                                ),
                              ),
                              gapWC(5),
                            ],
                          ),
                          gapHC(5),
                          Row(
                            children: [
                              Expanded(child: GestureDetector(
                                onTap: (){
                                  if(mounted){
                                    setState(() {
                                      blAllGame = !blAllGame;
                                    });
                                  }
                                },
                                child: Container(
                                  decoration: boxBaseDecoration(greyLight, 30),
                                  padding: const EdgeInsets.all(5),
                                  margin: const EdgeInsets.symmetric(horizontal: 10),
                                  child: Row(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(4),
                                        decoration: boxBaseDecoration(Colors.white, 30),
                                        child: Container(
                                          height: 18,
                                          width: 18,
                                          decoration: blAllGame?boxDecoration( bgColorDark, 30):boxBaseDecoration( Colors.white, 30),
                                          child: const Icon(Icons.done,color: Colors.white,size: 13,),
                                        ),
                                      ),
                                      gapWC(10),
                                      tcn('All Game',blAllGame? Colors.black: Colors.black, 15)
                                    ],
                                  ),
                                ),
                              )),

                              Expanded(
                                child: GestureDetector(
                                  onTap: (){
                                    fnAddNumber();
                                  },
                                  child: Container(
                                    height: 40,
                                    padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 20),
                                    decoration: boxBaseDecoration(g.wstrGameBColor, 30),
                                    child: Center(
                                      child: tcn('Add', Colors.white, 15),
                                    ),
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

    return rtnList;
  }
  

  //=====================================PAGE FN


  fnGetPageData(){
    apiGetGameList();
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


    var fromNum = txtNum.text;
    var toNum = txtNumTo.text;

    var favList = [];

    if(toNum.isNotEmpty){
      if(g.mfnDbl(txtNum.text) >= g.mfnDbl(txtNumTo.text)){
        errorMsg(context, "Entered number not valid");
        return;
      }
      var diffVal = g.mfnDbl(txtDiff.text) == 0?1.0:g.mfnDbl(txtDiff.text);
      for(var i = g.mfnDbl(fromNum);i <= g.mfnDbl(toNum);i = i+ diffVal ){
        var iNum = i.toStringAsFixed(0);
        if(gCountNum ==3){
          iNum = iNum.length ==1?('00$iNum').toString():iNum.length ==2?('0$iNum').toString():iNum;
        }else if(gCountNum ==2){
          iNum = iNum.length ==1?('0$iNum').toString():iNum;
        }

        if(blAllGame){
          for(var e in gameList){
            favList.add({
              "GAME_CODE":(e["CODE"]??"").toString(),
              "TYPE":fSelectedGame,
              "NUMBER":iNum,
              "COUNT":txtCount.text,
            });
          }
        }else{
          favList.add({
            "GAME_CODE":g.wstrSelectedGame,
            "TYPE":fSelectedGame,
            "NUMBER":iNum,
            "COUNT":txtCount.text,
          });
        }

      }
    }else{
      if(blAllGame){
        for(var e in gameList){
          favList.add({
            "GAME_CODE":(e["CODE"]??"").toString(),
            "TYPE":fSelectedGame,
            "NUMBER":txtNum.text,
            "COUNT":txtCount.text,
          });
        }
      }else{
        favList.add({
          "GAME_CODE":g.wstrSelectedGame,
          "TYPE":fSelectedGame,
          "NUMBER":txtNum.text,
          "COUNT":txtCount.text,
        });
      }

    }


    print(favList);


    
    if(mounted){
      apiAddNumberCount(fSelectedGame,favList);
      setState(() {
        // fNumberLimit.removeWhere((element) => element["TYPE"] == fSelectedGame && element["NUMBER"] == txt);
        // fNumberLimit.add({
        //   "TYPE":fSelectedGame,
        //   "NUMBER":txt,
        //   "COUNT":g.mfnDbl(g.mfnDbl(txtCount.text)),
        // });

        txtCount.clear();
        txtDiff.clear();
        txtNumTo.clear();
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
    futureForm = apiCall.apiGetUserGames(g.wstrCompany, null, "");
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


  apiAddNumberCount(type,favList){
    futureForm = apiCall.apiSaveUserNumberCount(g.wstrCompany,widget.pUserCode,favList);
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
    futureForm = apiCall.apiRemoveNumberCountLimit(g.wstrCompany, widget.pUserCode, g.wstrSelectedGame, type, num);
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
    futureForm  = apiCall.apiGetUserDetails(g.wstrCompany, widget.pUserCode, "NUMBER_COUNTLIMIT",null);
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
