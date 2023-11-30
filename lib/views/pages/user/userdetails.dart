
import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:ltr/controller/global/globalValues.dart';
import 'package:ltr/services/apiController.dart';
import 'package:ltr/views/components/alertDialog/alertDialog.dart';
import 'package:ltr/views/components/common/common.dart';
import 'package:ltr/views/pages/user/usercreation.dart';
import 'package:ltr/views/pages/user/usergamecount.dart';
import 'package:ltr/views/pages/user/usernumbercount.dart';
import 'package:ltr/views/pages/user/userprize.dart';
import 'package:ltr/views/pages/user/usersalesrate.dart';
import 'package:ltr/views/styles/colors.dart';

class UserDetails extends StatefulWidget {
  final String pUserCode;
  final String pUserRole;
  final String pStockistCode;
  final String pDealerCode;
  final String pBlockYn;
  final Function fnCallBack;
  const UserDetails({Key? key, required this.pUserCode, required this.pUserRole, required this.pStockistCode, required this.pDealerCode, required this.fnCallBack, required this.pBlockYn}) : super(key: key);

  @override
  _UserDetailsState createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {


  //Global
  var g =  Global();
  var apiCall  = ApiCall();
  late Future<dynamic> futureForm;

  //Page Variable
  var frSelectedUser = "";
  var wstrRole = "";

  //Controller


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
                  tcn(frSelectedUser.toString().toUpperCase(), Colors.white, 20)
                ],
              ),
            ),
            gapHC(10),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(10),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      wUserMenu('EDIT DETAILS',Icons.edit,"D"),
                      gapHC(3),
                      wUserMenu('PRIZE DC',Icons.card_giftcard,"P"),
                      gapHC(3),
                      wUserMenu('SALES COMMISSION',Icons.currency_rupee,"S"),
                      gapHC(3),
                      wUserMenu('GAME COUNT',Icons.confirmation_number_outlined,"G"),
                      gapHC(3),
                      wUserMenu('NUMBER COUNT',Icons.numbers,"N"),
                      gapHC(10),
                      widget.pBlockYn == "Y"?
                      Bounce(
                        onPressed: (){
                          PageDialog().cDialog(context, "UNBLOCK", "Do you want to unblock?", (){
                            apiBlockUnblock("UNBLOCK");
                          });

                        },
                        duration: const Duration(milliseconds: 110),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                          decoration: boxBaseDecoration(Colors.blue.withOpacity(0.1), 10),
                          child: Column(
                            children: [
                              Row(),
                              Container(
                                padding: const EdgeInsets.all(5),
                                decoration: boxBaseDecoration(Colors.blue.withOpacity(0.1), 30),
                                child: const Icon(Icons.block,color: Colors.blue,),
                              ),
                              gapHC(5),

                              tcn('UN BLOCK', Colors.blue, 15)
                            ],
                          ),
                        ),
                      ):
                      Bounce(
                        onPressed: (){
                          PageDialog().cDialog(context, "BLOCK", "Do you want to block?", (){
                            apiBlockUnblock("BLOCK");
                          });
                        },
                        duration: const Duration(milliseconds: 110),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                          decoration: boxBaseDecoration(Colors.red.withOpacity(0.1), 10),
                          child: Column(
                            children: [
                              Row(),
                              Container(
                                padding: const EdgeInsets.all(5),
                                decoration: boxBaseDecoration(Colors.red.withOpacity(0.1), 30),
                                child: const Icon(Icons.block,color: Colors.red,),
                              ),
                              gapHC(5),

                              tcn('BLOCK', Colors.red, 15)
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  //========================================WIDGET

    Widget wUserMenu(text,icon,mode){
     return  Bounce(
       onPressed: (){
         if(mode == "D"){
           Navigator.push(context, MaterialPageRoute(builder: (context) =>   UserCreation(pUserRole: wstrRole.toString(), pPageMode: 'EDIT', pPageUserCd: frSelectedUser, pStockistCode: (widget.pStockistCode??""), pDealerCode: (widget.pDealerCode??""), pfnCallBack: (){},)));
         }else if(mode == "P"){
           Navigator.push(context, MaterialPageRoute(builder: (context) =>  UserPrize(pUserCode: frSelectedUser,)  ));

         }else if(mode == "S"){
           Navigator.push(context, MaterialPageRoute(builder: (context) =>  UserSalesRate(pUserCode: frSelectedUser,)  ));

         }else if(mode == "G"){
           Navigator.push(context, MaterialPageRoute(builder: (context) =>  UserGameCount(pUserCode: frSelectedUser,)  ));

         }else if(mode == "N"){
           Navigator.push(context, MaterialPageRoute(builder: (context) =>  UserNumberCount(pUserCode: frSelectedUser, pUserRole: wstrRole,)  ));

         }
       },
       duration: Duration(milliseconds: 110),
       child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12,horizontal: 10),
          decoration: boxDecoration(Colors.white, 10),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(icon,color: grey,size: 20,),
                  tcn(text, grey, 18),
                  gapHC(10)
                ],
              )
            ],
          ),
        ),
     );
    }

  //========================================PAGE FN
    fnGetPageData(){
      if(mounted){
        setState(() {
          frSelectedUser =  widget.pUserCode;
          wstrRole =  widget.pUserRole;
        });
      }
    }

  //========================================API CALL


  apiBlockUnblock(mode){
    Navigator.pop(context);
    futureForm =  apiCall.apiBlockUnblock(g.wstrCompany, frSelectedUser,mode);
    futureForm.then((value) => apiBlockUnblockRes(value));
  }
  apiBlockUnblockRes(value){
    if(mounted){
      if(g.fnValCheck(value)){
        //[{STATUS: 1, MSG: ADDED}]
        var sts = (value[0]["STATUS"]??"").toString();
        var msg = (value[0]["MSG"]??"").toString();
        if(sts == "1"){
           Navigator.pop(context);
           successMsg(context, "Blocked");
           widget.fnCallBack();

        }else{
          errorMsg(context, msg.toString());
        }

      }else{
        errorMsg(context, "Please try again");
      }
    }
  }

}
