
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:ltr/controller/global/globalValues.dart';
import 'package:ltr/services/apiController.dart';
import 'package:ltr/views/components/alertDialog/alertDialog.dart';
import 'package:ltr/views/components/common/common.dart';
import 'package:ltr/views/components/enum.dart';
import 'package:ltr/views/components/inputfield/commonTextField.dart';
import 'package:ltr/views/styles/colors.dart';
import 'package:share_plus/share_plus.dart';

class PublishResult extends StatefulWidget {
  const PublishResult({Key? key}) : super(key: key);

  @override
  State<PublishResult> createState() => _PublishResultState();
}

class _PublishResultState extends State<PublishResult> {

  //Global
  var g = Global();
  var apiCall =  ApiCall();
  late Future<dynamic> futureForm;

  //Page Variable
  var blEdit =  false;
  var blPostSts =  false;
  var blOldEdit =  false;
  var wstrPageMode =  "VIEW";
  var fResDate = DateTime.now();
  var frResultData = [];
  var frGameData  =[];
  var frCapthaKey  = "";

  List<TextEditingController>  txtControllerList = [];

  //Game Details

  var gDocno = "";
  var gDoctype = "";
  var gGameCode = "";

  //Controller
  var txtP1 = TextEditingController();
  var txtP2 = TextEditingController();
  var txtP3 = TextEditingController();
  var txtP4 = TextEditingController();
  var txtP5 = TextEditingController();

  var txtP6 = TextEditingController();
  var txtP7 = TextEditingController();
  var txtP8 = TextEditingController();
  var txtP9 = TextEditingController();
  var txtP10 = TextEditingController();


  var txtP11 = TextEditingController();
  var txtP12 = TextEditingController();
  var txtP13 = TextEditingController();
  var txtP14 = TextEditingController();
  var txtP15 = TextEditingController();

  var txtP16 = TextEditingController();
  var txtP17 = TextEditingController();
  var txtP18 = TextEditingController();
  var txtP19 = TextEditingController();
  var txtP20 = TextEditingController();

  var txtP21 = TextEditingController();
  var txtP22 = TextEditingController();
  var txtP23 = TextEditingController();
  var txtP24 = TextEditingController();
  var txtP25 = TextEditingController();

  var txtP26 = TextEditingController();
  var txtP27 = TextEditingController();
  var txtP28 = TextEditingController();
  var txtP29 = TextEditingController();
  var txtP30 = TextEditingController();

  var txtP31 = TextEditingController();
  var txtP32 = TextEditingController();
  var txtP33 = TextEditingController();
  var txtP34 = TextEditingController();
  var txtP35 = TextEditingController();


  var txtCaptcha = TextEditingController();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fnGetPageData();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: MediaQuery.of(context).padding,
        decoration: boxBaseDecoration(Colors.white, 0),
        child: Column(
          children: [
             Row(),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 13,horizontal: 5),
              decoration: boxBaseDecoration( blOldEdit? Colors.redAccent: g.wstrGameBColor, 0),
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
                      blOldEdit?
                      tcn("Old Result Entry", Colors.white, 18):
                      tcn("Publish Result (${g.wstrSelectedGame.toString()})", Colors.white, 18),
                    ],
                  ),
                  GestureDetector(
                    onTap: (){

                      PageDialog().cDialog(context, "Update", "Do you want to edit old result entry?",(){
                        fnShowCaptcha(fnOldEditCaptchaSuccess);
                      });
                    },
                    child: const Icon(Icons.history,color: Colors.white,size: 22,),
                  )
                  // wstrPageMode == "VIEW" && blPostSts && frResultData.isNotEmpty?
                  // GestureDetector(
                  //   onTap: (){
                  //     fnShare();
                  //   },
                  //   child: Container(
                  //     padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 5),
                  //     decoration: boxDecoration(Colors.white, 30),
                  //     child: Row(
                  //       children: [
                  //         tcn('Share', grey, 15),
                  //         gapWC(5),
                  //         const Icon(Icons.share_outlined,color: grey,size: 15,)
                  //       ],
                  //     ),
                  //   ),
                  // ):gapWC(5),
                ],
              ),
            ),
            gapHC(5),
            GestureDetector(
              onTap: (){
                _selectResultDate(context);
              },
              child: Container(
                margin: const EdgeInsets.all(5),
                padding: const EdgeInsets.all(10),
                decoration: boxDecoration(Colors.white, 10),
                child:Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.calendar_month,color: Colors.black,size: 15,),
                        gapWC(10),
                        tcn('Choose Date', Colors.black, 13),
                      ],
                    ),
                    tc(setDate(6, fResDate), Colors.black, 13)
                  ],
                )
              ),
            ),
            gapHC(10),
            Expanded(child:  Container(
              padding: EdgeInsets.all(10),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    CustomTextField(
                      keybordType: TextInputType.number,
                      controller: txtP1,
                      editable: blEdit,
                      hintText: "1st",
                      textFormFieldType: TextFormFieldType.gift,
                    ),
                    gapHC(5),
                    CustomTextField(
                      keybordType: TextInputType.number,
                      controller: txtP2,
                      editable: blEdit,
                      hintText: "2nd",
                      textFormFieldType: TextFormFieldType.gift,
                    ),
                    gapHC(5),
                    CustomTextField(
                      keybordType: TextInputType.number,
                      controller: txtP3,
                      editable: blEdit,
                      hintText: "3rd",
                      textFormFieldType: TextFormFieldType.gift,
                    ),
                    gapHC(5),
                    CustomTextField(
                      keybordType: TextInputType.number,
                      controller: txtP4,
                      editable: blEdit,
                      hintText: "4th",
                      textFormFieldType: TextFormFieldType.gift,
                    ),
                    gapHC(5),
                    CustomTextField(
                      keybordType: TextInputType.number,
                      controller: txtP5,
                      editable: blEdit,
                      hintText: "5th",
                      textFormFieldType: TextFormFieldType.gift,
                    ),
                    gapHC(10),
                    tcn('COMPLIMENTS', Colors.black, 13),
                    gapHC(10),
                    Row(
                      children: [
                        Expanded(child: CustomTextField(
                          keybordType: TextInputType.number,
                          controller: txtP6,
                          editable: blEdit,
                          hintText: "1",
                          textFormFieldType: TextFormFieldType.gift,
                        ),),
                        gapWC(5),
                        Expanded(child: CustomTextField(
                          keybordType: TextInputType.number,
                          controller: txtP7,
                          editable: blEdit,
                          hintText: "2",
                          textFormFieldType: TextFormFieldType.gift,
                        ),),
                        gapWC(5),
                        Expanded(child: CustomTextField(
                          keybordType: TextInputType.number,
                          controller: txtP8,
                          editable: blEdit,
                          hintText: "3",
                          textFormFieldType: TextFormFieldType.gift,
                        ),),
                      ],
                    ),
                    gapHC(5),
                    Row(
                      children: [
                        Expanded(child: CustomTextField(
                          keybordType: TextInputType.number,
                          controller: txtP9,
                          editable: blEdit,
                          hintText: "4",
                          textFormFieldType: TextFormFieldType.gift,
                        ),),
                        gapWC(5),
                        Expanded(child: CustomTextField(
                          keybordType: TextInputType.number,
                          controller: txtP10,
                          editable: blEdit,
                          hintText: "5",
                          textFormFieldType: TextFormFieldType.gift,
                        ),),
                        gapWC(5),
                        Expanded(child: CustomTextField(
                          keybordType: TextInputType.number,
                          controller: txtP11,
                          editable: blEdit,
                          hintText: "6",
                          textFormFieldType: TextFormFieldType.gift,
                        ),),
                      ],
                    ),
                    gapHC(5),
                    Row(
                      children: [
                        Expanded(child: CustomTextField(
                          keybordType: TextInputType.number,
                          controller: txtP12,
                          editable: blEdit,
                          hintText: "7",
                          textFormFieldType: TextFormFieldType.gift,
                        ),),
                        gapWC(5),
                        Expanded(child: CustomTextField(
                          keybordType: TextInputType.number,
                          controller: txtP13,
                          editable: blEdit,
                          hintText: "8",
                          textFormFieldType: TextFormFieldType.gift,
                        ),),
                        gapWC(5),
                        Expanded(child: CustomTextField(
                          keybordType: TextInputType.number,
                          controller: txtP14,
                          editable: blEdit,
                          hintText: "9",
                          textFormFieldType: TextFormFieldType.gift,
                        ),),
                      ],
                    ),
                    gapHC(5),
                    Row(
                      children: [
                        Expanded(child: CustomTextField(
                          keybordType: TextInputType.number,
                          controller: txtP15,
                          editable: blEdit,
                          hintText: "10",
                          textFormFieldType: TextFormFieldType.gift,
                        ),),
                        gapWC(5),
                        Expanded(child: CustomTextField(
                          keybordType: TextInputType.number,
                          controller: txtP16,
                          editable: blEdit,
                          hintText: "11",
                          textFormFieldType: TextFormFieldType.gift,
                        ),),
                        gapWC(5),
                        Expanded(child: CustomTextField(
                          keybordType: TextInputType.number,
                          controller: txtP17,
                          editable: blEdit,
                          hintText: "12",
                          textFormFieldType: TextFormFieldType.gift,
                        ),),
                      ],
                    ),
                    gapHC(5),
                    Row(
                      children: [
                        Expanded(child: CustomTextField(
                          keybordType: TextInputType.number,
                          controller: txtP18,
                          editable: blEdit,
                          hintText: "13",
                          textFormFieldType: TextFormFieldType.gift,
                        ),),
                        gapWC(5),
                        Expanded(child: CustomTextField(
                          keybordType: TextInputType.number,
                          controller: txtP19,
                          editable: blEdit,
                          hintText: "14",
                          textFormFieldType: TextFormFieldType.gift,
                        ),),
                        gapWC(5),
                        Expanded(child: CustomTextField(
                          keybordType: TextInputType.number,
                          controller: txtP20,
                          editable: blEdit,
                          hintText: "15",
                          textFormFieldType: TextFormFieldType.gift,
                        ),),
                      ],
                    ),
                    gapHC(5),
                    Row(
                      children: [
                        Expanded(child: CustomTextField(
                          keybordType: TextInputType.number,
                          controller: txtP21,
                          editable: blEdit,
                          hintText: "16",
                          textFormFieldType: TextFormFieldType.gift,
                        ),),
                        gapWC(5),
                        Expanded(child: CustomTextField(
                          keybordType: TextInputType.number,
                          controller: txtP22,
                          editable: blEdit,
                          hintText: "17",
                          textFormFieldType: TextFormFieldType.gift,
                        ),),
                        gapWC(5),
                        Expanded(child: CustomTextField(
                          keybordType: TextInputType.number,
                          controller: txtP23,
                          editable: blEdit,
                          hintText: "18",
                          textFormFieldType: TextFormFieldType.gift,
                        ),),
                      ],
                    ),
                    gapHC(5),
                    Row(
                      children: [
                        Expanded(child: CustomTextField(
                          keybordType: TextInputType.number,
                          controller: txtP24,
                          editable: blEdit,
                          hintText: "19",
                          textFormFieldType: TextFormFieldType.gift,
                        ),),
                        gapWC(5),
                        Expanded(child: CustomTextField(
                          keybordType: TextInputType.number,
                          controller: txtP25,
                          editable: blEdit,
                          hintText: "20",
                          textFormFieldType: TextFormFieldType.gift,
                        ),),
                        gapWC(5),
                        Expanded(child: CustomTextField(
                          keybordType: TextInputType.number,
                          controller: txtP26,
                          editable: blEdit,
                          hintText: "21",
                          textFormFieldType: TextFormFieldType.gift,
                        ),),
                      ],
                    ),
                    gapHC(5),
                    Row(
                      children: [
                        Expanded(child: CustomTextField(
                          keybordType: TextInputType.number,
                          controller: txtP27,
                          editable: blEdit,
                          hintText: "22",
                          textFormFieldType: TextFormFieldType.gift,
                        ),),
                        gapWC(5),
                        Expanded(child: CustomTextField(
                          keybordType: TextInputType.number,
                          controller: txtP28,
                          editable: blEdit,
                          hintText: "23",
                          textFormFieldType: TextFormFieldType.gift,
                        ),),
                        gapWC(5),
                        Expanded(child: CustomTextField(
                          keybordType: TextInputType.number,
                          controller: txtP29,
                          editable: blEdit,
                          hintText: "24",
                          textFormFieldType: TextFormFieldType.gift,
                        ),),
                      ],
                    ),
                    gapHC(5),
                    Row(
                      children: [
                        Expanded(child: CustomTextField(
                          keybordType: TextInputType.number,
                          controller: txtP30,
                          editable: blEdit,
                          hintText: "25",
                          textFormFieldType: TextFormFieldType.gift,
                        ),),
                        gapWC(5),
                        Expanded(child: CustomTextField(
                          keybordType: TextInputType.number,
                          controller: txtP31,
                          editable: blEdit,
                          hintText: "26",
                          textFormFieldType: TextFormFieldType.gift,
                        ),),
                        gapWC(5),
                        Expanded(child: CustomTextField(
                          keybordType: TextInputType.number,
                          controller: txtP32,
                          editable: blEdit,
                          hintText: "27",
                          textFormFieldType: TextFormFieldType.gift,
                        ),),
                      ],
                    ),
                    gapHC(5),

                    Row(
                      children: [
                        Expanded(child: CustomTextField(
                          keybordType: TextInputType.number,
                          controller: txtP33,
                          editable: blEdit,
                          hintText: "28",
                          textFormFieldType: TextFormFieldType.gift,
                        ),),
                        gapWC(5),
                        Expanded(child: CustomTextField(
                          keybordType: TextInputType.number,
                          controller: txtP34,
                          editable: blEdit,
                          hintText: "29",
                          textFormFieldType: TextFormFieldType.gift,
                        ),),
                        gapWC(5),
                        Expanded(child: CustomTextField(
                          keybordType: TextInputType.number,
                          controller: txtP35,
                          editable: blEdit,
                          hintText: "30",
                          textFormFieldType: TextFormFieldType.gift,
                        ),),
                      ],
                    ),
                    gapHC(5),
                  ],
                ),
              ),
            )),
            gapHC(5),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: wstrPageMode == "VIEW" && blPostSts && frResultData.isNotEmpty?
              Row(
                children: [
                  blOldEdit?
                  Expanded(child: Bounce(
                    onPressed: (){
                      PageDialog().cDialog(context, "Update", "Do you want to update old result?\nit will directly effect all reports", fnUpdate);
                    },
                    duration: const Duration(milliseconds: 110),
                    child: Container(
                      decoration: boxDecoration(bgColorDark, 30),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.done,color: g.wstrGameOTColor,size: 15,),
                          gapWC(5),
                          tcn('UPDATE', g.wstrGameOTColor, 15)
                        ],
                      ),
                    ),
                  ),):gapWC(0),
                  blOldEdit?
                  gapWC(10):gapWC(0),
                  Expanded(child: Bounce(
                    onPressed: (){

                      PageDialog().unPostDialog(context, (){
                        fnShowCaptcha(fnUnPost);
                      });
                    },
                    duration: const Duration(milliseconds: 110),
                    child: Container(
                      decoration: boxDecoration(Colors.redAccent, 30),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.public_off,color: g.wstrGameOTColor,size: 15,),
                          gapWC(5),
                          tcn('UN PUBLISH', g.wstrGameOTColor, 15)
                        ],
                      ),
                    ),
                  ),),
                ],
              ):
              wstrPageMode == "VIEW" && !blPostSts && frResultData.isNotEmpty?
              Row(
                children: [
                  blOldEdit?
                  Expanded(child: Bounce(
                    onPressed: (){
                      PageDialog().cDialog(context, "Update", "Do you want to update old result?\nit will directly effect all reports", fnUpdate);
                    },
                    duration: const Duration(milliseconds: 110),
                    child: Container(
                      decoration: boxDecoration(bgColorDark, 30),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.done,color: g.wstrGameOTColor,size: 15,),
                          gapWC(5),
                          tcn('UPDATE', g.wstrGameOTColor, 15)
                        ],
                      ),
                    ),
                  ),):gapWC(0),
                  blOldEdit?
                  gapWC(10):gapWC(0),
                  Expanded(child: Bounce(
                    onPressed: (){

                      PageDialog().postDialog(context, fnPost);
                    },
                    duration: const Duration(milliseconds: 110),
                    child: Container(
                      decoration: boxDecoration(Colors.redAccent, 30),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.public,color: g.wstrGameOTColor,size: 15,),
                          gapWC(5),
                          tcn('PUBLISH', g.wstrGameOTColor, 15)
                        ],
                      ),
                    ),
                  ),),
                ],
              ):
              gDocno.isNotEmpty && !blOldEdit?
              Row(
                children: [
                  Expanded(child: Bounce(
                    onPressed: (){
                      fnSave();
                    },
                    duration: const Duration(milliseconds: 110),
                    child: Container(
                      decoration: boxDecoration(g.wstrGameBColor, 30),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.task_alt,color: g.wstrGameOTColor,size: 15,),
                          gapWC(5),
                          tcn('Save', g.wstrGameOTColor, 15)
                        ],
                      ),
                    ),
                  ),),
                  Bounce(
                    onPressed: (){
                      fnCancel();
                    },
                    duration: const Duration(milliseconds: 110),
                    child: Container(
                      decoration: boxBaseDecoration(greyLight, 30),
                      padding: const EdgeInsets.symmetric(vertical: 12,horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.cancel_outlined,color: Colors.black,size: 15,),
                          gapWC(5),
                          tcn('Cancel', Colors.black, 12)
                        ],
                      ),
                    ),
                  ),
                ],
              ):gapHC(5),
            )
          ],
        ),
      )
    );
  }

  //====================================WIDGET
  //====================================PAGE FN

  Future<void> _selectResultDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: fResDate,
        firstDate: DateTime(2020),
        lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: g.wstrGameColor,
            ),
          ),
          child: child!,
        );
      },
    );
    if (pickedDate != null && pickedDate != fResDate) {
      setState(() {
        fResDate = pickedDate;
      });

    }
    apiGetResultData();
  }

  fnGetPageData(){
    if(mounted){
      setState(() {
        txtControllerList = [
          txtP1,
          txtP2,
          txtP3,
          txtP4,
          txtP5,
          txtP6,
          txtP7,
          txtP8,
          txtP9,
          txtP10,
          txtP11,
          txtP12,
          txtP13,
          txtP14,
          txtP15,
          txtP16,
          txtP17,
          txtP18,
          txtP19,
          txtP20,
          txtP21,
          txtP22,
          txtP23,
          txtP24,
          txtP25,
          txtP26,
          txtP27,
          txtP28,
          txtP29,
          txtP29
        ];
      });
    }
    apiGetResultData();
  }

  fnCancel(){
    Navigator.pop(context);
  }

  fnSave(){
    var errorSts= false;
    for(var e  in txtControllerList){
      dprint(e.text);
      if(e.text.isEmpty){
        errorSts = true;
      }
    }

    if(gDocno.isEmpty){
      errorMsg(context, "Choose Valid Game Date");
      return;
    }

    if(errorSts){
      errorMsg(context, "Fill Result");
      return;
    }

    var det = [];
    var rank = 1;
    for(var e in txtControllerList){
      det.add( {
        "RANK": rank,
        "NUMBER": e.text
      });
      rank = rank+1;
    }
    apiSaveResult(det);

  }

  fnPost(){
    Navigator.pop(context);
    if(gDocno.isEmpty){
      errorMsg(context, "Choose Valid Game Date");
      return;
    }
    var det = [];
    var rank = 1;
    for(var e in txtControllerList){
      det.add( {
        "RANK": rank,
        "NUMBER": e.text
      });
      rank = rank+1;
    }
    apiPostResult(det,1);
  }

  fnUnPost(){
    Navigator.pop(context);
    if(gDocno.isEmpty){
      errorMsg(context, "Choose Valid Game Date");
      return;
    }
    var det = [];
    var rank = 1;
    for(var e in txtControllerList){
      det.add( {
        "RANK": rank,
        "NUMBER": e.text
      });
      rank = rank+1;
    }
    apiPostResult(det,0);
  }

  fnUpdate(){
    Navigator.pop(context);
    if(gDocno.isEmpty){
      errorMsg(context, "Choose Valid Game Date");
      return;
    }
    var det = [];
    var rank = 1;
    for(var e in txtControllerList){
      det.add( {
        "RANK": rank,
        "NUMBER": e.text
      });
      rank = rank+1;
    }
    apiPostResult(det,blPostSts?1:0);
  }

  fnFill(){
    if(mounted){
      setState(() {
        blEdit = blOldEdit;
        dprint(blOldEdit.toString());
        dprint(blEdit.toString());
        var rank = 0;
        for(var e in frResultData){
          if(e["RANK"].toString() == (rank+1).toString()){
            txtControllerList[rank].text =  (e["NUMBER"]??"").toString();
          }
          rank = rank+1;
        }
      });
    }
  }

  fnClear(){
   if(mounted){
     setState(() {
       gDocno = "";
       gDoctype = "";
       wstrPageMode = "ADD";
       blPostSts = false;
       blEdit = true;

       for(var e in txtControllerList){
         e.clear();
       }
     });
   }
  }

  fnShare() {
    Share.share('check out my website https://example.com');
  }

  fnShowCaptcha(fnSuccessCall){
    var rng = Random();
    var code = rng.nextInt(900000) + 100000;
    setState(() {
      frCapthaKey = code.toString();
      txtCaptcha.clear();
    });
    Navigator.pop(context);
    PageDialog().showCaptcha(context, 
        Container(
          child: Column(
            children: [
              Row(),
              tc('KEY $frCapthaKey', Colors.black, 15),
              gapHC(5),
              CustomTextField(
                keybordType: TextInputType.number,
                controller: txtCaptcha,
                hintText: "Captcha",
                textFormFieldType: TextFormFieldType.gift,
              ),
              gapHC(15),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 7,horizontal: 10),
                      decoration: boxBaseDecoration(greyLight, 30),
                      child: tcn('Cancel', Colors.black, 15),
                    ),
                  ),
                  gapWC(5),
                  GestureDetector(
                    onTap: (){
                      if(txtCaptcha.text == frCapthaKey){
                        fnSuccessCall();

                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 7,horizontal: 35),
                      decoration: boxBaseDecoration(Colors.blueGrey, 30),
                      child: tcn('OK', Colors.white, 15),
                    ),
                  )

                ],
              )

            ],
          ),
        ),
        "Captcha");
  }

  fnOldEditCaptchaSuccess(){
    if(mounted){
      setState(() {
        blOldEdit = true;
      });
      Navigator.pop(context);
      apiGetResultData();
    }
  }


  //====================================API CALL

  apiGetGame(){
    futureForm =  ApiCall().apiGetGame(g.wstrSelectedGame, setDate(2, fResDate));
    futureForm.then((value) => apiGetGameRes(value));
  }
  apiGetGameRes(value){
    if(mounted){
      setState(() {
        frGameData = [];
        gDocno = "";
        gDoctype = "";
        gGameCode = "";
      });
      if(g.fnValCheck(value)){
        setState(() {
          frGameData =  value;
          gDocno = (value[0]["DOCNO"]??"").toString();
          gDoctype = (value[0]["DOCTYPE"]??"").toString();
          gGameCode = (value[0]["GAME_CODE"]??"").toString();
        });
      }
    }
  }

  apiGetResultData(){
    fnClear();
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
          var docno = (header["GAME_DOCNO"]??"").toString();
          var doctype = (header["GAME_DOCTYPE"]??"").toString();
          var postSts = (header["PUB_STATUS"]??"").toString();

          setState(() {
            gDocno = docno;
            gDoctype = doctype;
            wstrPageMode = "VIEW";
            frResultData = det??[];
            blPostSts = postSts == "1"?true:false;
            blEdit = false;
          });
          fnFill();
        }else{

          setState(() {
            gDocno = "";
            gDoctype = "";
            wstrPageMode = "ADD";
            blPostSts = false;
            blEdit = true;
          });
          apiGetGame();
        }
      }
    }
  }

  apiSaveResult(det){
    futureForm = apiCall.apiSaveResult(gDocno, setDate(2, DateTime.now()), 0, g.wstrUserCd, "ADD", det);
    futureForm.then((value) => apiSaveResultRes(value));
  }
  apiSaveResultRes(value){
    if(mounted){
      if(g.fnValCheck(value)){
        // [{STATUS: 0, MSG: USER NOT FOUND}]
        var sts  =  value[0]["STATUS"];
        var msg  =  value[0]["MSG"];
        if(sts == "1"){
          successMsg(context, "Saved Successfully!");
          setState(() {
            blOldEdit =false;
          });
          apiGetResultData();
        }else{
          errorMsg(context, msg.toString());
        }
      }
    }
  }

  apiPostResult(det,post){

    futureForm = apiCall.apiSaveResult(gDocno, setDate(2, DateTime.now()), post, g.wstrUserCd, "EDIT", det);
    futureForm.then((value) => apiPostResultRes(value));
  }
  apiPostResultRes(value){
    if(mounted){
      if(g.fnValCheck(value)){
        // [{STATUS: 0, MSG: USER NOT FOUND}]
        var sts  =  value[0]["STATUS"];
        var msg  =  value[0]["MSG"];
        if(sts == "1"){
          successMsg(context, "Updated Successfully!");
          setState(() {
            blOldEdit =false;
          });
          apiGetResultData();
        }else{
          errorMsg(context, msg.toString());
        }
      }
    }
  }



}
