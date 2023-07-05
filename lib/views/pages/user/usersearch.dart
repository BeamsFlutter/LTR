

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:ltr/controller/global/globalValues.dart';
import 'package:ltr/controller/navigation/navigation_controller.dart';
import 'package:ltr/services/apiController.dart';
import 'package:ltr/services/apiManager.dart';
import 'package:ltr/views/components/common/common.dart';
import 'package:ltr/views/pages/user/usercreation.dart';
import 'package:ltr/views/pages/user/userdetails.dart';
import 'package:ltr/views/styles/colors.dart';

class UserSearch extends StatefulWidget {
  final String pRoleCode;
  final String pUserCode;
  final String? pAllYn;
  final Function pFnCallBack;
  const UserSearch({Key? key, required this.pRoleCode, required this.pUserCode, required this.pFnCallBack, this.pAllYn}) : super(key: key);

  @override
  _UserSearchState createState() => _UserSearchState();
}

class _UserSearchState extends State<UserSearch> {


  //Global
  var g =  Global();
  var apiCall  = ApiCall();
  var n  = NavigationController();
  late Future<dynamic> futureForm;
  var wstrRole  = "";

  //Page Variable
  var frUserList = [];

  //Controller
  var txtSearch  = TextEditingController();
  var pnSearch  = FocusNode();

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
                  tcn(wstrRole.toString(), Colors.white, 20)
                ],
              ),
            ),
            gapHC(10),
            Container(
              height: 40.0,
              margin: const EdgeInsets.symmetric(horizontal: 10),
              padding:  const EdgeInsets.symmetric(horizontal: 10),
              decoration: boxBaseDecoration(greyLight , 30),
              child: TextFormField(
                controller: txtSearch,
                focusNode: pnSearch,
                decoration:  const InputDecoration(
                    hintText: 'Search',
                    hintStyle: TextStyle(fontSize: 15.0),
                    border: InputBorder.none,
                    suffixIcon: Icon(Icons.search,color: Colors.grey,size: 20.0,)
                ),
                onChanged: (value){
                  apiGetUserList();
                },
              ),
            ),
            gapHC(10),
            Expanded(child: Column(
              children: wUserList(),
            )),

          ],
        ),
      ),
    );
  }

  //===========================================WIDGET

  List<Widget> wUserList(){
    List<Widget> rtnList = [];
    var srno = 1;
    if(widget.pAllYn == "Y"){
      rtnList.add(Bounce(
        onPressed: (){
          Navigator.pop(context);
          widget.pFnCallBack(wstrRole,"ALL");
        },
        duration: const Duration(milliseconds: 110),
        child: Container(
          margin: const EdgeInsets.only(bottom: 0),
          padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 15),
          decoration: boxBaseDecoration( (srno%2 == 0)? Colors.white: Colors.blueGrey.withOpacity(0.1), 0),
          child: Row(
            children: [
              Expanded(child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  tcn("All ${wstrRole.toString()}", Colors.black , 15)
                ],
              ))
            ],
          ),
        ),
      ));
      srno =2;
    }


    for(var e in frUserList){
      rtnList.add(Bounce(
        onPressed: (){
          Navigator.pop(context);
          widget.pFnCallBack(wstrRole,e["USERCD"]);
        },
        duration: const Duration(milliseconds: 110),
        child: Container(
          margin: const EdgeInsets.only(bottom: 0),
          padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 15),
          decoration: boxBaseDecoration( (srno%2 == 0)? Colors.white: Colors.blueGrey.withOpacity(0.1), 0),
          child: Row(
            children: [
              Container(
                decoration: boxBaseDecoration((srno%2 == 0)? Colors.black.withOpacity(0.05): Colors.white, 30),
                padding: const EdgeInsets.all(5),
                child:  const Icon(Icons.person,color: Colors.black,size: 12,),
              ),
              gapWC(10),
              Expanded(child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  tcn((e["USERCD"]??"").toString().toUpperCase(), Colors.black , 15)
                ],
              ))
            ],
          ),
        ),
      ));
      srno = srno+1;
    }
    return rtnList;
  }

  //===========================================PAGE FN

  fnGetPageData(){
    if(mounted){
      setState(() {
        wstrRole = (widget.pRoleCode??"").toString();
      });
      apiGetUserList();
    }
  }

  //===========================================API CALL

  apiGetUserList(){
    var user = widget.pUserCode;
    // if(wstrRole == "Stockist"){
    //   user = g.wstrUserCd;
    // }
    futureForm = apiCall.apiGetChildUser(g.wstrCompany, user,wstrRole,txtSearch.text);
    futureForm.then((value) => apiGetUserListRes(value));
  }

  apiGetUserListRes(value){
    if(mounted){
      setState(() {
        frUserList = [];
        if(g.fnValCheck(value)){

          frUserList = value;
        }
      });
    }
  }


}
