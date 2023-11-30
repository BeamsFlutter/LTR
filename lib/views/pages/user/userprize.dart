
import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:ltr/controller/global/globalValues.dart';
import 'package:ltr/services/apiController.dart';
import 'package:ltr/views/components/common/common.dart';
import 'package:ltr/views/components/enum.dart';
import 'package:ltr/views/components/inputfield/commonTextField.dart';
import 'package:ltr/views/styles/colors.dart';

class UserPrize extends StatefulWidget {
  final String pUserCode;
  const UserPrize({Key? key, required this.pUserCode}) : super(key: key);

  @override
  State<UserPrize> createState() => _UserPrizeState();
}

class _UserPrizeState extends State<UserPrize> {

  //Global
  var g = Global();
  var apiCall =  ApiCall();
  late Future<dynamic> futureForm ;

  //Page Variable
  var frSelectedUser = "";
  bool blEdit  = false;
  var prizeList = [];



  //Controller
  var txtSup1p = TextEditingController();
  var txtSup1c = TextEditingController();

  var txtSup2p = TextEditingController();
  var txtSup2c = TextEditingController();

  var txtSup3p = TextEditingController();
  var txtSup3c = TextEditingController();

  var txtSup4p = TextEditingController();
  var txtSup4c = TextEditingController();

  var txtSup5p = TextEditingController();
  var txtSup5c = TextEditingController();

  var txtSup6p = TextEditingController();
  var txtSup6c = TextEditingController();

  var txtAB1p = TextEditingController();
  var txtAB1c = TextEditingController();

  var txtA1p = TextEditingController();
  var txtA1c = TextEditingController();

  var txtBox3d1p = TextEditingController();
  var txtBox3d1c = TextEditingController();

  var txtBox3d2p = TextEditingController();
  var txtBox3d2c = TextEditingController();

  var txtBox2s1p = TextEditingController();
  var txtBox2s1c = TextEditingController();

  var txtBox2s2p = TextEditingController();
  var txtBox2s2c = TextEditingController();

  var txtBox3s1p = TextEditingController();
  var txtBox3s1c = TextEditingController();

  var txtBox3s2p = TextEditingController();
  var txtBox3s2c = TextEditingController();

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
                  tcn("Prize & Commission", Colors.white, 20)
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
            Expanded(child: Container(
              padding: const EdgeInsets.all(10),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: boxBaseDecoration(Colors.green.withOpacity(0.2), 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          tcn('Super', Colors.black, 18),
                          gapHC(10),
                          Row(
                            children: [
                              Expanded(child: CustomTextField(
                                keybordType: TextInputType.number,
                                controller: txtSup1p,
                                editable: blEdit,
                                hintText: "1st Prize",
                                textFormFieldType: TextFormFieldType.weeklyCreditLimit,

                              ),),
                              gapWC(10),
                              Expanded(child: CustomTextField(
                                keybordType: TextInputType.number,
                                controller: txtSup1c,
                                editable: blEdit,
                                hintText: "Commission",
                                textFormFieldType: TextFormFieldType.weeklyCreditLimit,

                              ),)
                            ],
                          ),
                          gapHC(10),
                          Row(
                            children: [
                              Expanded(child: CustomTextField(
                                keybordType: TextInputType.number,
                                controller: txtSup2p,
                                editable: blEdit,
                                hintText: "2nd Prize",
                                textFormFieldType: TextFormFieldType.weeklyCreditLimit,

                              ),),
                              gapWC(10),
                              Expanded(child: CustomTextField(
                                keybordType: TextInputType.number,
                                controller: txtSup2c,
                                editable: blEdit,
                                hintText: "Commission",
                                textFormFieldType: TextFormFieldType.weeklyCreditLimit,

                              ),)
                            ],
                          ),
                          gapHC(10),
                          Row(
                            children: [
                              Expanded(child: CustomTextField(
                                keybordType: TextInputType.number,
                                controller: txtSup3p,
                                editable: blEdit,
                                hintText: "3rd Prize",
                                textFormFieldType: TextFormFieldType.weeklyCreditLimit,

                              ),),
                              gapWC(10),
                              Expanded(child: CustomTextField(
                                keybordType: TextInputType.number,
                                controller: txtSup3c,
                                editable: blEdit,
                                hintText: "Commission",
                                textFormFieldType: TextFormFieldType.weeklyCreditLimit,

                              ),)
                            ],
                          ),
                          gapHC(10),
                          Row(
                            children: [
                              Expanded(child: CustomTextField(
                                keybordType: TextInputType.number,
                                controller: txtSup4p,
                                editable: blEdit,
                                hintText: "4th Prize",
                                textFormFieldType: TextFormFieldType.weeklyCreditLimit,

                              ),),
                              gapWC(10),
                              Expanded(child: CustomTextField(
                                keybordType: TextInputType.number,
                                controller: txtSup4c,
                                editable: blEdit,
                                hintText: "Commission",
                                textFormFieldType: TextFormFieldType.weeklyCreditLimit,

                              ),)
                            ],
                          ),
                          gapHC(10),
                          Row(
                            children: [
                              Expanded(child: CustomTextField(
                                keybordType: TextInputType.number,
                                controller: txtSup5p,
                                editable: blEdit,
                                hintText: "5th Prize",
                                textFormFieldType: TextFormFieldType.weeklyCreditLimit,

                              ),),
                              gapWC(10),
                              Expanded(child: CustomTextField(
                                keybordType: TextInputType.number,
                                controller: txtSup5c,
                                editable: blEdit,
                                hintText: "Commission",
                                textFormFieldType: TextFormFieldType.weeklyCreditLimit,

                              ),)
                            ],
                          ),
                          gapHC(10),
                          tcn('LSK 30', Colors.black, 18),
                          gapHC(10),
                          Row(
                            children: [
                              Expanded(child: CustomTextField(
                                keybordType: TextInputType.number,
                                controller: txtSup6p,
                                editable: blEdit,
                                hintText: "6th Prize",
                                textFormFieldType: TextFormFieldType.weeklyCreditLimit,

                              ),),
                              gapWC(10),
                              Expanded(child: CustomTextField(
                                keybordType: TextInputType.number,
                                controller: txtSup6c,
                                editable: blEdit,
                                hintText: "Commission",
                                textFormFieldType: TextFormFieldType.weeklyCreditLimit,

                              ),)
                            ],
                          ),
                        ],
                      ),
                    ),
                    gapHC(15),
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: boxBaseDecoration(Colors.blue.withOpacity(0.2), 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          tcn('AB/BC/AC', Colors.black, 18),
                          gapHC(10),
                          Row(
                            children: [
                              Expanded(child: CustomTextField(
                                keybordType: TextInputType.number,
                                controller: txtAB1c,
                                editable: blEdit,
                                hintText: "1st Prize",
                                textFormFieldType: TextFormFieldType.weeklyCreditLimit,

                              ),),
                              gapWC(10),
                              Expanded(child: CustomTextField(
                                keybordType: TextInputType.number,
                                controller: txtAB1p,
                                editable: blEdit,
                                hintText: "Commission",
                                textFormFieldType: TextFormFieldType.weeklyCreditLimit,

                              ),)
                            ],
                          ),
                        ],
                      ),
                    ),
                    gapHC(15),
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: boxBaseDecoration(Colors.red.withOpacity(0.2), 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          tcn('A/B/C', Colors.black, 18),
                          gapHC(10),
                          Row(
                            children: [
                              Expanded(child: CustomTextField(
                                keybordType: TextInputType.number,
                                controller: txtA1p,
                                editable: blEdit,
                                hintText: "1st Prize",
                                textFormFieldType: TextFormFieldType.weeklyCreditLimit,

                              ),),
                              gapWC(10),
                              Expanded(child: CustomTextField(
                                keybordType: TextInputType.number,
                                controller: txtA1c,
                                editable: blEdit,
                                hintText: "Commission",
                                textFormFieldType: TextFormFieldType.weeklyCreditLimit,

                              ),)
                            ],
                          ),
                        ],
                      ),
                    ),
                    gapHC(15),
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: boxBaseDecoration(Colors.deepPurple.withOpacity(0.2), 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          tcn('Box', Colors.black, 18),
                          gapHC(10),
                          tcn('3 NUMBERS ARE DIFFERENT', Colors.black, 13),
                          gapHC(5),
                          Row(
                            children: [
                              Expanded(child: CustomTextField(
                                keybordType: TextInputType.number,
                                controller: txtBox3d1p,
                                editable: blEdit,
                                hintText: "1st Prize",
                                textFormFieldType: TextFormFieldType.weeklyCreditLimit,

                              ),),
                              gapWC(10),
                              Expanded(child: CustomTextField(
                                keybordType: TextInputType.number,
                                controller: txtBox3d1c,
                                editable: blEdit,
                                hintText: "Commission",
                                textFormFieldType: TextFormFieldType.weeklyCreditLimit,

                              ),)
                            ],
                          ),
                          gapHC(10),
                          Row(
                            children: [
                              Expanded(child: CustomTextField(
                                keybordType: TextInputType.number,
                                controller: txtBox3d2p,
                                editable: blEdit,
                                hintText: "1nd Prize",
                                textFormFieldType: TextFormFieldType.weeklyCreditLimit,

                              ),),
                              gapWC(10),
                              Expanded(child: CustomTextField(
                                keybordType: TextInputType.number,
                                controller: txtBox3d2c,
                                editable: blEdit,
                                hintText: "Commission",
                                textFormFieldType: TextFormFieldType.weeklyCreditLimit,

                              ),)
                            ],
                          ),
                          gapHC(10),
                          tcn('2 NUMBERS ARE SAME', Colors.black, 13),
                          gapHC(5),
                          Row(
                            children: [
                              Expanded(child: CustomTextField(
                                keybordType: TextInputType.number,
                                controller: txtBox2s1p,
                                editable: blEdit,
                                hintText: "1st Prize",
                                textFormFieldType: TextFormFieldType.weeklyCreditLimit,

                              ),),
                              gapWC(10),
                              Expanded(child: CustomTextField(
                                keybordType: TextInputType.number,
                                controller: txtBox2s1c,
                                editable: blEdit,
                                hintText: "Commission",
                                textFormFieldType: TextFormFieldType.weeklyCreditLimit,

                              ),)
                            ],
                          ),
                          gapHC(10),
                          Row(
                            children: [
                              Expanded(child: CustomTextField(
                                keybordType: TextInputType.number,
                                controller: txtBox2s2p,
                                editable: blEdit,
                                hintText: "2nd Prize",
                                textFormFieldType: TextFormFieldType.weeklyCreditLimit,

                              ),),
                              gapWC(10),
                              Expanded(child: CustomTextField(
                                keybordType: TextInputType.number,
                                controller: txtBox2s2c,
                                editable: blEdit,
                                hintText: "Commission",
                                textFormFieldType: TextFormFieldType.weeklyCreditLimit,

                              ),)
                            ],
                          ),
                          gapHC(10),
                          tcn('3 NUMBERS ARE SAME', Colors.black, 13),
                          gapHC(5),
                          Row(
                            children: [
                              Expanded(child: CustomTextField(
                                keybordType: TextInputType.number,
                                controller: txtBox3s1p,
                                editable: blEdit,
                                hintText: "1st Prize",
                                textFormFieldType: TextFormFieldType.weeklyCreditLimit,

                              ),),
                              gapWC(10),
                              Expanded(child: CustomTextField(
                                keybordType: TextInputType.number,
                                controller: txtBox3s1c,
                                editable: blEdit,
                                hintText: "Commission",
                                textFormFieldType: TextFormFieldType.weeklyCreditLimit,

                              ),)
                            ],
                          ),
                          gapHC(10),
                        ],
                      ),
                    ),
                    gapHC(30),

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

  //==================================================WIDGET
  //==================================================PAGE FN
  fnGetPageData(){
    if(mounted){
      setState(() {
        frSelectedUser = (widget.pUserCode??"").toString();
      });
      apiGetDetails();
    }
  }

  fnUpdate(){
    if(mounted){
      prizeList = [];

   setState(() {
     //Super
     prizeList.add({
       "GAME_CODE": "ALL",
       "TYPE": "SUPER",
       "PLACE": 1,
       "WINNING": g.mfnDbl(txtSup1p.text),
       "COMMISSION": g.mfnDbl(txtSup1c.text),
       "SP": 0
     });
     prizeList.add({
       "GAME_CODE": "ALL",
       "TYPE": "SUPER",
       "PLACE": 2,
       "WINNING": g.mfnDbl(txtSup2p.text),
       "COMMISSION": g.mfnDbl(txtSup2c.text),
       "SP": 0
     });

     prizeList.add({
       "GAME_CODE": "ALL",
       "TYPE": "SUPER",
       "PLACE": 3,
       "WINNING": g.mfnDbl(txtSup3p.text),
       "COMMISSION": g.mfnDbl(txtSup3c.text),
       "SP": 0
     });

     prizeList.add({
       "GAME_CODE": "ALL",
       "TYPE": "SUPER",
       "PLACE": 4,
       "WINNING": g.mfnDbl(txtSup4p.text),
       "COMMISSION": g.mfnDbl(txtSup4c.text),
       "SP": 0
     });

     prizeList.add({
       "GAME_CODE": "ALL",
       "TYPE": "SUPER",
       "PLACE": 5,
       "WINNING": g.mfnDbl(txtSup5p.text),
       "COMMISSION": g.mfnDbl(txtSup5c.text),
       "SP": 0
     });

     // prizeList.add({
     //   "GAME_CODE": "ALL",
     //   "TYPE": "SUPER",
     //   "PLACE": 6,
     //   "WINNING": g.mfnDbl(txtSup6p.text),
     //   "COMMISSION": g.mfnDbl(txtSup6c.text),
     //   "SP": 0
     // });


     for(var i = 6 ; i <= 35; i++){
       prizeList.add({
         "GAME_CODE": "ALL",
         "TYPE": "SUPER",
         "PLACE": i,
         "WINNING": g.mfnDbl(txtSup6p.text),
         "COMMISSION": g.mfnDbl(txtSup6c.text),
         "SP": 0
       });
     }



     //AB/BC/AC
     prizeList.add({
       "GAME_CODE": "ALL",
       "TYPE": "AB",
       "PLACE": 1,
       "WINNING": g.mfnDbl(txtAB1p.text),
       "COMMISSION": g.mfnDbl(txtAB1c.text),
       "SP": 0
     });
     prizeList.add({
       "GAME_CODE": "ALL",
       "TYPE": "BC",
       "PLACE": 1,
       "WINNING": g.mfnDbl(txtAB1p.text),
       "COMMISSION": g.mfnDbl(txtAB1c.text),
       "SP": 0
     });
     prizeList.add({
       "GAME_CODE": "ALL",
       "TYPE": "AC",
       "PLACE": 1,
       "WINNING": g.mfnDbl(txtAB1p.text),
       "COMMISSION": g.mfnDbl(txtAB1c.text),
       "SP": 0
     });

     //A/B/C
     prizeList.add({
       "GAME_CODE": "ALL",
       "TYPE": "A",
       "PLACE": 1,
       "WINNING": g.mfnDbl(txtA1p.text),
       "COMMISSION": g.mfnDbl(txtA1c.text),
       "SP": 0
     });
     prizeList.add({
       "GAME_CODE": "ALL",
       "TYPE": "B",
       "PLACE": 1,
       "WINNING": g.mfnDbl(txtA1p.text),
       "COMMISSION": g.mfnDbl(txtA1c.text),
       "SP": 0
     });
     prizeList.add({
       "GAME_CODE": "ALL",
       "TYPE": "C",
       "PLACE": 1,
       "WINNING": g.mfnDbl(txtA1p.text),
       "COMMISSION": g.mfnDbl(txtA1c.text),
       "SP": 0
     });

     //Box
     prizeList.add({
       "GAME_CODE": "ALL",
       "TYPE": "BOX",
       "PLACE": 31,
       "WINNING": g.mfnDbl(txtBox3d1p.text),
       "COMMISSION": g.mfnDbl(txtBox3d1c.text),
       "SP": 0
     });
     prizeList.add({
       "GAME_CODE": "ALL",
       "TYPE": "BOX",
       "PLACE": 32,
       "WINNING": g.mfnDbl(txtBox3d2p.text),
       "COMMISSION": g.mfnDbl(txtBox3d2c.text),
       "SP": 0
     });

     prizeList.add({
       "GAME_CODE": "ALL",
       "TYPE": "BOX",
       "PLACE": 21,
       "WINNING": g.mfnDbl(txtBox2s1p.text),
       "COMMISSION": g.mfnDbl(txtBox2s1c.text),
       "SP": 0
     });
     prizeList.add({
       "GAME_CODE": "ALL",
       "TYPE": "BOX",
       "PLACE": 22,
       "WINNING": g.mfnDbl(txtBox2s2p.text),
       "COMMISSION": g.mfnDbl(txtBox2s2c.text),
       "SP": 0
     });


     prizeList.add({
       "GAME_CODE": "ALL",
       "TYPE": "BOX",
       "PLACE": 11,
       "WINNING": g.mfnDbl(txtBox3s1p.text),
       "COMMISSION": g.mfnDbl(txtBox3s1c.text),
       "SP": 0
     });
     // prizeList.add({
     //   "GAME_CODE": "ALL",
     //   "TYPE": "BOX",
     //   "PLACE": 2,
     //   "WINNING": g.mfnDbl(txtBox3s2p.text),
     //   "COMMISSION": g.mfnDbl(txtBox3s2c.text),
     //   "SP": 0
     // });
   });


      apiUpdatePrize();
    }

  }


  fnFill(value){
    if(mounted){
      setState(() {


        for(var e in value){

          if((e["TYPE"]??"") == "SUPER"){

            if(e["PLACE"] == 1){
              txtSup1p.text = g.mfnDbl(e["WINNING"].toString()).toString();
              txtSup1c.text = g.mfnDbl(e["COMMISSION"].toString()).toString();
            }else  if(e["PLACE"] == 2){
              txtSup2p.text = g.mfnDbl(e["WINNING"].toString()).toString();
              txtSup2c.text = g.mfnDbl(e["COMMISSION"].toString()).toString();
            }else  if(e["PLACE"] == 3){
              txtSup3p.text = g.mfnDbl(e["WINNING"].toString()).toString();
              txtSup3c.text = g.mfnDbl(e["COMMISSION"].toString()).toString();
            }else  if(e["PLACE"] == 4){
              txtSup4p.text = g.mfnDbl(e["WINNING"].toString()).toString();
              txtSup4c.text = g.mfnDbl(e["COMMISSION"].toString()).toString();
            }else  if(e["PLACE"] == 5){
              txtSup5p.text = g.mfnDbl(e["WINNING"].toString()).toString();
              txtSup5c.text = g.mfnDbl(e["COMMISSION"].toString()).toString();
            }else  if(e["PLACE"] == 6){
              txtSup6p.text = g.mfnDbl(e["WINNING"].toString()).toString();
              txtSup6c.text = g.mfnDbl(e["COMMISSION"].toString()).toString();
            }
          }

          if((e["TYPE"]??"") == "AB"){
            if(e["PLACE"] == 1){
              txtAB1p.text = g.mfnDbl(e["WINNING"].toString()).toString();
              txtAB1c.text = g.mfnDbl(e["COMMISSION"].toString()).toString();
            }
          }

          if((e["TYPE"]??"") == "A"){
            if(e["PLACE"] == 1){
              txtA1p.text = g.mfnDbl(e["WINNING"].toString()).toString();
              txtA1c.text = g.mfnDbl(e["COMMISSION"].toString()).toString();
            }
          }

          if((e["TYPE"]??"") == "A"){
            if(e["PLACE"] == 1){
              txtA1p.text = g.mfnDbl(e["WINNING"].toString()).toString();
              txtA1c.text = g.mfnDbl(e["COMMISSION"].toString()).toString();
            }
          }

          if((e["TYPE"]??"") == "BOX"){
            if(e["PLACE"] == 31){
              txtBox3d1p.text = g.mfnDbl(e["WINNING"].toString()).toString();
              txtBox3d1c.text = g.mfnDbl(e["COMMISSION"].toString()).toString();
            }else if(e["PLACE"] == 32){
              txtBox3d2p.text = g.mfnDbl(e["WINNING"].toString()).toString();
              txtBox3d2c.text = g.mfnDbl(e["COMMISSION"].toString()).toString();
            }else if(e["PLACE"] == 21){
              txtBox2s1p.text = g.mfnDbl(e["WINNING"].toString()).toString();
              txtBox2s1c.text = g.mfnDbl(e["COMMISSION"].toString()).toString();
            }else if(e["PLACE"] == 22){
              txtBox2s2p.text = g.mfnDbl(e["WINNING"].toString()).toString();
              txtBox2s2c.text = g.mfnDbl(e["COMMISSION"].toString()).toString();
            }else if(e["PLACE"] == 11){
              txtBox3s1p.text = g.mfnDbl(e["WINNING"].toString()).toString();
              txtBox3s1c.text = g.mfnDbl(e["COMMISSION"].toString()).toString();
            }
          }

        }



      });
    }
  }

  //==================================================API CALL


  apiUpdatePrize(){
    futureForm = apiCall.apiUpdateUserGamePrize(g.wstrCompany, frSelectedUser, prizeList);
    futureForm.then((value) => apiUpdatePrizeRes(value));
  }
  apiUpdatePrizeRes(value){
    if(mounted){
      setState(() {
        if(g.fnValCheck(value)){
          // [{STATUS: 0, MSG: USER NOT FOUND}]
          var sts  =  value[0]["STATUS"];
          var msg  =  value[0]["MSG"];
          if(sts == "1"){
            successMsg(context, "Done");
            blEdit =  false;
            apiGetDetails();
          }else{
            errorMsg(context, msg.toString());
          }
        }
      });
    }
  }

  apiGetDetails(){
    futureForm  = apiCall.apiGetUserDetails(g.wstrCompany, frSelectedUser, "WINNING",null);
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
