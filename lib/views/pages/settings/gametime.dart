

import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:ltr/controller/global/globalValues.dart';
import 'package:ltr/services/apiController.dart';
import 'package:ltr/views/components/common/common.dart';
import 'package:ltr/views/components/enum.dart';
import 'package:ltr/views/components/inputfield/commonTextField.dart';
import 'package:ltr/views/styles/colors.dart';

class GameTimeSettings extends StatefulWidget {
  const GameTimeSettings({Key? key}) : super(key: key);

  @override
  State<GameTimeSettings> createState() => _GameTimeSettingsState();
}

class _GameTimeSettingsState extends State<GameTimeSettings> {

  //Global
  var g = Global();
  var apiCall  = ApiCall();
  late Future<dynamic> futureForm;


  //Page Variable
  TimeOfDay frTimeFrom =const TimeOfDay(hour: 7, minute: 15);
  TimeOfDay frTimeTo =const TimeOfDay(hour: 7, minute: 15);

  var lstrTimeFrom = "";
  var lstrTimeTo = "";
  var lstrEditMinutes = "";

  bool blEdit  = false;


  //Controller
  var txtEditMinutes  = TextEditingController();


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

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
                  tcn("Game Time (${g.wstrSelectedGame.toString()})", Colors.white, 20)
                ],
              ),
            ),
            gapHC(5),
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
                        decoration: blEdit?boxDecoration( bgColorDark, 30):boxBaseDecoration( Colors.white, 30),
                        child: const Icon(Icons.done,color: Colors.white,size: 13,),
                      ),
                    ),
                    gapWC(10),
                    tcn('Editable',blEdit? Colors.black: Colors.grey, 15)
                  ],
                ),
              ),
            ),
            gapHC(5),
           Expanded(child: Container(
             padding: EdgeInsets.all(10),
             child: Column(
               children: [
                 GestureDetector(
                   onTap: (){
                     if(blEdit){
                       _selectTimeFrom(context);
                     }
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
                             const Icon(Icons.access_time,color: grey,size: 18,),
                             gapWC(5),
                             tcn('From Time', grey, 15),
                           ],
                         ),
                         tcn(lstrTimeFrom.toString(), Colors.black, 15)
                       ],
                     ),
                   ),
                 ),
                 gapHC(5),
                 GestureDetector(
                   onTap: (){
                     if(blEdit){
                       _selectTimeTo(context);
                     }
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
                             const Icon(Icons.access_time,color: grey,size: 18,),
                             gapWC(5),
                             tcn('To Time', grey, 15),
                           ],
                         ),
                         tcn(lstrTimeTo.toString(), Colors.black, 15)
                       ],
                     ),
                   ),
                 ),
                 gapHC(10),
                 CustomTextField(
                   keybordType: TextInputType.number,
                   controller: txtEditMinutes,
                   editable: blEdit,
                   maxCount: 4,
                   hintText: "Edit minutes",
                   textFormFieldType: TextFormFieldType.gift,
                 ),
               ],
             ),
           )),
            gapHC(10),
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

  //============================================WIDGET
  //============================================PAGE FN

  fnGetPageData(){
    if(mounted){
      apiGetGameMast();

    }
  }


  Future<void> _selectTimeFrom(BuildContext context) async {
    final TimeOfDay? newTime = await showTimePicker(
      context: context,
      initialTime: frTimeFrom,
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child!,
        );
      },
    );
    if (newTime != null) {
      setState(() {
        frTimeFrom = newTime;
        lstrTimeFrom = "${frTimeFrom.hour}:${frTimeTo.minute}:00";
      });
    }
  }
  Future<void> _selectTimeTo(BuildContext context) async {
    final TimeOfDay? newTime = await showTimePicker(
      context: context,
      initialTime: frTimeTo,
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child!,
        );
      },
    );
    if (newTime != null) {
      setState(() {
        frTimeTo = newTime;
        lstrTimeTo = "${frTimeTo.hour}:${frTimeTo.minute}:00";
      });
    }
  }
  fnUpdate(){
    apiUpdateGameMast();
  }
  //============================================API CALL

  apiUpdateGameMast(){
    var from  =  lstrTimeFrom.isEmpty?null:lstrTimeFrom;
    var to  =  lstrTimeTo.isEmpty?null:lstrTimeTo;
    futureForm = apiCall.apiUpdateGameMast(g.wstrSelectedGame, from, to, txtEditMinutes.text);
    futureForm.then((value) => apiUpdateGameMastRes(value));

  }
  apiUpdateGameMastRes(value){
    if(mounted){
      setState(() {
        if(g.fnValCheck(value)){
          // [{STATUS: 0, MSG: USER NOT FOUND}]
          var sts  =  value["STATUS"];
          var msg  =  value["MSG"];
          if(sts == "1"){
            successMsg(context, "Done");
            apiGetGameMast();
            blEdit =  false;
          }else{
            errorMsg(context, msg.toString());
          }
        }
      });
    }
  }

  apiGetGameMast(){
    futureForm = apiCall.apiGetGameMast(g.wstrSelectedGame);
    futureForm.then((value) => apiGetGameMastRes(value));
  }
  apiGetGameMastRes(value){
    if(mounted){
      setState(() {
        lstrTimeFrom = "";
        lstrTimeTo = "";
        lstrEditMinutes = "";
        txtEditMinutes.text = "";
      });
      if(g.fnValCheck(value)){
        setState(() {
          lstrTimeFrom = g.mfnTxt(value["START_TIME"]);
          lstrTimeTo = g.mfnTxt(value["END_TIME"]);
          lstrEditMinutes = g.mfnTxt(value["EDIT_MINUT"]);
          txtEditMinutes.text = lstrEditMinutes;
        });
      }
    }
  }


}
