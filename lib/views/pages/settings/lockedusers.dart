

import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:ltr/controller/global/globalValues.dart';
import 'package:ltr/services/apiController.dart';
import 'package:ltr/views/components/alertDialog/alertDialog.dart';
import 'package:ltr/views/components/common/common.dart';
import 'package:ltr/views/styles/colors.dart';

class LockedUsers extends StatefulWidget {
  const LockedUsers({Key? key}) : super(key: key);

  @override
  State<LockedUsers> createState() => _LockedUsersState();
}

class _LockedUsersState extends State<LockedUsers> {


  //Global
  var g = Global();
  var apiCall  = ApiCall();
  late Future<dynamic> futureForm;

  //Page Variable
  var frLockedUsers  = [];



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
    return  Scaffold(
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
                      decoration: boxBaseDecoration(Colors.white,10),
                      padding: const EdgeInsets.all(5),
                      child: const Icon(Icons.arrow_back,color: Colors.black,size: 20,),
                    ),
                  ),
                  gapWC(5),
                  tcn("Locked Users", Colors.white, 20)
                ],
              ),
            ),
            gapHC(5),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: wUserList(),
                ),
              ),
            ),
            gapHC(5),
            Bounce(
              onPressed: (){
               PageDialog().cDialog(context,"Unlock","Do you want to unlock all?", fnUnlock);
              },
              duration: const Duration(milliseconds: 110),
              child: Container(
                decoration: boxDecoration(g.wstrGameBColor, 30),
                margin: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                padding: const EdgeInsets.symmetric(vertical: 12,horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.lock_open,color: Colors.white,size: 16,),
                    gapWC(5),
                    tcn('Unlock All', Colors.white, 16)
                  ],
                ),
              ),
            )


          ],
        ),
      ),
    );
  }

  //=================================WIDGET

    List<Widget> wUserList(){
      List<Widget> rtnList = [];
      for(var e in frLockedUsers){
        rtnList.add(Container(
          decoration: boxBaseDecoration(greyLight , 5),
          margin: EdgeInsets.only(bottom: 5),
          padding: const EdgeInsets.all(5),
          child: Row(
            children: [
              const Icon(Icons.verified_user,color: Colors.black,size: 18,),
              gapWC(10),
              Expanded(child:Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  tc((e["USERCD"]??"").toString(), Colors.black, 17),
                  tcn((e["ROLE_CODE"]??"").toString(), Colors.black, 10)
                ],
              ))
            ],
          ),
        ));
      }
      return rtnList;
    }

  //=================================PAGE FN
  fnGetPageData(){
    if(mounted){
      apiGetLockedUsers();
    }
  }
  fnUnlock(){
    Navigator.pop(context);
    if(frLockedUsers.isNotEmpty){
      apiUnLockedAllUsers();
    }
  }

  //=================================API CALL


  apiGetLockedUsers(){
    futureForm = apiCall.apiGetLockedUsers(g.wstrCompany);
    futureForm.then((value) => apiGetLockedUsersRes(value));
  }

  apiGetLockedUsersRes(value){
    if(mounted){
      setState(() {
        frLockedUsers = [];
        if(g.fnValCheck(value)){
          frLockedUsers = value??[];
        }
      });
    }
  }

  apiUnLockedAllUsers(){
    futureForm = apiCall.apiUnLockUser(g.wstrCompany,null);
    futureForm.then((value) => apiUnLockedAllUsersRes(value));
  }
  apiUnLockedAllUsersRes(value){
    if(mounted){
      setState(() {
        if(g.fnValCheck(value)){
          // [{STATUS: 0, MSG: USER NOT FOUND}]
          var sts  =  value[0]["STATUS"];
          var msg  =  value[0]["MSG"];
          if(sts == "1"){
            successMsg(context, "Unlocked!");
            apiGetLockedUsers();
          }else{
            errorMsg(context, msg.toString());
          }
        }
      });
    }
  }

}
