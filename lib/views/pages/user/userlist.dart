

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
import 'package:ltr/views/pages/user/usersearch.dart';
import 'package:ltr/views/styles/colors.dart';

class UserList extends StatefulWidget {
  final String pRoleCode;
  const UserList({Key? key, required this.pRoleCode}) : super(key: key);

  @override
  _UserListState createState() => _UserListState();
}

class _UserListState extends State<UserList> {


  //Global
  var g =  Global();
  var apiCall  = ApiCall();
  var n  = NavigationController();
  late Future<dynamic> futureForm;
  var wstrRole  = "";

  //Page Variable
  var frUserList = [];
  var fStockistCode = "";
  var fDealerCode = "";

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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  tcn(wstrRole.toString(), Colors.white, 20),
                  GestureDetector(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Container(
                      decoration: boxBaseDecoration(Colors.white,10),
                      padding: const EdgeInsets.all(5),
                      child: const Icon(Icons.segment,color: Colors.black,size: 20,),
                    ),
                  ),
                ],
              ),
            ),
            gapHC(10),
            Row(
              children: [
                (wstrRole == "Dealer" || wstrRole == "Agent") && g.wstrUserRole.toString().toUpperCase() == "ADMIN"?
                Expanded(child: Bounce(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) =>   UserSearch(pRoleCode: "Stockist", pUserCode: g.wstrUserCd.toString(), pFnCallBack: fnSearchCallBack,pBlockMode: "ALL",)));
                  },
                  duration: const Duration(milliseconds: 110),
                  child: Container(
                    margin:const  EdgeInsets.symmetric(horizontal: 5),
                    padding: const EdgeInsets.all(10),
                    decoration: boxDecoration(Colors.white, 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            tcn('Stockist ', Colors.black, 12),
                            tc(fStockistCode.toString(), Colors.black, 15),
                          ],
                        ),
                        const Icon(Icons.search,color: Colors.grey,size: 18,)
                      ],
                    ),
                  ),
                )):gapHC(0),
                wstrRole == "Agent" && (g.wstrUserRole.toString().toUpperCase() == "ADMIN" || g.wstrUserRole.toString().toUpperCase() == "STOCKIST")?
                Expanded(child: Bounce(
                  onPressed: (){

                    if(fStockistCode.isEmpty){
                      errorMsg(context, "Choose Stockist");
                      return;
                    }

                    Navigator.push(context, MaterialPageRoute(builder: (context) =>   UserSearch(pRoleCode: "Dealer", pUserCode: fStockistCode, pFnCallBack: fnSearchCallBack,pBlockMode: "ALL",)));

                  },
                  duration: const Duration(milliseconds: 110),
                  child: Container(
                    margin:const  EdgeInsets.symmetric(horizontal: 5),
                    padding: const EdgeInsets.all(10),
                    decoration: boxDecoration(Colors.white, 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            tcn('Dealer ', Colors.black, 12),
                            tc(fDealerCode.toString(), Colors.black, 15),
                          ],
                        ),
                        Icon(Icons.search,color: Colors.grey,size: 18,)
                      ],
                    ),
                  ),
                )):gapHC(0)
              ],
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
            Expanded(child: SingleChildScrollView(
              child: Column(
                children: wUserList(),
              ),
            )),
            Bounce(
              onPressed: (){
                if(wstrRole == "Dealer" && fStockistCode.isEmpty){
                  errorMsg(context, "Choose Stockist");
                  return;
                }
                if(wstrRole == "Agent" && fDealerCode.isEmpty){
                  errorMsg(context, "Choose Dealer");
                  return;
                }
                Navigator.push(context, MaterialPageRoute(builder: (context) =>   UserCreation(pUserRole: wstrRole.toString(), pPageMode: 'ADD', pPageUserCd: '', pStockistCode: fStockistCode, pDealerCode: fDealerCode, pfnCallBack: fnSaveCallBack,)));

              },
              duration: const Duration(milliseconds: 110),
              child: Container(
                decoration: boxDecoration(g.wstrGameBColor, 30),
                margin: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                padding: const EdgeInsets.symmetric(vertical: 12,horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.person_add_alt,color: g.wstrGameOTColor,size: 16,),
                    gapWC(5),
                    tcn('Create $wstrRole', g.wstrGameOTColor, 16)
                  ],
                ),
              ),
            )

          ],
        ),
      ),
    );
  }

  //===========================================WIDGET

  List<Widget> wUserList(){
    List<Widget> rtnList = [];
    var srno = 1;
    for(var e in frUserList){
      rtnList.add(Bounce(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) =>  UserDetails(pUserCode: (e["USERCD"]??"").toString(), pUserRole:wstrRole,pStockistCode: fStockistCode, pDealerCode: fDealerCode, fnCallBack: fnSaveCallBack,pBlockYn: (e["BLOCKED_YN"]??"").toString(),) ));
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
              )),
              (e["BLOCKED_YN"]??"") == "Y"?
              const Icon(Icons.block,color: Colors.red,size: 18,):
              gapWC(0)
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
      if(wstrRole == "Stockist" && g.wstrUserRole.toString().toUpperCase() == "ADMIN" ){
        apiGetUserList();
      }else if((wstrRole == "Dealer" ||wstrRole == "Agent" )  && g.wstrUserRole.toString().toUpperCase() == "STOCKIST" ){
        setState(() {
          fStockistCode = g.wstrUserCd;
        });
        apiGetUserList();
      }else if(wstrRole == "Agent" && g.wstrUserRole.toString().toUpperCase() == "DEALER" ){

        setState(() {
          fDealerCode = g.wstrUserCd;
        });
        apiGetUserList();
      }

    }
  }
  fnSearchCallBack(rolecode,usercd){
    if(mounted){
      setState(() {
        if(rolecode == "Stockist"){
          if(fStockistCode != usercd){
            fDealerCode = "";
          }
          fStockistCode = usercd;
        }else if(rolecode == "Dealer"){
          fDealerCode = usercd;
        }
      });

      apiGetUserList();
    }
  }
  fnSaveCallBack(){
    apiGetUserList();
  }


  //===========================================API CALL

  apiGetUserList(){
    var user = g.wstrUserCd;
    if(wstrRole == "Stockist"){
      user = g.wstrUserCd;
    }else if(wstrRole == "Dealer"){
      user = fStockistCode;
    }else if(wstrRole == "Agent"){
      user = fDealerCode;
    }
    futureForm = apiCall.apiGetChildUser(g.wstrCompany, user,wstrRole,txtSearch.text,"ALL");
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
