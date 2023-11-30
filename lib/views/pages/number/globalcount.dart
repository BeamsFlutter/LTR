

import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:ltr/controller/global/globalValues.dart';
import 'package:ltr/services/apiController.dart';
import 'package:ltr/views/components/common/common.dart';
import 'package:ltr/views/components/enum.dart';
import 'package:ltr/views/components/inputfield/commonTextField.dart';
import 'package:ltr/views/styles/colors.dart';

class GlobalGameCount extends StatefulWidget {
  const GlobalGameCount({Key? key,}) : super(key: key);

  @override
  State<GlobalGameCount> createState() => _GlobalGameCountState();
}

class _GlobalGameCountState extends State<GlobalGameCount> {


  //Global
  var g = Global();
  var apiCall =  ApiCall();
  late Future<dynamic> futureForm ;

  //Page Variable
  var frSelectedUser = "";
  bool blEdit  = false;
  bool blAllGame  = false;
  var gameCountLimit = [];


  //Controller
  var txtSup = TextEditingController();
  var txtBox = TextEditingController();
  var txtA = TextEditingController();
  var txtB = TextEditingController();
  var txtC = TextEditingController();

  var txtAB = TextEditingController();
  var txtBC = TextEditingController();
  var txtAC = TextEditingController();


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
          children: [
            Row(),
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
                  tcn("Global Game Count", Colors.white, 20)
                ],
              ),
            ),
            gapHC(10),
            GestureDetector(
              onTap: (){
                if(mounted){
                  setState(() {
                    blEdit = !blEdit;
                  });
                }
              },
              child: Container(
                decoration: boxBaseDecoration(greyLight, 0),
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
                        decoration: blEdit?boxDecoration( bgColorDark, 30):boxOutlineCustom1(Colors.white, 30, Colors.black, 1.0),
                        child: const Icon(Icons.done,color: Colors.white,size: 13,),
                      ),
                    ),
                    gapWC(10),
                    tcn('Editable',blEdit? Colors.black: Colors.black, 15)
                  ],
                ),
              ),
            ),
            blEdit?gapHC(10):gapHC(0),
            blEdit?
            GestureDetector(
              onTap: (){
                if(mounted){
                  setState(() {
                    blAllGame = !blAllGame;
                  });
                }
              },
              child: Container(
                decoration: boxBaseDecoration(greyLight, 0),
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
            ):gapHC(0),
            gapHC(10),
            Expanded(child: Padding(
              padding: const EdgeInsets.all(10),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    CustomTextField(
                      keybordType: TextInputType.number,
                      controller: txtSup,
                      editable: blEdit,
                      hintText: "SUPER",
                      textFormFieldType: TextFormFieldType.weeklyCreditLimit,

                    ),
                    gapHC(15),
                    CustomTextField(
                      keybordType: TextInputType.number,
                      controller: txtBox,
                      editable: blEdit,
                      hintText: "BOX",
                      textFormFieldType: TextFormFieldType.weeklyCreditLimit,

                    ),
                    gapHC(15),
                    CustomTextField(
                      keybordType: TextInputType.number,
                      controller: txtA,
                      editable: blEdit,
                      hintText: "A",
                      textFormFieldType: TextFormFieldType.weeklyCreditLimit,

                    ),
                    gapHC(15),
                    CustomTextField(
                      keybordType: TextInputType.number,
                      controller: txtB,
                      editable: blEdit,
                      hintText: "B",
                      textFormFieldType: TextFormFieldType.weeklyCreditLimit,

                    ),
                    gapHC(15),
                    CustomTextField(
                      keybordType: TextInputType.number,
                      controller: txtC,
                      editable: blEdit,
                      hintText: "C",
                      textFormFieldType: TextFormFieldType.weeklyCreditLimit,

                    ),
                    gapHC(15),
                    CustomTextField(
                      keybordType: TextInputType.number,
                      controller: txtAB,
                      editable: blEdit,
                      hintText: "AB",
                      textFormFieldType: TextFormFieldType.weeklyCreditLimit,

                    ),
                    gapHC(15),
                    CustomTextField(
                      keybordType: TextInputType.number,
                      controller: txtBC,
                      editable: blEdit,
                      hintText: "BC",
                      textFormFieldType: TextFormFieldType.weeklyCreditLimit,

                    ),
                    gapHC(15),
                    CustomTextField(
                      keybordType: TextInputType.number,
                      controller: txtAC,
                      editable: blEdit,
                      hintText: "AC",
                      textFormFieldType: TextFormFieldType.weeklyCreditLimit,

                    ),
                    gapHC(15),
                  ],
                ),
              ),
            )),
            blEdit?
            Bounce(
              onPressed: (){
                fnUpdate();
              },
              duration: const Duration(milliseconds: 110),
              child: Container(
                decoration: boxDecoration(g.wstrGameBColor, 30),
                margin: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                padding: const EdgeInsets.symmetric(vertical: 12,horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.task_alt,color: Colors.white,size: 16,),
                    gapWC(5),
                    tcn('Update', Colors.white, 16)
                  ],
                ),
              ),
            ):gapHC(0)
          ],
        ),
      ),
    );
  }

  //================================WIDGET

  //================================PAGE FN
  fnGetPageData(){
    if(mounted){
      apiGetDetails();
    }
  }
  fnUpdate(){
    if(mounted){

      var game = blAllGame?"All":g.wstrSelectedGame;

      setState(() {
        gameCountLimit = [];
        gameCountLimit.add({
          "GAME_CODE": game,
          "TYPE": "SUPER",
          "COUNT": g.mfnInt(txtSup.text)
        });
        gameCountLimit.add({
          "GAME_CODE": game,
          "TYPE": "AB",
          "COUNT": g.mfnInt(txtAB.text)
        });
        gameCountLimit.add({
          "GAME_CODE": game,
          "TYPE": "BC",
          "COUNT": g.mfnInt(txtBC.text)
        });
        gameCountLimit.add({
          "GAME_CODE": game,
          "TYPE": "AC",
          "COUNT": g.mfnInt(txtAC.text)
        });
        gameCountLimit.add({
          "GAME_CODE": game,
          "TYPE": "A",
          "COUNT": g.mfnInt(txtA.text)
        });
        gameCountLimit.add({
          "GAME_CODE": game,
          "TYPE": "B",
          "COUNT": g.mfnInt(txtB.text)
        });
        gameCountLimit.add({
          "GAME_CODE": game,
          "TYPE": "C",
          "COUNT": g.mfnInt(txtC.text)
        });
        gameCountLimit.add({
          "GAME_CODE": game,
          "TYPE": "BOX",
          "COUNT": g.mfnInt(txtBox.text)
        });
      });
    }
    apiUpdateCount();
  }

  fnFill(value){
    if(mounted){
      setState(() {
        //{STATUS: 1, COMPANY: 01, USERCD: 1STK1, GAME_CODE: 1PM, TYPE: A, COUNT: 6},
        for(var e in value){
          var type  = ( e["TYPE"]??"").toString();
          if(type == "A"){
            txtA.text = e["COUNT"].toString();
          }else if(type == "B"){
            txtB.text = e["COUNT"].toString();
          }else if(type == "C"){
            txtC.text = e["COUNT"].toString();
          }else if(type == "AB"){
            txtAB.text = e["COUNT"].toString();
          }else if(type == "BC"){
            txtBC.text = e["COUNT"].toString();
          }else if(type == "AC"){
            txtAC.text = e["COUNT"].toString();
          }else if(type == "SUPER"){
            txtSup.text = e["COUNT"].toString();
          }else if(type == "BOX"){
            txtBox.text = e["COUNT"].toString();
          }
        }
      });
    }
  }

  //================================API CALL

  apiUpdateCount(){
    futureForm = apiCall.apiSaveGlobalGameCount(gameCountLimit);
    futureForm.then((value) => apiUpdateRateRes(value));
  }
  apiUpdateRateRes(value){
    if(mounted){
      setState(() {
        if(g.fnValCheck(value)){
          // [{STATUS: 0, MSG: USER NOT FOUND}]
          var sts  =  value[0]["STATUS"];
          var msg  =  value[0]["MSG"];
          if(sts == "1"){
            successMsg(context, "Done");
            blEdit =  false;
          }else{
            errorMsg(context, msg.toString());
          }
        }
      });
    }
  }

  apiGetDetails(){
    futureForm  = apiCall.apiGetGlobalDetails(g.wstrCompany, "COUNTLIMIT",g.wstrSelectedGame);
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
