



import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:ltr/controller/global/globalValues.dart';
import 'package:ltr/services/apiController.dart';
import 'package:ltr/views/components/common/common.dart';
import 'package:ltr/views/components/enum.dart';
import 'package:ltr/views/components/inputfield/commonTextField.dart';
import 'package:ltr/views/styles/colors.dart';

class UserCreationWithPermission extends StatefulWidget {
  final String pUserRole;
  final String pPageMode;
  final String pPageUserCd;
  final Function pfnCallBack;
  const UserCreationWithPermission({Key? key, required this.pUserRole, required this.pPageMode, required this.pPageUserCd, required this.pfnCallBack}) : super(key: key);

  @override
  _UserCreationWithPermissionState createState() => _UserCreationWithPermissionState();
}

class _UserCreationWithPermissionState extends State<UserCreationWithPermission> {


  //Global
  var g =  Global();
  var apiCall  = ApiCall();
  late Future<dynamic> futureForm;
  var wstrPageMode  =  "ADD";
  var wstrRole = "Admin";

  //Page Variable
  var frGameList  =  [];
  var frSelectedMenuList = [];
  var frPermissionList = [];

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
                                decoration: blEdit?boxDecoration( bgColorDark, 30):boxOutlineCustom1(Colors.white, 30, Colors.black, 0.5),
                                child: const Icon(Icons.done,color: Colors.white,size: 13,),
                              ),
                            ),
                            gapWC(10),
                            tcn('Password Edit',Colors.black, 15)
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
                          tcn('Menu List', Colors.black, 12),
                        ],
                      ),
                    ),
                    gapHC(10),
                    Expanded(
                      child: ListView.builder(
                          padding: const EdgeInsets.all(0),
                          physics: const AlwaysScrollableScrollPhysics(),
                          itemCount: frPermissionList.length,
                          itemBuilder: (context, index) {
                            var e = frPermissionList[index];
                            var code = e["CODE"];
                            return Bounce(
                              onPressed: (){
                                fnSelectMenu(code);
                              },
                              duration: const Duration(milliseconds: 110),
                              child: Container(
                                  width: size.width * 0.4,
                                  padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 20),
                                  margin: const EdgeInsets.symmetric(vertical: 5,horizontal: 8),
                                  decoration: boxDecoration( frSelectedMenuList.contains(code)? grey: Colors.white, 30),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      tcn((e["DESCP"]??"").toString(),frSelectedMenuList.contains(code)?Colors.white: Colors.black, 13),
                                       Icon(Icons.task_alt,color: frSelectedMenuList.contains(code)?Colors.white:Colors.grey,size: 15,)
                                    ],
                                  )
                              ),
                            );
                          }
                      ),
                    )



                  ],
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

  //=========================================PAGE FN

  fnGetPageData(){
    if(mounted){
      Future.delayed(const Duration(seconds: 1),(){
        apiMenuDetails();
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

  fnSelectMenu(code){
    if(mounted){
      setState(() {
        if(frSelectedMenuList.contains(code)){
          frSelectedMenuList.remove(code);
        }else{
          frSelectedMenuList.add(code);
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

    if(frSelectedMenuList.isEmpty){
      errorMsg(context, "Choose Menu List");
      return;
    }

    apiCreateUser();

  }

  fnFill(value){
    if(mounted){
      var headData  = value["USERDET"];
      var menu  = (value["USERMENU"]??[]);
      dprint(menu);
      setState(() {
        frSelectedMenuList.clear();
        txtWeeklyCredit.text = g.mfnDbl((headData[0]['WEEKLY_CR_LIMIT'].toString())).toString();
        txtDailyCredit.text = g.mfnDbl((headData[0]['DAILY_CR_LIMIT'].toString())).toString();
        txtSharePerc.text = g.mfnDbl((headData[0]['SHARE_PER'].toString())).toString();
        txtPassword.text = (headData[0]['PWD'].toString()).toString();
        txtConfirmPwd.text = (headData[0]['PWD'].toString()).toString();

        if(wstrRole == "Agent"){
          blCanViewComm = (headData[0]['CANVIEW_COM'].toString()) == "Y"?true:false;
          blDefaultAgent = (headData[0]['DEF_AGENT'].toString()) == "Y"?true:false;
        }

        for(var e in menu) {
          if (!frSelectedMenuList.contains((e["MENU_CODE"] ?? ""))) {
            frSelectedMenuList.add((e["MENU_CODE"] ?? ""));
          }
        }

      });
    }
  }

  //=========================================API CALL


  apiCreateUser(){

    var games = [];
    var menu = [];
    for(var e in frSelectedMenuList){
      menu.add({
        "MENU_CODE":e,
        "MENU_DESCP":""
      });
    }
    var parentCode = g.wstrUserCd;

    futureForm = apiCall.apiCreateUser(g.wstrCompany, txtId.text, "SPC",parentCode, txtPassword.text, 0, 0,blEdit?"PASSWORD":wstrPageMode,0,"N","N",[],menu);
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


  apiMenuDetails(){
    futureForm  = apiCall.apiPermissionMenu();
    futureForm.then((value) => apiMenuDetailsRes(value));
  }
  apiMenuDetailsRes(value){
    if(mounted){
      setState(() {
        frPermissionList = [];
        if(g.fnValCheck(value)){
          frPermissionList = value;
        }
      });
    }
  }

}
