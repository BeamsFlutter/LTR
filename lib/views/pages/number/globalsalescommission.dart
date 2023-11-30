

import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:ltr/controller/global/globalValues.dart';
import 'package:ltr/services/apiController.dart';
import 'package:ltr/views/components/common/common.dart';
import 'package:ltr/views/components/enum.dart';
import 'package:ltr/views/components/inputfield/commonTextField.dart';
import 'package:ltr/views/styles/colors.dart';

class GlobalSalesRate extends StatefulWidget {
  const GlobalSalesRate({Key? key}) : super(key: key);

  @override
  State<GlobalSalesRate> createState() => _GlobalSalesRateState();
}

class _GlobalSalesRateState extends State<GlobalSalesRate> {


  //Global
  var g = Global();
  var apiCall =  ApiCall();
  late Future<dynamic> futureForm ;

  //Page Variable
  var frSelectedUser = "";
  bool blEdit  = false;
  var gamePriceList = [];


  //Controller
  var txtSup = TextEditingController();
  var txtAB = TextEditingController();
  var txtA = TextEditingController();
  var txtBox = TextEditingController();


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
              decoration: boxBaseDecoration(g.wstrGameBColor, 0),
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
                  tcn("Global Sales Rate", Colors.white, 20)
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
            gapHC(10),
            Expanded(child: Padding(
              padding: const EdgeInsets.all(10),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    gapHC(15),
                    CustomTextField(
                      keybordType: TextInputType.number,
                      controller: txtSup,
                      editable: blEdit,
                      hintText: "Super",
                      textFormFieldType: TextFormFieldType.weeklyCreditLimit,

                    ),
                    gapHC(15),
                    CustomTextField(
                      keybordType: TextInputType.number,
                      controller: txtAB,
                      editable: blEdit,
                      hintText: "AB/BC/AC",
                      textFormFieldType: TextFormFieldType.weeklyCreditLimit,

                    ),
                    gapHC(15),
                    CustomTextField(
                      keybordType: TextInputType.number,
                      controller: txtA,
                      editable: blEdit,
                      hintText: "A/B/C",
                      textFormFieldType: TextFormFieldType.weeklyCreditLimit,

                    ),
                    gapHC(15),
                    CustomTextField(
                      keybordType: TextInputType.number,
                      controller: txtBox,
                      editable: blEdit,
                      hintText: "Box",
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
      setState(() {
        gamePriceList = [];
        gamePriceList.add({
          "GAME_CODE": "ALL",
          "TYPE": "SUPER",
          "PRICE": g.mfnDbl(txtSup.text)
        });
        gamePriceList.add({
          "GAME_CODE": "ALL",
          "TYPE": "AB",
          "PRICE": g.mfnDbl(txtAB.text)
        });
        gamePriceList.add({
          "GAME_CODE": "ALL",
          "TYPE": "BC",
          "PRICE": g.mfnDbl(txtAB.text)
        });
        gamePriceList.add({
          "GAME_CODE": "ALL",
          "TYPE": "AC",
          "PRICE": g.mfnDbl(txtAB.text)
        });
        gamePriceList.add({
          "GAME_CODE": "ALL",
          "TYPE": "A",
          "PRICE": g.mfnDbl(txtA.text)
        });
        gamePriceList.add({
          "GAME_CODE": "ALL",
          "TYPE": "B",
          "PRICE": g.mfnDbl(txtA.text)
        });
        gamePriceList.add({
          "GAME_CODE": "ALL",
          "TYPE": "C",
          "PRICE": g.mfnDbl(txtA.text)
        });
        gamePriceList.add({
          "GAME_CODE": "ALL",
          "TYPE": "BOX",
          "PRICE": g.mfnDbl(txtBox.text)
        });
      });
    }
    apiUpdateRate();
  }

  //================================API CALL

  apiUpdateRate(){
    futureForm = apiCall.apiUpdateGlobalGamePrice(gamePriceList);
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
    futureForm  = apiCall.apiGetGlobalDetails(g.wstrCompany,"PRICE",null);
    futureForm.then((value) => apiGetDetailsRes(value));
  }
  apiGetDetailsRes(value){
    if(mounted){
      if(g.fnValCheck(value)){

        try{
          setState(() {
            for(var e  in value){
              var type = e["TYPE"];
              if(type == "SUPER"){
                txtSup.text = g.mfnDbl(e["PRICE"].toString()).toString();
              }else if(type == "BOX"){
                txtBox.text = g.mfnDbl(e["PRICE"].toString()).toString();
              }else if(type == "AB"){
                txtAB.text = g.mfnDbl(e["PRICE"].toString()).toString();
              }else if(type == "A"){
                txtA.text = g.mfnDbl(e["PRICE"].toString()).toString();
              }
            }
          });
        }catch(e){
          dprint(e);
        }

      }
    }
  }
}
