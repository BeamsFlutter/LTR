

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:ltr/controller/global/globalValues.dart';
import 'package:ltr/services/apiController.dart';
import 'package:ltr/views/components/common/common.dart';
import 'package:ltr/views/components/enum.dart';
import 'package:ltr/views/components/inputfield/commonTextField.dart';
import 'package:ltr/views/styles/colors.dart';

class UserCreation extends StatefulWidget {
  final String pUserRole;
  final String pPageMode;
  final String pPageUserCd;
  final String pStockistCode;
  final String pDealerCode;
  final Function pfnCallBack;
  const UserCreation({Key? key, required this.pUserRole, required this.pPageMode, required this.pPageUserCd, required this.pStockistCode, required this.pDealerCode, required this.pfnCallBack}) : super(key: key);

  @override
  _UserCreationState createState() => _UserCreationState();
}

class _UserCreationState extends State<UserCreation> {


  //Global
  var g =  Global();
  var apiCall  = ApiCall();
  late Future<dynamic> futureForm;
  var wstrPageMode  =  "ADD";
  var wstrRole = "Admin";

  //Page Variable
  var frGameList  =  [];
  var frSelectedGameList = [];
  
  var txtId = TextEditingController();
  var txtPassword = TextEditingController();
  var txtConfirmPwd = TextEditingController();
  var txtWeeklyCredit = TextEditingController();
  var txtDailyCredit = TextEditingController();
  var txtSharePerc = TextEditingController();

  var blDefaultAgent  = false;
  var blCanViewComm  = false;
  var blEdit  = false;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fnGetPageData();
  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        margin: MediaQuery.of(context).padding,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: boxBaseDecoration(g.wstrGameBColor, 0),
              child: Column(
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: (){
                          Navigator.pop(context);
                        },
                        child: Container(
                          decoration: boxDecoration(Colors.white,10),
                          padding: const EdgeInsets.all(5),
                          child: const Icon(Icons.arrow_back,color: Colors.black,size: 20,),
                        ),
                      ),
                      gapWC(10),
                      tcn(wstrRole.toString(), Colors.white, 20)
                    ],
                  ),
                  
                ],
              ),
            ),
            gapHC(20),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 15),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                              tcn('Password Edit',blEdit? Colors.black: Colors.grey, 15)
                            ],
                          ),
                        ),
                      ),
                      gapHC(10),
                      Container(
                        padding: const EdgeInsets.all(5),
                        decoration: boxBaseDecoration(greyLight,0),
                        child: Row(
                          children: [
                            tcn('User Details', Colors.black, 12),
                          ],
                        ),
                      ),
                      gapHC(10),
                      CustomTextField(
                        editable: wstrPageMode == "ADD"?true:false,
                        controller: txtId,
                        hintText: "ID",
                      ),
                      gapHC(15,),
                      CustomTextField(
                        controller: txtPassword,
                        hintText: "Password",
                        textFormFieldType: TextFormFieldType.passwrd,
                      ),
                      gapHC(15,),
                      CustomTextField(
                        controller: txtConfirmPwd,
                        hintText: "Confirm Password",
                        textFormFieldType: TextFormFieldType.confirmPasswrd,
                      ),
                      gapHC(10,),
                      Container(
                        padding: const EdgeInsets.all(5),
                        decoration: boxBaseDecoration(greyLight,0),
                        child: Row(
                          children: [
                            tcn('Credit Limit', Colors.black, 12),
                          ],
                        ),
                      ),

                      gapHC(10,),
                      CustomTextField(
                        keybordType: TextInputType.number,
                        controller: txtWeeklyCredit,
                        hintText: "Weekly credit limit",
                        textFormFieldType: TextFormFieldType.weeklyCreditLimit,

                      ),
                      gapHC(15,),
                      CustomTextField(
                        keybordType: TextInputType.number,
                        controller: txtDailyCredit,
                        hintText: "Daily credit limit",
                        textFormFieldType: TextFormFieldType.dailyCreditLimit,

                      ),
                      wstrRole != "Agent"?
                      Column(
                        children: [
                          gapHC(10,),
                          Container(
                            padding: const EdgeInsets.all(5),
                            decoration: boxBaseDecoration(greyLight,0),
                            child: Row(
                              children: [
                                tcn('Share Perc%', Colors.black, 12)
                              ],
                            ),
                          ),
                          gapHC(10,),
                          CustomTextField(
                            keybordType: TextInputType.number,
                            controller: txtSharePerc,
                            hintText: "Share %",
                            maxCount: 3,
                            textFormFieldType: TextFormFieldType.dailyCreditLimit,

                          ),
                          gapHC(10,),
                        ],
                      ): gapHC(10,),
                      wstrRole == "Agent"?
                      Column(
                        children: [
                          gapHC(10,),
                          Container(
                            padding: const EdgeInsets.all(5),
                            decoration: boxBaseDecoration(greyLight,0),
                            child: Row(
                              children: [
                                tcn('Permission', Colors.black, 12)
                              ],
                            ),
                          ),
                          gapHC(10,),
                          Row(
                            children: [
                              tcn('Default Agent', Colors.black, 15),
                              Transform.scale(
                                  scale: 1.3,
                                  child: Switch(
                                    onChanged: (val){
                                      if(mounted){
                                        setState(() {
                                          blDefaultAgent = !blDefaultAgent;
                                        });
                                      }
                                    },
                                    value: blDefaultAgent,
                                    activeColor: g.wstrGameColor,
                                    activeTrackColor: g.wstrGameColor.withOpacity(0.5),
                                    inactiveThumbColor: Colors.grey.withOpacity(0.9),
                                    inactiveTrackColor:Colors.grey.withOpacity(0.5),
                                  )
                              ),
                            ],
                          ),
                          gapHC(5,),
                          Row(
                            children: [
                              tcn('Can View Commission', Colors.black, 15),
                              Transform.scale(
                                  scale: 1.3,
                                  child: Switch(
                                    onChanged: (val){
                                      if(mounted){
                                        setState(() {
                                          blCanViewComm = !blCanViewComm;
                                        });
                                      }
                                    },
                                    value: blCanViewComm,
                                    activeColor: g.wstrGameColor,
                                    activeTrackColor: g.wstrGameColor.withOpacity(0.5),
                                    inactiveThumbColor: Colors.grey.withOpacity(0.9),
                                    inactiveTrackColor:Colors.grey.withOpacity(0.5),
                                  )
                              ),
                            ],
                          ),
                          gapHC(10,),
                        ],
                      ): gapHC(10,),

                      Container(
                        padding: const EdgeInsets.all(5),
                        decoration: boxBaseDecoration(greyLight,0),
                        child: Row(
                          children: [
                            tcn('Allowed Games', Colors.black, 12)
                          ],
                        ),
                      ),
                      gapHC(10,),
                      Wrap(
                        children: wGameList(size),
                      )


                    ],
                  ),
                ),
              ),
            ),
            Row(
              children: [
                gapWC(10),
                wstrPageMode == "ADD"?
                Expanded(child: GestureDetector(
                  onTap: (){
                    fnSave();
                  },
                  child: Container(
                    decoration: boxDecoration(g.wstrGameBColor, 30),
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.task_alt,color: Colors.white,size: 15,),
                        gapWC(5),
                        tcn('Save', Colors.white, 15)
                      ],
                    ),
                  ),
                )):Expanded(child: Bounce(
                  onPressed: (){
                    fnSave();
                  },
                  duration: const Duration(milliseconds: 110),
                  child: Container(
                    decoration: boxDecoration(g.wstrGameBColor, 30),
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.edit,color: Colors.white,size: 15,),
                        gapWC(5),
                        tcn('Update', Colors.white, 15)
                      ],
                    ),
                  ),
                )),
                gapWC(10),
                Bounce(
                  onPressed: (){
                    Navigator.pop(context);
                  },
                  duration: const Duration(milliseconds: 110),
                  child: Container(
                    decoration: boxBaseDecoration(greyLight, 30),
                    padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 15),
                    child: Row(
                      children: [
                        const Icon(Icons.close,color: Colors.black,size: 15,),
                        gapWC(5),
                        tcn('Cancel', Colors.black, 15)
                      ],
                    ),
                  ),
                ),
                gapWC(10),
              ],
            )

          ],
        ),
      ),
    );
  }
  //=========================================WIDGET
    
    List<Widget> wGameList(size){
      List<Widget> rtnList  = [];
      for(var e in frGameList){
        var code  =  (e["CODE"]??"").toString();
        rtnList.add(Bounce(
          onPressed: (){
            fnSelectGames(code);
          },
          duration: const Duration(milliseconds: 110),
          child: Container(
            width: size.width * 0.4,
            padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 20),
            margin: const EdgeInsets.symmetric(vertical: 5,horizontal: 8),
            decoration: boxDecoration( frSelectedGameList.contains(code)? grey: Colors.white, 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                tcn((e["DESCP"]??"").toString(),frSelectedGameList.contains(code)?Colors.white: Colors.black, 13),
                const Icon(Icons.task_alt,color: Colors.white,size: 15,)
              ],
            )
          ),
        ));
      }
      return rtnList;
    }
  //=========================================PAGE FN

    fnGetPageData(){
       if(mounted){
         Future.delayed(const Duration(seconds: 1),(){
          apiGetGameList();
         });
         setState(() {
           wstrRole =  (widget.pUserRole??"").toString();
           wstrPageMode =  (widget.pPageMode??"").toString();
         });
         if(wstrPageMode == "EDIT"){
           //Load old details
           txtId.text =  widget.pPageUserCd.toString();
           apiGetDetails();
         }
       }
    }

    fnSelectGames(code){
      if(mounted){
        setState(() {
          if(frSelectedGameList.contains(code)){
            frSelectedGameList.remove(code);
          }else{
            frSelectedGameList.add(code);
          }
        });
      }
    }

    fnSave(){
      if(txtId.text.isEmpty){
        errorMsg(context, "Check Id");
        return;
      }
      if(txtPassword.text.isEmpty && (blEdit || wstrPageMode == "ADD")){
        errorMsg(context, "Check Password");
        return;
      }
      if(txtPassword.text !=  txtConfirmPwd.text && (blEdit || wstrPageMode == "ADD")){
        errorMsg(context, "Confirm Password");
        return;
      }

      apiCreateUser();

    }

    fnFill(value){
      if(mounted){
        var headData  = value["USERDET"];
        var gameData  = value["USERGAMES"];
        setState(() {
          frSelectedGameList.clear();
          txtWeeklyCredit.text = g.mfnDbl((headData[0]['WEEKLY_CR_LIMIT'].toString())).toString();
          txtDailyCredit.text = g.mfnDbl((headData[0]['DAILY_CR_LIMIT'].toString())).toString();
          txtSharePerc.text = g.mfnDbl((headData[0]['SHARE_PER'].toString())).toString();

          if(wstrRole == "Agent"){
            blCanViewComm = (headData[0]['CANVIEW_COM'].toString()) == "Y"?true:false;
            blDefaultAgent = (headData[0]['DEF_AGENT'].toString()) == "Y"?true:false;
          }

          for(var e in gameData) {
            if (!frSelectedGameList.contains((e["GAME_CODE"] ?? ""))) {
              frSelectedGameList.add((e["GAME_CODE"] ?? ""));
            }
          }

        });
      }
    }

  //=========================================API CALL
  apiGetGameList(){
    //api for get user wise game list

    var parentCode = "";
    if(wstrRole == "Stockist"){
      parentCode = g.wstrUserCd;
    }else if(wstrRole == "Dealer"){
      parentCode = widget.pStockistCode;
    }else if(wstrRole == "Agent"){
      parentCode = widget.pDealerCode;
    }

    futureForm = apiCall.apiGetUserGames(g.wstrCompany, parentCode, "");
    futureForm.then((value) => apiGetGameListRes(value));
  }
  apiGetGameListRes(value){
    if(mounted){
      setState(() {
        frGameList = [];
        if(g.fnValCheck(value)){
          frGameList = value;
        }
      });
    }
  }

  apiCreateUser(){



    var games = [];
    for(var e in frSelectedGameList){
      games.add({
        "GAME_CODE":e,
        "MAX_COUNT":-1,//50
        "REPORT_DAYS":-1
      });
    }
    var canView = "";
    var defAgent = "";
    var parentCode = "";
    if(wstrRole == "Stockist"){
      parentCode = g.wstrUserCd;
    }else if(wstrRole == "Dealer"){
      parentCode = widget.pStockistCode;
    }else if(wstrRole == "Agent"){
      parentCode = widget.pDealerCode;
      canView =  blCanViewComm?"Y":"N";
      defAgent =  blDefaultAgent?"Y":"N";
    }

    var sharePerc = g.mfnDbl(txtSharePerc.text.toString());

    futureForm = apiCall.apiCreateUser(g.wstrCompany, txtId.text, wstrRole.toString().toUpperCase(),parentCode, txtPassword.text, txtWeeklyCredit.text, txtDailyCredit.text,blEdit?"PASSWORD": wstrPageMode,sharePerc,canView,defAgent,games);
    futureForm.then((value) => apiCreateUserRes(value));
  }
  apiCreateUserRes(value){
    if(mounted){
      if(g.fnValCheck(value)){
        //[{STATUS: 1, MSG: ADDED}]
        var sts = (value[0]["STATUS"]??"").toString();
        var msg = (value[0]["MSG"]??"").toString();
        if(sts == "1"){
          Navigator.pop(context);
          successMsg(context, "Success");
          widget.pfnCallBack();
          //after success directly move to the user details page
        }else{
          errorMsg(context, msg.toString());
        }

      }else{
        errorMsg(context, "Please try again");
      }

    }
  }

  apiGetDetails(){
    futureForm  = apiCall.apiGetUserDetails(g.wstrCompany, widget.pPageUserCd.toString(), "USERDET",null);
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
