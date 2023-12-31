
 
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:get/get.dart';
import 'package:ltr/controller/global/globalValues.dart';
import 'package:ltr/main.dart';
import 'package:ltr/services/apiController.dart';
import 'package:ltr/views/components/alertDialog/alertDialog.dart';
import 'package:ltr/views/components/common/common.dart';
import 'package:ltr/views/components/enum.dart';
import 'package:ltr/views/components/inputfield/commonTextField.dart';
import 'package:ltr/views/pages/user/usersearch.dart';
import 'package:ltr/views/styles/colors.dart';
import 'package:marquee/marquee.dart';
import 'dart:isolate';

class RetailBooking extends StatefulWidget {
  final String? mode;
  final String? pDocno;
  final List<dynamic>? pData;
  final Function? fnCallBack;
  const RetailBooking({Key? key, this.mode, this.pDocno, this.pData, this.fnCallBack}) : super(key: key);

  @override
  _RetailBookingState createState() => _RetailBookingState();
}
enum Menu { itemOne, itemTwo, itemThree, itemFour }
class _RetailBookingState extends State<RetailBooking> {

  //Global
  var g =  Global();
  var apiCall  = ApiCall();
  late Future<dynamic> futureForm;
  var wstrPageMode = "ADD";

  //Page variable
  var lstrSelectedGame = "";
  var lstrSelectedGameColor = bgColorDark;
  var countList = [];
  var frGameList = [];
  var blFromTo = false;
  var fTotalAmount = 0.0;
  var fTotalCount = 0.0;
  var fStockistCode = "";
  var fDealerCode = "";
  var fAgentCode = "";

  var fBookingNo = "";
  var fBookingDoctype = "";
  var fEndTime  =  "";

  //Game
  var gCountNum = 3;
  var gOption  = "";
  var gSelectR = false;
  var gSelectS = false;

  //price
  var supPrice  = 0.0;
  var boxPrice  = 0.0;
  var twoPrice  = 0.0;
  var onePrice  = 0.0;

  //Edit
  var editDocno = "";
  var editCustomer = "";
  var editAgent = "";
  var editNetAmount = "";
  var editGameDocno = "";



  //Controller

  var txtNum = TextEditingController();
  var txtNumTo = TextEditingController();
  var txtDiff = TextEditingController();
  var txtCount = TextEditingController();
  var txtBoxCount = TextEditingController();
  var txtName = TextEditingController();
  var txtChangeQty = TextEditingController();
  var txtWhatsapp = TextEditingController();

  var fnNum = FocusNode();
  var fnNumTo = FocusNode();
  var fnDiff = FocusNode();
  var fnCount = FocusNode();
  var fnBoxCount = FocusNode();
  var fnName = FocusNode();


  var lstrSelectedPlan = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fnValidateBooking();

  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return WillPopScope(child: Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        margin: MediaQuery.of(context).padding,
        child: Column(
          children: [

            Container(
              padding: const EdgeInsets.all(10),
              decoration: boxDecoration(Colors.black, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [


                          widget.mode != "EDIT"?
                          PopupMenuButton<Menu>(
                            position: PopupMenuPosition.under,
                            tooltip: "",
                            onSelected: (Menu item) {

                            },
                            shape:  RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            itemBuilder: (BuildContext context) => <PopupMenuEntry<Menu>>[
                              PopupMenuItem<Menu>(
                                value: Menu.itemOne,
                                padding: const EdgeInsets.symmetric(vertical: 0,horizontal: 0),
                                child: wGamePopup(size),
                              ),
                            ],
                            child:   Row(
                              children: [
                                Column(
                                  children: [
                                    tcn('Retail- $lstrSelectedGame', Colors.white, 20),
                                  ],
                                ),
                                gapWC(5),
                               // const Icon(Icons.dashboard_outlined,color: Colors.white,size: 20,),
                              ],
                            ),
                          ):gapHC(0),

                        ],
                      ),


                      widget.mode != "EDIT"?
                      Bounce(
                        onPressed: (){
                          fnSave();
                        },
                        duration: const Duration(milliseconds: 110),
                        child: Container(
                          decoration: boxDecoration(Colors.white, 30),
                          padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.task_alt,color: Colors.black,size: 15,),
                              gapWC(5),
                              tcn('Save', Colors.black, 15)
                            ],
                          ),
                        ),
                      ):
                      Bounce(
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
                              tcn('Update', g.wstrGameOTColor, 15)
                            ],
                          ),
                        ),
                      ),
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
                ],
              ),
            ),
            gapHC(5),
            widget.mode != "EDIT"?
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 5),
              padding: const EdgeInsets.all(10),
              decoration: boxDecoration(Colors.white, 10),
              child: Column(
                children: [
                  Row(
                    children: [
                      (g.wstrUserRole == "ADMIN")?
                      Expanded(child: Bounce(
                        onPressed: (){

                          if(countList.isNotEmpty){
                            PageDialog().cDialog(context, "WARNING!!", "Do you want to change?\nSelected numbers will Lost.", (){
                              Navigator.pop(context);
                              Navigator.push(context, MaterialPageRoute(builder: (context) =>   UserSearch(pRoleCode: "Stockist", pUserCode: g.wstrUserCd.toString(), pFnCallBack: fnSearchCallBack,)));
                            });
                          }else{
                            Navigator.push(context, MaterialPageRoute(builder: (context) =>   UserSearch(pRoleCode: "Stockist", pUserCode: g.wstrUserCd.toString(), pFnCallBack: fnSearchCallBack,)));
                          }

                         },
                        duration: const Duration(milliseconds: 110),
                        child: Container(
                          margin:const  EdgeInsets.symmetric(horizontal: 2),
                          padding: const EdgeInsets.all(5),
                          decoration: boxOutlineCustom1(Colors.white, 5, Colors.black, 1.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  tcn('Stockist ', Colors.black, 10),
                                  tc(fStockistCode.toString(), Colors.black, 13),
                                ],
                              ),
                              const Icon(Icons.search,color: Colors.grey,size: 18,)
                            ],
                          ),
                        ),
                      )):gapHC(0),
                      (g.wstrUserRole.toString().toUpperCase() == "ADMIN" || g.wstrUserRole.toString().toUpperCase() == "STOCKIST")?
                      Expanded(child: Bounce(
                        onPressed: (){

                          if(fStockistCode.isEmpty){
                            errorMsg(context, "Choose Stockist");
                            return;
                          }

                          if(countList.isNotEmpty){
                            PageDialog().cDialog(context, "WARNING!!", "Do you want to change?\nSelected numbers will Lost.", (){
                              Navigator.pop(context);
                              Navigator.push(context, MaterialPageRoute(builder: (context) =>   UserSearch(pRoleCode: "Dealer", pUserCode: fStockistCode, pFnCallBack: fnSearchCallBack,)));
                            });
                          }else{
                            Navigator.push(context, MaterialPageRoute(builder: (context) =>   UserSearch(pRoleCode: "Dealer", pUserCode: fStockistCode, pFnCallBack: fnSearchCallBack,)));
                          }


                        },
                        duration: const Duration(milliseconds: 110),
                        child: Container(
                          margin:const  EdgeInsets.symmetric(horizontal: 2),
                          padding: const EdgeInsets.all(5),
                          decoration: boxOutlineCustom1(Colors.white, 5, Colors.black, 1.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  tcn('Dealer ', Colors.black, 10),
                                  tc(fDealerCode.toString(), Colors.black, 13),
                                ],
                              ),
                              const Icon(Icons.search,color: Colors.grey,size: 18,)
                            ],
                          ),
                        ),
                      )):gapHC(0),
                      (g.wstrUserRole.toString().toUpperCase() == "ADMIN" || g.wstrUserRole.toString().toUpperCase() == "STOCKIST"|| g.wstrUserRole.toString().toUpperCase() == "DEALER")?
                      Expanded(child: Bounce(
                        onPressed: (){

                          if(fDealerCode.isEmpty){
                            errorMsg(context, "Choose Dealer");
                            return;
                          }

                          if(countList.isNotEmpty){
                            PageDialog().cDialog(context, "WARNING!!", "Do you want to change?\nSelected numbers will Lost.", (){
                              Navigator.pop(context);
                              Navigator.push(context, MaterialPageRoute(builder: (context) =>   UserSearch(pRoleCode: "Agent", pUserCode: fDealerCode, pFnCallBack: fnSearchCallBack,)));
                            });
                          }else{
                            Navigator.push(context, MaterialPageRoute(builder: (context) =>   UserSearch(pRoleCode: "Agent", pUserCode: fDealerCode, pFnCallBack: fnSearchCallBack,)));
                          }


                        },
                        duration: const Duration(milliseconds: 110),
                        child: Container(
                          margin:const  EdgeInsets.symmetric(horizontal: 2),
                          padding: const EdgeInsets.all(5),
                          decoration: boxOutlineCustom1(Colors.white, 5, Colors.black, 1.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  tcn('Agent ', Colors.black, 10),
                                  tc(fAgentCode.toString(), Colors.black, 13),
                                ],
                              ),
                              Icon(Icons.search,color: Colors.grey,size: 18,)
                            ],
                          ),
                        ),
                      )):gapHC(0)
                    ],
                  ),
                  gapHC(5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      wNumberCard(3),
                      gapWC(10),
                      Expanded(child: Container(
                        height: 35,
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        decoration: boxBaseDecoration(greyLight, 5),
                        child: TextFormField(
                          controller: txtName,
                          focusNode: fnName,
                          decoration: const InputDecoration(
                            hintText: 'Name',
                            counterText: "",
                            border: InputBorder.none,
                          ),
                          onChanged: (val){

                          },
                        ),
                      )),

                    ],
                  ),
                  gapHC(5),
                  // Row(
                  //   children: [
                  //     Flexible(
                  //         flex: 2,
                  //         child: Row(
                  //           children: [
                  //             tcn('Number', Colors.black, 12)
                  //           ],
                  //         )
                  //     ),
                  //     gapWC(5),
                  //     blFromTo?
                  //     Flexible(
                  //         flex: 2,
                  //         child: Row(
                  //           children: [
                  //             tcn('To', Colors.black, 12)
                  //           ],
                  //         )
                  //     ):gapWC(0),
                  //     blFromTo?
                  //     gapWC(5):gapWC(0),
                  //     Flexible(
                  //         flex: 2,
                  //         child: Row(
                  //           children: [
                  //             tcn('Count', Colors.black, 12)
                  //           ],
                  //         )
                  //     ),
                  //     gapWC(5),
                  //     gCountNum == 3 && !blFromTo?
                  //     Flexible(
                  //         flex: 2,
                  //         child: Row(
                  //           children: [
                  //             tcn('Box Count', Colors.black, 12)
                  //           ],
                  //         )
                  //     ):gapHC(0),
                  //   ],
                  // ),
                  gapHC(2),
                  Row(
                    children: [
                      Flexible(
                        child: Container(
                          height: 35,
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          decoration: boxBaseDecoration(greyLight, 5),
                          child: TextFormField(
                            controller: txtNum,
                            focusNode: fnNum,
                            maxLength: gCountNum,
                            inputFormatters: mfnInputFormatters(),
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              hintText: 'Num',
                              counterText: "",
                              border: InputBorder.none,
                            ),
                            onChanged: (val){
                              if(val.toString().length == gCountNum){
                                if(blFromTo){
                                  fnNumTo.requestFocus();
                                }else{
                                  fnCount.requestFocus();
                                }

                              }
                            },
                          ),
                        ),
                      ),
                      gapWC(5),
                      blFromTo && (gOption != "Box" && gOption != "S" && gOption !="Book")?
                      Flexible(
                        child: Container(
                          height: 35,
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          decoration: boxBaseDecoration(greyLight, 5),
                          child: TextFormField(
                            controller: txtNumTo,
                            focusNode: fnNumTo,
                            maxLength: gCountNum,
                            inputFormatters: mfnInputFormatters(),
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              hintText: 'To',
                              counterText: "",
                              border: InputBorder.none,
                            ),
                            onChanged: (val){
                              if(val.toString().length == gCountNum){
                                if(gOption == "Any" || (gOption == "R")){
                                  fnDiff.requestFocus();

                                }else{
                                  fnCount.requestFocus();
                                }
                              }
                            },
                          ),
                        ),
                      ):gapWC(0),
                      blFromTo?gapWC(5):gapWC(0),
                      blFromTo && (gOption =="Any" || (gOption == "R"))?
                      Flexible(
                        child: Container(
                          height: 35,
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          decoration: boxBaseDecoration(greyLight, 5),
                          child: TextFormField(
                            controller: txtDiff,
                            focusNode: fnDiff,
                            inputFormatters: mfnInputFormatters(),
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              hintText: 'Diff',
                              border: InputBorder.none,
                            ),
                            onFieldSubmitted: (val){
                              fnBoxCount.requestFocus();
                            },
                          ),
                        ),
                      ):gapWC(0),
                      gapWC(10),
                      wButton("SUPER",bgColorDark),

                    ],
                  ),
                  gapHC(5),


                ],
              ),
            ):
            Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.symmetric(horizontal: 10),
              decoration:  boxDecoration( Colors.white, 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  tcn("BILL ID : ", Colors.black, 12),
                  tc(widget.pDocno.toString(), Colors.black, 12),
                  gapWC(20),
                  Expanded(child:
                    Container(
                      height: 35,
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      decoration: boxBaseDecoration(greyLight, 5),
                      child: TextFormField(
                        controller: txtName,
                        focusNode: fnName,
                        decoration: const InputDecoration(
                          hintText: 'Name',
                          counterText: "",
                          border: InputBorder.none,
                        ),
                        onChanged: (val){

                        },
                      ),
                    )
                  )
                ],
              ),
            ),
            gapHC(5),
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                decoration: boxDecoration(Colors.white, 10),
                child: Column(
                  children: [
                    Container(
                      decoration: boxBaseDecorationC(Colors.black,10,10,0,0),
                      padding: const EdgeInsets.all(5),
                      child: Row(
                        children: [
                          wHeadRow("Plan",8),
                          wHeadRow("Number",8),
                          wHeadRow("Count",6),
                          wHeadRow("Total",6),
                          wHeadRow("",4),
                        ],
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(  
                          padding: const EdgeInsets.all(0),
                          physics: const AlwaysScrollableScrollPhysics(),
                          itemCount: countList.length,
                          itemBuilder: (context, index) {
                            var e = countList.reversed.toList()[index];
                            var qty = g.mfnDbl(e["COUNT"].toString());
                            var amount = g.mfnDbl(e["AMOUNT"].toString());
                            var total = qty*amount;
                            var color = Colors.white;
                            var deleteYn = (e["DELETE_YN"]??"");
                            var errorYn = (e["ERROR_YN"]??"");
                            color = (e["STATUS"]??"")=="Y" || (e["ERROR_YN"]??"")=="Y"?Colors.white:e["PLAN"] == "SUPER"?Colors.black: e["PLAN"] == "BOX" ? Colors.pink: e["PLAN"].toString().length == 2?Colors.green:e["PLAN"].toString().length ==1?Colors.orange:Colors.white;
                            return deleteYn !="Y"? Container(
                              padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 2),
                              decoration: boxBaseDecoration((e["STATUS"]??"")=="Y"?Colors.redAccent.withOpacity(0.8):(e["ERROR_YN"]??"")=="Y"?Colors.purple.withOpacity(0.8): Colors.white, 0),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      wDetRowColor(e["PLAN"].toString(),8,color),
                                      wDetRowColor(e["NUMBER"].toString(),8,color),
                                      Flexible(
                                        flex: 6,
                                        child: GestureDetector(
                                          onTap: (){
                                            if(widget.pDocno.toString().isNotEmpty){
                                              txtChangeQty.clear();
                                              txtChangeQty.text = e["COUNT"].toString();
                                              PageDialog().showCaptcha(context,
                                                  Container(
                                                    child: Column(
                                                      children: [
                                                        Row(),
                                                        CustomTextField(
                                                          keybordType: TextInputType.number,
                                                          controller: txtChangeQty,
                                                          hintText: "Count",
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
                                                                if(mounted){
                                                                  Navigator.pop(context);
                                                                  setState(() {
                                                                    if(txtChangeQty.text.isNotEmpty){
                                                                      e["COUNT"] = txtChangeQty.text;
                                                                      e["EDIT_YN"] = "Y";
                                                                    }
                                                                  });
                                                                  fnCalc();
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
                                                  ), "Update");
                                            }
                                          },
                                          child: Row(
                                            children: [
                                              tc(e["COUNT"].toString(),color, 15)
                                            ],
                                          ),
                                        ),
                                      ),
                                      wDetRowColor(total.toString(),6,color),
                                      Flexible(
                                        flex:4,
                                        child: GestureDetector(
                                          onTap: (){
                                            if(mounted){
                                              setState(() {
                                                e["STATUS"] = (e["STATUS"]??"") == ""?"Y":"";
                                              });
                                              fnCalc();
                                            }
                                          },
                                          child: Container(
                                            color: Colors.transparent,
                                            child: Center(
                                              child: Container(
                                                margin: const EdgeInsets.only(top: 2),
                                                padding: const  EdgeInsets.all(1),
                                                decoration: boxOutlineCustom1((e["STATUS"]??"")=="Y"?Colors.transparent:Colors.black, 5,(e["STATUS"]??"")=="Y"?Colors.white:Colors.black, 1.0),
                                                child: Icon(Icons.done,color: (e["STATUS"]??"")=="Y"?Colors.transparent:Colors.white,size: 14,),
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  gapHC(3),
                                  const Divider(
                                    color: Colors.grey,
                                    height: 0.1,
                                  ),
                                ],
                              ),
                            ):gapHC(0);

                          }
                      ),
                    )
                  ],
                ),
              ),
            ),

            // Expanded(
            //   child: Container(
            //      margin: const EdgeInsets.symmetric(horizontal: 10),
            //     decoration: boxDecoration(Colors.white, 10),
            //     child:  ScrollConfiguration(
            //       behavior: MyCustomScrollBehavior(),
            //       child: SingleChildScrollView(
            //         child: Column(
            //           children: [
            //             Table(
            //               border: const TableBorder(horizontalInside: BorderSide(width: 0.3, color: grey)),
            //               columnWidths: const <int, TableColumnWidth>{
            //                 0: FlexColumnWidth(8),
            //                 1: FlexColumnWidth(8),
            //                 2: FlexColumnWidth(6),
            //                 3: FlexColumnWidth(6),
            //                 4: FlexColumnWidth(4),
            //               },
            //               children: wCountList(),
            //             )
            //           ],
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
            gapHC(5),
            Container(
              padding: const EdgeInsets.all(5),
              margin: const EdgeInsets.symmetric(horizontal: 5),
              decoration: boxDecoration(Colors.white, 8),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      tcn('Total', Colors.black, 15),
                      tcn(fTotalCount.toStringAsFixed(0), Colors.black, 20),
                      tc(fTotalAmount.toStringAsFixed(2), Colors.black, 20)
                    ],
                  ),
                  const Divider(
                    height: 5,
                  ),
                  Container(
                      height: 15,
                      child: Row(
                        children: [
                          Expanded(
                            child: Marquee(text: "BOOKING CLOSE @ $fEndTime",blankSpace: 30.0,style: TextStyle(color: Colors.black,fontSize: 12),),
                          ),
                        ],
                      )
                  )
                ],
              ),
            ),
            gapHC(5),
            widget.mode != "EDIT"?
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(child: Bounce(
                    onPressed: (){
                      fnSave();
                    },
                    duration: const Duration(milliseconds: 110),
                    child: Container(
                      decoration: boxDecoration(Colors.black, 30),
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
              ),
            ):
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
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
                          tcn('Update', g.wstrGameOTColor, 15)
                        ],
                      ),
                    ),
                  ),),
                  gapWC(10),
                  Expanded(child: Bounce(
                    onPressed: (){
                      //fnSave();
                      if(widget.mode == "EDIT"){
                        PageDialog().deleteDialog(context, apiDeleteBooking);
                      }
                    },
                    duration: const Duration(milliseconds: 110),
                    child: Container(
                      decoration: boxDecoration(Colors.redAccent  , 30),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.delete,color: g.wstrGameOTColor,size: 15,),
                          gapWC(5),
                          tcn('Delete', g.wstrGameOTColor, 15)
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
              ),
            ),
            gapHC(5),
          ],
        ),
      ),
    ),
        onWillPop: () async{
          return fnBack();
        });
  }

  //=======================================WIDGET


  Widget wHeadRow(text,flex){
    return     Flexible(
        flex: flex,
        child: Row(
          children: [
            tcn(text.toString(), Colors.white, 15)
          ],
        ));
  }
  Widget wDetRowColor(text,flex,color){
    return     Flexible(
        flex: flex,
        child: Row(
          children: [
            tc(text.toString(),color, 15)
          ],
        ));
  }
  Widget wDetRow(text,flex,sts){
    return     Flexible(
        flex: flex,
        child: Row(
          children: [
            tcn(text.toString(),sts =="Y"?Colors.white: Colors.black, 15)
          ],
        ));
  }
  Widget wDetRowBold(text,flex,sts){
    return     Flexible(
        flex: flex,
        child: Row(
          children: [
            tc(text.toString(),sts =="Y"?Colors.white: Colors.black, 15)
          ],
        ));
  }

  Widget wNumberCard(num){
    return  Bounce(
      onPressed: (){
        if(mounted){
          setState(() {
            gCountNum = num;
            gOption = "";
            blFromTo = false;
            txtNum.clear();
            txtCount.clear();
            txtBoxCount.clear();
            fnNum.requestFocus();
          });
        }
      },
      duration: const Duration(milliseconds: 110),
      child: Container(
        height: 30,
        width: 30,
        alignment: Alignment.center,
        decoration: gCountNum == num?boxBaseDecoration(Colors.redAccent, 5):boxOutlineCustom1(Colors.white, 5, Colors.redAccent, 1.0),
        child: tc(num.toString(), gCountNum == num?g.wstrGameOTColor:g.wstrGameTColor, 15),
      ),
    );
  }
  Widget wRS(rs){
    return  Bounce(
      onPressed: (){
        if(mounted){
          setState(() {
            if(rs=="R"){
              gSelectR = !gSelectR;
            }else  if(rs=="S"){
              gSelectS = !gSelectS;
            }
          });
        }
      },
      duration: const Duration(milliseconds: 110),
      child: Container(
        height: 25,
        width: 25,
        alignment: Alignment.center,
        decoration: (rs == "R" && gSelectR) ||  (rs == "S" && gSelectS)  ?boxBaseDecoration(bgColorDark, 5):boxOutlineCustom1(Colors.white, 5, bgColorDark, 1.0),
        child: tcn(rs.toString(), (rs == "R" && gSelectR) ||  (rs == "S" && gSelectS)?Colors.white:bgColorDark, 15),
      ),
    );
  }
  Widget wOption(rs){
    var short = "";
    if(rs == "S"){
      short = "Box";
    }
    if(rs == "R"){
      short = "Any";
    }
    return  Bounce(
      onPressed: (){
        if(mounted){
          setState(() {

            gOption = gOption==  rs?"": rs;
            blFromTo = gOption.isNotEmpty? true :false;

            if((gOption == "Any") || (gOption == "R")){
               txtDiff.text = "1";
            }

          });
        }
      },
      duration: const Duration(milliseconds: 110),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 1,horizontal: 8),
        alignment: Alignment.center,
        decoration: gOption == rs  ?boxBaseDecoration(g.wstrGameBColor, 5):boxOutlineCustom1(Colors.white, 5, g.wstrGameBColor, 1.0),
        child: tcn(rs.toString(), gOption == rs?g.wstrGameOTColor:g.wstrGameTColor, 15),
      ),
    );
  }
  Widget wButton(text,color){
    return Flexible(
      child: Bounce(
        onPressed: (){
          // if(mounted){
          //   setState(() {
          //     lstrSelectedPlan =text;
          //   });
          // }
          fnGenerateNumber(text);

        },
        duration: const Duration(milliseconds: 110),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: boxBaseDecoration(Colors.redAccent, 30),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  tc(text.toString(), Colors.white, 15)
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
  Widget wGamePopup(size){
    return Container(
      width: 200,
      decoration: boxBaseDecoration(Colors.white, 0),
      padding: const EdgeInsets.only(left: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: wBranchCard(),
      ),
    );
  }
  List<Widget> wBranchCard(){
    List<Widget> rtnList  =  [];
    for(var e in frGameList){
      var colorCode = (e["CODE"]??"").toString();
      var color  =  colorCode == "1PM"?oneColor:colorCode == "3PM"?threeColor:colorCode == "6PM"?sixColor:colorCode == "8PM"?eightColor:Colors.amber;

      rtnList.add(GestureDetector(
        onTap: (){

          Navigator.pop(context);
          setState(() {
            lstrSelectedGameColor = color;
            lstrSelectedGame = (e["CODE"]??"").toString();
          });
          apiValidateGame(lstrSelectedGame);
        },
        child: Container(
          decoration: boxBaseDecoration(color, 5),
          padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 5),
          margin: const EdgeInsets.only(bottom: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.confirmation_num,color:Colors.white,size: 15,),
              gapWC(5),
              tcn((e["CODE"]??"").toString(), Colors.white, 15)
            ],
          ),
        ),
      ));
    }

    return rtnList;
  }
  List<TableRow> wCountList(){
    List<TableRow> rtnList = [];
    rtnList.add(
      TableRow(

          decoration: boxBaseDecorationC(grey,10,10,0,0),
          children: [

            TableCell(
                child: Container(
                  padding: const EdgeInsets.all(5),
                  child: tcn('Plan', Colors.white, 15),
                )
            ),
            TableCell(
                child: Container(
                  padding: const EdgeInsets.all(5),
                  child: tcn('Number', Colors.white, 15),
                )
            ),
            TableCell(
                child: Container(
                  padding: const EdgeInsets.all(5),
                  child: tcn('Count', Colors.white, 15),
                )
            ),
            // TableCell(
            //     child: Container(
            //       padding: const EdgeInsets.all(5),
            //       child: tcn('Amount', Colors.white, 10),
            //     )
            // ),
            TableCell(
                child: Container(
                  padding: const EdgeInsets.all(5),
                  child: tcn('Total', Colors.white, 15),
                )
            ),
            TableCell(
                child: Container(
                  padding: const EdgeInsets.all(5),
                  child: tcn('', Colors.white, 15),
                )
            ),


          ])
    );
    var srno = 1;
    var totalAmount = 0.0;
    var totalCount = 0.0;
    for(var e in countList.reversed.toList()){
      var qty = g.mfnDbl(e["COUNT"].toString());
      var amount = g.mfnDbl(e["AMOUNT"].toString());
      var total = qty*amount;
      var color = Colors.white;
      color = (e["STATUS"]??"")=="Y"?Colors.white:e["PLAN"] == "SUPER"?Colors.black: e["PLAN"] == "BOX" ? Colors.pink: e["PLAN"].toString().length == 2?Colors.green:e["PLAN"].toString().length ==1?Colors.orange:Colors.white;
      rtnList.add(TableRow(
          decoration: boxBaseDecoration((e["STATUS"]??"")=="Y"?Colors.redAccent.withOpacity(0.8): Colors.white, 0),
          children: [
            // TableCell(
            //     child:    Container(
            //       padding: const EdgeInsets.all(5),
            //       child: tc(srno.toString(), Colors.black, 15),
            //     )
            // ),
            TableCell(
                child: GestureDetector(
                  onTap: (){

                  },
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    child: tc(e["PLAN"].toString(), color, 15),
                  ),
                )
            ),
            TableCell(
                child: Container(
                  padding: const EdgeInsets.all(5),
                  child: tc(e["NUMBER"].toString(), color, 15),
                )
            ),
            TableCell(
                child: GestureDetector(
                  onTap: (){
                    txtChangeQty.clear();
                    txtChangeQty.text = e["COUNT"].toString();
                    PageDialog().showCaptcha(context,
                     Container(
                         child: Column(
                           children: [
                             Row(),
                             CustomTextField(
                               keybordType: TextInputType.number,
                               controller: txtChangeQty,
                               hintText: "Count",
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
                                     if(mounted){
                                       Navigator.pop(context);
                                       setState(() {
                                         if(txtChangeQty.text.isNotEmpty){
                                           e["COUNT"] = txtChangeQty.text;
                                         }
                                       });
                                       fnCalc();
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
                       ), "Update");
                  },
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    child: tc(e["COUNT"].toString(), color, 15),
                  ),
                )
            ),
            // TableCell(
            //     child: Container(
            //       padding: const EdgeInsets.all(5),
            //       child: tc(e["AMOUNT"].toString(), Colors.black, 12),
            //     )
            // ),
            TableCell(
                child: Container(
                  padding: const EdgeInsets.all(5),
                  child: tc(total.toString(), color, 15),
                )
            ),
            TableCell(
                child: GestureDetector(
                  onTap: (){
                    if(mounted){
                      setState(() {
                        e["STATUS"] = (e["STATUS"]??"") == ""?"Y":"";
                      });
                      fnCalc();
                    }
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: Container(
                        color: Colors.transparent,
                        child: Center(
                          child: Container(
                            margin: const EdgeInsets.only(top: 2),
                            padding: const  EdgeInsets.all(1),
                            decoration: boxOutlineCustom1((e["STATUS"]??"")=="Y"?Colors.transparent:Colors.black, 5,(e["STATUS"]??"")=="Y"?Colors.white:Colors.black, 1.0),
                            child: Icon(Icons.done,color: (e["STATUS"]??"")=="Y"?Colors.transparent:Colors.white,size: 14,),
                          ),
                        ),
                      ))
                    ],
                  ),
                )
            ),


          ]));
      srno= srno+1;
      totalAmount = totalAmount+total;
      totalCount = totalCount + qty;

    }
    return rtnList;
  }


  //=======================================PAGE FN
  fnShowPopUp(){
    PageDialog().showWhatsapp(context, Container(
      child: Column(
        children: [
          Container(
            height: 200,
            padding: const EdgeInsets.symmetric(horizontal: 15),
            decoration: boxBaseDecoration(greyLight, 5),
            child: TextFormField(
              controller: txtWhatsapp,
              maxLines: 5,
              decoration: const InputDecoration(
                hintText: 'Paste here....',
                counterText: "",
                border: InputBorder.none,
              ),
              onChanged: (val){

              },
            ),
          ),
          gapHC(10),
          Bounce(
            onPressed: (){
              if(txtWhatsapp.text.isNotEmpty){
                fnExtractWhatsappNum();
              }else{
                Navigator.pop(context);
              }
            },
            duration: const Duration(milliseconds: 110),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: boxDecoration(g.wstrGameColor, 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  tcn('GENERATE', Colors.white, 15)
                ],
              ),
            ),
          )
        ],
      ),
    ), "Whatsapp");
  }
  fnValidateBooking(){
    if(mounted){
      setState(() {
        lstrSelectedGame = g.wstrSelectedGame;
        lstrSelectedGameColor = g.wstrGameColor;
      });
    }
    apiValidateGame(g.wstrSelectedGame);
  }
  fnGetPageData(){
      if(mounted){

      if(g.wstrUserRole.toString().toUpperCase() == "STOCKIST" ){
        setState(() {
          fStockistCode = g.wstrUserCd;
        });
      }else if( g.wstrUserRole.toString().toUpperCase() == "DEALER" ){
        setState(() {
          fDealerCode = g.wstrUserCd;
        });
      }else if( g.wstrUserRole.toString().toUpperCase() == "AGENT" ){
        setState(() {
          fAgentCode = g.wstrUserCd;
        });
      }

      try{
        fEndTime =  setDate(7, DateTime.parse(g.wstrSGameEnd.toString()));
      }catch(e){
        dprint(e);
      }
        if((widget.pDocno??"").isNotEmpty){
          fnEditFill();
        }else{
          apiGetGameList();
        }
      }
    }
  fnSearchCallBack(rolecode,usercd){
    if(mounted){
      setState(() {
        if(rolecode == "Stockist"){
          if(fStockistCode != usercd){
            fDealerCode = "";
            fAgentCode = "";
            countList = [];
          }
          fStockistCode = usercd;
        }else if(rolecode == "Dealer"){
          if(fDealerCode != usercd){
            fAgentCode = "";
            countList = [];
          }
          fDealerCode = usercd;

        }else if(rolecode == "Agent"){
          if(fAgentCode != usercd){
            countList = [];
          }
          fAgentCode = usercd;

        }
      });
      // if(rolecode == "Agent"){
      //   apiGetDetails();
      // }
    }
  }
  fnGenerateNumber(plan){
    if(fAgentCode.isEmpty){
      errorMsg(context, "Choose Agent");
      return;
    }
    txtCount.text = "1";
    if(g.mfnDbl(txtCount.text) <=0 && plan == "BOX" && txtBoxCount.text.isNotEmpty){
      txtCount.text =  txtBoxCount.text;
    }

    if(g.mfnDbl(txtCount.text) <=0 ){
      // if(!(gCountNum == 3 && blFromTo && gOption == "Book")){
      //   return;
      // }
      return;
    }

    var price  = plan == "SUPER" ?supPrice:plan == "BOX" ?boxPrice:gCountNum ==2 ?twoPrice:gCountNum ==1 ?onePrice:0.0;

    if(gCountNum == 3){

      if(blFromTo){

        if(g.mfnDbl(txtNum.text) >= g.mfnDbl(txtNumTo.text) && (gOption != "Box" && gOption != "S" &&  gOption!="Book")){
          errorMsg(context, "Entered number not valid");
          return;
        }

        if(gOption == "100s" || gOption == "111s"){

          var fromNum = txtNum.text[0];
          var toNum = txtNumTo.text[0];
          fromNum = fromNum.isEmpty?"1":fromNum;

          for(var i = g.mfnDbl(fromNum);i <= g.mfnDbl(toNum);i++ ){
            if(gOption == "100s"){

              if(plan == "BOTH"){
                if(fnCheckNumberInList("${i.toString()[0]}00","SUPER")){
                  countList.add({
                    "PLAN":"SUPER",
                    "NUMBER":"${i.toString()[0]}00",
                    "COUNT":g.mfnInt(txtCount.text.toString()).toString(),
                    "AMOUNT":supPrice,
                  });
                }
                if(fnCheckNumberInList("${i.toString()[0]}00","BOX")){
                  countList.add({
                    "PLAN":"BOX",
                    "NUMBER":"${i.toString()[0]}00",
                    "COUNT":g.mfnInt(txtCount.text.toString()).toString(),
                    "AMOUNT":boxPrice,
                  });
                }

              }else{
                if(fnCheckNumberInList("${i.toString()[0]}00",plan)){
                  countList.add({
                    "PLAN":plan,
                    "NUMBER":"${i.toString()[0]}00",
                    "COUNT":g.mfnInt(txtCount.text.toString()).toString(),
                    "AMOUNT":price,
                  });
                }

              }

            }else{

              if(plan == "BOTH"){
                if(fnCheckNumberInList((i.toString()[0]+i.toString()[0]+i.toString()[0]).toString(),"SUPER")){
                  countList.add({
                    "PLAN":"SUPER",
                    "NUMBER":(i.toString()[0]+i.toString()[0]+i.toString()[0]).toString(),
                    "COUNT":g.mfnInt(txtCount.text.toString()).toString(),
                    "AMOUNT":supPrice,
                  });
                }
                if(fnCheckNumberInList((i.toString()[0]+i.toString()[0]+i.toString()[0]).toString(),"BOX")){
                  countList.add({
                    "PLAN":"BOX",
                    "NUMBER":(i.toString()[0]+i.toString()[0]+i.toString()[0]).toString(),
                    "COUNT":g.mfnInt(txtCount.text.toString()).toString(),
                    "AMOUNT":boxPrice,
                  });
                }

              }else{
                if(fnCheckNumberInList((i.toString()[0]+i.toString()[0]+i.toString()[0]).toString(),plan)){
                  countList.add({
                    "PLAN":plan,
                    "NUMBER":(i.toString()[0]+i.toString()[0]+i.toString()[0]).toString(),
                    "COUNT":g.mfnInt(txtCount.text.toString()).toString(),
                    "AMOUNT":price,
                  });
                }

              }


            }
          }
        }
        else if(gOption == "Book" ){

          dprint("STARTED");
          if(txtNum.text.toString().length != gCountNum){
            return;
          }
          dprint("NOW");
          var fromNum = txtNum.text;
          var toNum = g.mfnDbl(fromNum)+4;
          if(toNum >= 999){
            toNum = 999;
          }
          for(var i = g.mfnDbl(fromNum);i <= toNum;i++ ){

            var iNum = i.toStringAsFixed(0);
            iNum = iNum.length ==1?('00$iNum').toString():iNum.length ==2?('0$iNum').toString():iNum;
            if(iNum.length == 3){
              if(plan == "BOTH"){
                if(fnCheckNumberInList(iNum.toString(),"SUPER")){
                  countList.add({
                    "PLAN":"SUPER",
                    "NUMBER":iNum.toString(),
                    "COUNT":g.mfnInt(txtCount.text.toString()).toString(),
                    "AMOUNT":supPrice,
                  });
                }
                if(fnCheckNumberInList(iNum.toString(),"BOX")){
                  countList.add({
                    "PLAN":"BOX",
                    "NUMBER":iNum.toString(),
                    "COUNT":g.mfnInt(txtCount.text.toString()).toString(),
                    "AMOUNT":boxPrice,
                  });
                }
            }else{
                dprint("123");
                if(fnCheckNumberInList(iNum.toString(),plan)){
                  countList.add({
                    "PLAN":plan,
                    "NUMBER":iNum.toString(),
                    "COUNT":g.mfnInt(txtCount.text.toString()).toString(),
                    "AMOUNT":price,
                  });
                }

              }



            }
          }

        }
        else if(gOption == "Any" || (gOption == "R")){
          if(txtNum.text.toString().length != gCountNum  || txtNumTo.text.toString().length != gCountNum){
            return;
          }
          var fromNum = txtNum.text;
          var toNum = txtNumTo.text;
          var diffVal = g.mfnDbl(txtDiff.text) == 0?1.0:g.mfnDbl(txtDiff.text);
          for(var i = g.mfnDbl(fromNum);i <= g.mfnDbl(toNum);i = i+ diffVal ){

            var iNum = i.toStringAsFixed(0);
            iNum = iNum.length ==1?('00$iNum').toString():iNum.length ==2?('0$iNum').toString():iNum;

            if(plan == "BOTH"){
              if(fnCheckNumberInList(iNum.toString(),"SUPER")){
                countList.add({
                  "PLAN":"SUPER",
                  "NUMBER":iNum,
                  "COUNT":g.mfnInt(txtCount.text.toString()).toString(),
                  "AMOUNT":supPrice,
                });
              }
              if(fnCheckNumberInList(iNum.toString(),"BOX")){
                countList.add({
                  "PLAN":"BOX",
                  "NUMBER":iNum,
                  "COUNT":g.mfnInt(txtCount.text.toString()).toString(),
                  "AMOUNT":boxPrice,
                });
              }

            }else{
              if(fnCheckNumberInList(iNum.toString(),plan)){
                countList.add({
                  "PLAN":plan,
                  "NUMBER":iNum,
                  "COUNT":g.mfnInt(txtCount.text.toString()).toString(),
                  "AMOUNT":price,
                });
              }

            }
          }

        }
        else if(gOption == "Box" || gOption == "S"){
          if(txtNum.text.toString().length != 3){
            return;
          }
          var fromNum = txtNum.text;

          List<int> digits = fromNum.toString().split('').map(int.parse).toList();
          List<List<int>> combinations = permute(digits);

          for(var e in combinations){
            var num  = "${e[0]}${e[1]}${e[2]}";
            if(plan == "BOTH"){
              if(fnCheckNumberInList(num,"SUPER")){
                countList.add({
                  "PLAN":"SUPER",
                  "NUMBER":num,
                  "COUNT":g.mfnInt(txtCount.text.toString()).toString(),
                  "AMOUNT":supPrice,
                });
              }
              if(fnCheckNumberInList(num,"BOX")){
                countList.add({
                  "PLAN":"BOX",
                  "NUMBER":num,
                  "COUNT":g.mfnInt(txtCount.text.toString()).toString(),
                  "AMOUNT":boxPrice,
                });
              }
            }else{
              if(fnCheckNumberInList(num,plan)){
                countList.add({
                  "PLAN":plan,
                  "NUMBER":num,
                  "COUNT":g.mfnInt(txtCount.text.toString()).toString(),
                  "AMOUNT":price,
                });
              }
            }
          }



        }



      }
      else{
        if(txtNum.text.toString().length != gCountNum ){
          return;
        }

        if(g.mfnDbl(txtCount.text) <=0){
          return;
        }


        if(plan == "BOTH"){

          var bCount = txtBoxCount.text.isEmpty?txtCount.text:txtBoxCount.text;

          if(fnCheckNumberInList(txtNum.text,"SUPER")){
            countList.add({
              "PLAN":"SUPER",
              "NUMBER":txtNum.text,
              "COUNT":g.mfnInt(txtCount.text.toString()).toString(),
              "AMOUNT":supPrice,
            });
          }
          if(fnCheckNumberInList(txtNum.text,"BOX")){
            countList.add({
              "PLAN":"BOX",
              "NUMBER":txtNum.text,
              "COUNT":g.mfnInt(bCount.toString()).toString(),
              "AMOUNT":boxPrice,
            });
          }
        }else{
          var bCount = txtBoxCount.text.isEmpty?txtCount.text:txtBoxCount.text;

          if(fnCheckNumberInList(txtNum.text,plan)){
            countList.add({
              "PLAN":plan,
              "NUMBER":txtNum.text,
              "COUNT": plan == "BOX"?g.mfnInt(bCount.toString()).toString(): g.mfnInt(txtCount.text).toString(),
              "AMOUNT":price,
            });
          }
        }



      }

    }
    else if(gCountNum == 2 && blFromTo){
      if(g.mfnDbl(txtNum.text) >= g.mfnDbl(txtNumTo.text) && (gOption != "Box" && gOption != "S" && gOption !="Book")){
        errorMsg(context, "Entered number not valid");
        return;
      }
      if(gOption == "10s" || gOption == "11s"){

        var fromNum = txtNum.text[0];
        var toNum = txtNumTo.text[0];
        fromNum = fromNum.isEmpty?"1":fromNum;

        for(var i = g.mfnDbl(fromNum);i <= g.mfnDbl(toNum);i++ ){
          if(gOption == "10s"){

            if(plan == "ALL"){
              if(fnCheckNumberInList("${i.toString()[0]}0","AB")){
                countList.add({
                  "PLAN":"AB",
                  "NUMBER":"${i.toString()[0]}0",
                  "COUNT":g.mfnInt(txtCount.text.toString()).toString(),
                  "AMOUNT":twoPrice,
                });
              }
              if(fnCheckNumberInList("${i.toString()[0]}0","BC")){
                countList.add({
                  "PLAN":"BC",
                  "NUMBER":"${i.toString()[0]}0",
                  "COUNT":g.mfnInt(txtCount.text.toString()).toString(),
                  "AMOUNT":twoPrice,
                });
              }
              if(fnCheckNumberInList("${i.toString()[0]}0","AC")){
                countList.add({
                  "PLAN":"AC",
                  "NUMBER":"${i.toString()[0]}0",
                  "COUNT":g.mfnInt(txtCount.text.toString()).toString(),
                  "AMOUNT":twoPrice,
                });
              }

            }else{
              if(fnCheckNumberInList("${i.toString()[0]}0",plan)){
                countList.add({
                  "PLAN":plan,
                  "NUMBER":"${i.toString()[0]}0",
                  "COUNT":g.mfnInt(txtCount.text.toString()).toString(),
                  "AMOUNT":price,
                });
              }

            }

          }
          else{

            if(plan == "ALL"){
              if(fnCheckNumberInList((i.toString()[0]+i.toString()[0]).toString(),"AB")){
                countList.add({
                  "PLAN":"AB",
                  "NUMBER":(i.toString()[0]+i.toString()[0]).toString(),
                  "COUNT":g.mfnInt(txtCount.text.toString()).toString(),
                  "AMOUNT":supPrice,
                });
              }
              if(fnCheckNumberInList((i.toString()[0]+i.toString()[0]).toString(),"BC")){
                countList.add({
                  "PLAN":"BC",
                  "NUMBER":(i.toString()[0]+i.toString()[0]).toString(),
                  "COUNT":g.mfnInt(txtCount.text.toString()).toString(),
                  "AMOUNT":boxPrice,
                });
              }
              if(fnCheckNumberInList((i.toString()[0]+i.toString()[0]).toString(),"AC")){
                countList.add({
                  "PLAN":"AC",
                  "NUMBER":(i.toString()[0]+i.toString()[0]).toString(),
                  "COUNT":g.mfnInt(txtCount.text.toString()).toString(),
                  "AMOUNT":boxPrice,
                });
              }

            }else{
              if(fnCheckNumberInList((i.toString()[0]+i.toString()[0]).toString(),plan)){
                countList.add({
                  "PLAN":plan,
                  "NUMBER":(i.toString()[0]+i.toString()[0]).toString(),
                  "COUNT":g.mfnInt(txtCount.text.toString()).toString(),
                  "AMOUNT":price,
                });
              }

            }


          }
        }
      }
      else if(gOption == "Book" ){
        if(txtNum.text.toString().length != gCountNum  ){
          return;
        }
        var fromNum = txtNum.text;
        var toNum = g.mfnDbl(fromNum)+4;
        if(toNum >= 99){
          toNum = 99;
        }
        for(var i = g.mfnDbl(fromNum);i <= toNum;i++ ){

          var iNum = i.toStringAsFixed(0);
          iNum = iNum.length ==1?('0$iNum').toString():iNum;

          if(iNum.length ==2){
            if(plan == "ALL"){
              if(fnCheckNumberInList(iNum.toString(),"AB")){
                countList.add({
                  "PLAN":"AB",
                  "NUMBER":iNum.toString(),
                  "COUNT":g.mfnInt(txtCount.text.toString()).toString(),
                  "AMOUNT":twoPrice,
                });
              }
              if(fnCheckNumberInList(iNum.toString(),"BC")){
                countList.add({
                  "PLAN":"BC",
                  "NUMBER":iNum.toString(),
                  "COUNT":g.mfnInt(txtCount.text.toString()).toString(),
                  "AMOUNT":twoPrice,
                });
              }
              if(fnCheckNumberInList(iNum.toString(),"AC")){
                countList.add({
                  "PLAN":"AC",
                  "NUMBER":iNum.toString(),
                  "COUNT":g.mfnInt(txtCount.text.toString()).toString(),
                  "AMOUNT":twoPrice,
                });
              }

            }else{
              if(fnCheckNumberInList(iNum.toString(),plan)){
                countList.add({
                  "PLAN":plan,
                  "NUMBER":iNum.toString(),
                  "COUNT":g.mfnInt(txtCount.text.toString()).toString(),
                  "AMOUNT":price,
                });
              }

            }
          }
        }

      }
      else if(gOption == "Any" || (gOption == "R")){
        if(txtNum.text.toString().length != gCountNum  || txtNumTo.text.toString().length != gCountNum){
          return;
        }
        var fromNum = txtNum.text;
        var toNum = txtNumTo.text;
        var diffVal = g.mfnDbl(txtDiff.text) == 0?1.0:g.mfnDbl(txtDiff.text);
        for(var i = g.mfnDbl(fromNum);i <= g.mfnDbl(toNum);i = i+ diffVal ){

          var iNum = i.toStringAsFixed(0);
          iNum = iNum.length ==1?('0$iNum').toString():iNum;

          if(plan == "ALL"){
            if(fnCheckNumberInList(iNum.toString(),"AB")){
              countList.add({
                "PLAN":"AB",
                "NUMBER":iNum,
                "COUNT":g.mfnInt(txtCount.text.toString()).toString(),
                "AMOUNT":twoPrice,
              });
            }

            if(fnCheckNumberInList(iNum.toString(),"BC")){
              countList.add({
                "PLAN":"BC",
                "NUMBER":iNum,
                "COUNT":g.mfnInt(txtCount.text.toString()).toString(),
                "AMOUNT":twoPrice,
              });
            }

            if(fnCheckNumberInList(iNum.toString(),"AC")){
              countList.add({
                "PLAN":"AC",
                "NUMBER":iNum,
                "COUNT":g.mfnInt(txtCount.text.toString()).toString(),
                "AMOUNT":twoPrice,
              });
            }

          }else{
            if(fnCheckNumberInList(iNum.toString(),plan)){
              countList.add({
                "PLAN":plan,
                "NUMBER":iNum,
                "COUNT":g.mfnInt(txtCount.text.toString()).toString(),
                "AMOUNT":price,
              });
            }

          }
        }

      }

    }
    else{
      if(txtNum.text.toString().length != gCountNum ){
        return;
      }
      if(g.mfnDbl(txtCount.text) <=0){
        return;
      }

      if(gOption == "2s" ){
        for(var i = 0;i <= 9;i=i+2 ){
          if(plan == "ALL"){
            if(fnCheckNumberInList(i,"A")){
              countList.add({
                "PLAN":"A",
                "NUMBER":i,
                "COUNT":g.mfnInt(txtCount.text.toString()).toString(),
                "AMOUNT":onePrice,
              });
            }
            if(fnCheckNumberInList(i,"B")){
              countList.add({
                "PLAN":"B",
                "NUMBER":i,
                "COUNT":g.mfnInt(txtCount.text.toString()).toString(),
                "AMOUNT":onePrice,
              });
            }
            if(fnCheckNumberInList(i,"C")){
              countList.add({
                "PLAN":"C",
                "NUMBER":i,
                "COUNT":g.mfnInt(txtCount.text.toString()).toString(),
                "AMOUNT":onePrice,
              });
            }

          }
          else{
            if(fnCheckNumberInList(i,plan)){
              countList.add({
                "PLAN":plan,
                "NUMBER":i,
                "COUNT":g.mfnInt(txtCount.text.toString()).toString(),
                "AMOUNT":price,
              });
            }

          }
        }
      }
      else if(gOption == "Any" || (gOption == "R")){
        if(txtNum.text.toString().length != gCountNum  || txtNumTo.text.toString().length != gCountNum){
          return;
        }
        var fromNum = txtNum.text;
        var toNum = txtNumTo.text;
        var diffVal = g.mfnDbl(txtDiff.text) == 0?1.0:g.mfnDbl(txtDiff.text);
        for(var i = g.mfnDbl(fromNum);i <= g.mfnDbl(toNum);i = i+ diffVal ){

          var iNum = i.toStringAsFixed(0);

          if(plan == "ALL"){
            if(fnCheckNumberInList(iNum.toString(),"A")){
              countList.add({
                "PLAN":"A",
                "NUMBER":iNum,
                "COUNT":g.mfnInt(txtCount.text.toString()).toString(),
                "AMOUNT":onePrice,
              });
            }

            if(fnCheckNumberInList(iNum.toString(),"B")){
              countList.add({
                "PLAN":"B",
                "NUMBER":iNum,
                "COUNT":g.mfnInt(txtCount.text.toString()).toString(),
                "AMOUNT":onePrice,
              });
            }

            if(fnCheckNumberInList(iNum.toString(),"C")){
              countList.add({
                "PLAN":"C",
                "NUMBER":iNum,
                "COUNT":g.mfnInt(txtCount.text.toString()).toString(),
                "AMOUNT":onePrice,
              });
            }

          }else{
            if(fnCheckNumberInList(iNum.toString(),plan)){
              countList.add({
                "PLAN":plan,
                "NUMBER":iNum,
                "COUNT":g.mfnInt(txtCount.text.toString()).toString(),
                "AMOUNT":price,
              });
            }

          }
        }

      }
      else{
        if(plan =="ALL"){
          var planName = txtNum.text.length == 2?"AB":"A";
          if(fnCheckNumberInList(txtNum.text,planName)){
            countList.add({
              "PLAN":planName,
              "NUMBER":txtNum.text,
              "COUNT":g.mfnInt(txtCount.text.toString()).toString(),
              "AMOUNT":price,
            });
          }
          planName = txtNum.text.length == 2?"BC":"B";
          if(fnCheckNumberInList(txtNum.text,planName)){
            countList.add({
              "PLAN":planName,
              "NUMBER":txtNum.text,
              "COUNT":g.mfnInt(txtCount.text.toString()).toString(),
              "AMOUNT":price,
            });
          }
          planName = txtNum.text.length == 2?"AC":"C";
          if(fnCheckNumberInList(txtNum.text,planName)){
            countList.add({
              "PLAN":planName,
              "NUMBER":txtNum.text,
              "COUNT":g.mfnInt(txtCount.text.toString()).toString(),
              "AMOUNT":price,
            });
          }
        }else{
          if(fnCheckNumberInList(txtNum.text,plan)){
            countList.add({
              "PLAN":plan,
              "NUMBER":txtNum.text,
              "COUNT":g.mfnInt(txtCount.text.toString()).toString(),
              "AMOUNT":price,
            });
          }
        }
      }





    }



    if(mounted){
      setState(() {
        txtNum.clear();
        txtNumTo.clear();
        txtDiff.clear();
        //txtCount.clear();
        txtCount.selection = TextSelection(baseOffset: 0, extentOffset: txtCount.text.length);
        txtBoxCount.clear();
        fnNum.requestFocus();
      });
    }

    fnCalc();


  }
  fnCalc(){
    if(mounted){
      var totalAmount = 0.0;
      var totalCount = 0.0;

      for(var e in countList){
        var qty = g.mfnDbl(e["COUNT"].toString());
        var amount = g.mfnDbl(e["AMOUNT"].toString());
        var total = qty*amount;
        var sts =  (e["STATUS"]??"");

        if(sts  == ""){
          totalAmount = totalAmount+total;
          totalCount = totalCount + qty;
        }



      }
      setState(() {
        fTotalAmount = totalAmount;
        fTotalCount = totalCount;
      });
    }
  }
  fnSave(){
    if(countList.isEmpty) {
      errorMsg(context, "Choose Numbers");
      return;
    }
    // if(txtName.text.isEmpty){
    //   errorMsg(context, "Enter Name");
    //   fnName.requestFocus();
    //   return;
    // }

    // Check time
    var det =[];

    for(var e in countList){
      var qty =  g.mfnDbl(e["COUNT"].toString());
      var rate =  g.mfnDbl(e["AMOUNT"].toString());
      var sts =  (e["STATUS"]??"").toString();
      var total  =  qty * rate;
      e["ERROR_YN"]="N";
      if(widget.mode == "EDIT"){
        det.add({
          "GAME_TYPE":e["PLAN"],
          "NUMBER":e["NUMBER"],
          "QTY":e["COUNT"],
          "RATE":e["AMOUNT"],
          "TOT_AMT":total,
          "DELETE_YN":sts,
          "EDIT_YN":(e["EDIT_YN"]??""),
        });

      }else{
        if(sts != "Y"){
          det.add({
            "GAME_TYPE":e["PLAN"],
            "NUMBER":e["NUMBER"],
            "QTY":e["COUNT"],
            "RATE":e["AMOUNT"],
            "TOT_AMT":total,

          });
        }
      }


    }

    if(det.isEmpty) {
      errorMsg(context, "Choose Numbers");
      return;
    }

    if(widget.mode == "EDIT"){
      apiEditBooking(det);
    }else{
      apiSaveBooking(det);
    }


  }

  fnEditFill(){
    if(mounted){

      var dataList = [];
      dataList = (widget.pData??[]);
      if(dataList.isEmpty){
        Navigator.pop(context);
        return;
      }
      else{

        var detData =  dataList[0]["DET"];

       setState(() {

         txtName.text =   (dataList[0]["CUSTOMER_NAME"]??"").toString();

         editDocno = (dataList[0]["DOCNO"]??"").toString();
         editCustomer = (dataList[0]["CUSTOMER_NAME"]??"").toString();
         editAgent = (dataList[0]["AGENT_CODE"]??"").toString();
         editGameDocno = (dataList[0]["GAME_DOCNO"]??"").toString();

         for(var e in detData){
           countList.add({
             "PLAN":e["GAME_TYPE"],
             "NUMBER":e["NUMBER"],
             "COUNT":e["QTY"],
             "AMOUNT":e["RATE"],
             "EDIT_YN":e["EDIT_YN"],
             "DELETE_YN":e["DELETE_YN"],
             "STATUS":e["DELETE_YN"],
           });
         }
       });

      }


      fnCalc();


    }
  }
  List<List<int>> permute(List<int> digits) {
    List<List<int>> result = [];
    void backtrack(List<int> curr, List<int> remaining) {
      if (remaining.isEmpty) {
        result.add(curr);
        return;
      }
      for (int i = 0; i < remaining.length; i++) {
        List<int> newCurr = List.from(curr);
        newCurr.add(remaining[i]);
        List<int> newRemaining = List.from(remaining);
        newRemaining.removeAt(i);
        backtrack(newCurr, newRemaining);
      }
    }
    backtrack([], digits);
    return result;
  }
  fnCheckNumberInList(number,plan){
    return true;
    // if(countList.where((element) => element["NUMBER"].toString() == number.toString() && element["PLAN"].toString() == plan.toString()).isEmpty){
    //   return true;
    // }else{
    //   return false;
    // }
  }
  fnCancel(){
    fnBack();
  }
  fnGameTime(){
     
  }
  fnClear(){
    if(mounted){
      setState(() {

        countList = [];
        frGameList = [];
        blFromTo = false;
        fTotalAmount = 0.0;
        fTotalCount = 0.0;
        fStockistCode = "";
        fDealerCode = "";
        fAgentCode = "";
        fBookingNo = "";
        fBookingDoctype = "";
        fEndTime  =  "";

        gCountNum = 3;
        gOption  = "";
        gSelectR = false;
        gSelectS = false;

        supPrice  = 8.0;
        boxPrice  = 7.0;
        twoPrice  = 9.0;
        onePrice  = 10.0;

        editDocno = "";
        editCustomer = "";
        editAgent = "";
        editNetAmount = "";
        editGameDocno = "";
      });
    }
    fnGetPageData();
  }

  //=======================================WHATSAPP#



  fnExtractWhatsappNum(){

    //1.number,2.a count,3.b count,3.b count,4.a type,5.b type,6.c type // format

    //if(number length == 3)
    //need to consider a count and b count
    //length ==3 and a count/ b count is not empty super,box
    //length ==3 and b.count is empty and type is empty it means super
    //length ==3 and a count/ b is empty type = 'B' 'BOX' /'S' 'SUPER'

    //length == 2 or length == 1 and count based on type
    // a count = a type
    // b count = b type
    // c count = c type

    Navigator.pop(context);

    if(fAgentCode.isEmpty){
      errorMsg(context, "Choose Agent");
      return;
    }

    var text = txtWhatsapp.text.toString();

    List<String> textLines = text.split("\n");

    dprint("TEXT LINE>>>>>>>>>>>>>>>>>>>>>>>");
    dprint(textLines);
    for(var txt in textLines){
      List<String> delimiters = [',','.', '*', '#', '+', '-','=','_'];
      List<String> result = splitTextWithDelimiters(txt, delimiters);
      dprint(result);
      var num  = "";
      var aCount  = "";
      var bCount  = "";
      var cCount  = "";
      var aType  = "";
      var bType  = "";
      var cType  = "";

      num =  fnGetNum(result,0);
      aCount =  fnGetNum(result,1);
      bCount =  fnGetNum(result,2);

      dprint(num);
      if(num.length == 3){
        if(g.mfnDbl(bCount) == 0){
          aType =  fnGetNum(result,2);
        }

        //length ==3 and a count/ b count is not empty super,box
        //length ==3 and b.count is empty and type is empty it means super
        //length ==3 and a count/ b is empty type = 'B' 'BOX' /'S' 'SUPER'

        if(g.mfnDbl(bCount)>0){
          countList.add({
            "PLAN":"SUPER",
            "NUMBER":num,
            "COUNT":aCount,
            "AMOUNT":supPrice,
          });
          countList.add({
            "PLAN":"BOX",
            "NUMBER":num,
            "COUNT":bCount,
            "AMOUNT":boxPrice,
          });

        }else{
          dprint("A TYPE >>>>>>>>>>>>>  $aType");
          if(aType.isEmpty){
            countList.add({
              "PLAN":"SUPER",
              "NUMBER":num,
              "COUNT":aCount,
              "AMOUNT":supPrice,
            });
          }else{
            if(aType == "B" ||  aType == "BOX"){
              countList.add({
                "PLAN":"BOX",
                "NUMBER":num,
                "COUNT":aCount,
                "AMOUNT":boxPrice,
              });
            }else if(aType == "S" ||  aType == "SUPER" || aType == "SUP" || aType == "SPR" || aType == "SP"){
              countList.add({
                "PLAN":"SUPER",
                "NUMBER":num,
                "COUNT":aCount,
                "AMOUNT":supPrice,
              });
            }
          }
        }

      }
      else {
        if(g.mfnDbl(bCount) == 0){
          aType =  fnGetNum(result,2);
          if(aType.isNotEmpty){
            bType =  fnGetNum(result,3);
            if(bType.isNotEmpty){
              cType =  fnGetNum(result,4);
            }
          }
        }
        else{
          cCount =  fnGetNum(result,3);
          if(g.mfnDbl(cCount) == 0){
            aType =  fnGetNum(result,3);
            if(aType.isNotEmpty){
              bType =  fnGetNum(result,4);
              if(bType.isNotEmpty){
                cType =  fnGetNum(result,5);
              }
            }
          }else{
            aType =  fnGetNum(result,4);
            if(aType.isNotEmpty){
              bType =  fnGetNum(result,5);
              if(bType.isNotEmpty){
                cType =  fnGetNum(result,6);
              }
            }
          }
        }

        dprint("A COUNT >>>>>> $aCount");
        dprint("B COUNT >>>>>> $bCount");
        dprint("C COUNT >>>>>> $cCount");
        var priceWp = 0.0;

        if(num.length ==2){
          priceWp = twoPrice;
          if(aType != "AB" && aType != "BC" && aType != "AC"){
            aType = "";
          }
          if(bType != "AB" && bType != "BC" && bType != "AC"){
            bType = "";
          }
          if(cType != "AB" && cType != "BC" && cType != "AC"){
            cType = "";
          }
        }else if(num.length ==1){
          priceWp = onePrice;
          if(aType != "A" && aType != "B" && aType != "B"){
            aType = "";
          }
          if(bType != "A" && bType != "B" && bType != "C"){
            bType = "";
          }
          if(cType != "A" && cType != "B" && cType != "C"){
            cType = "";
          }
        }

        dprint("A TYPE >>>>>> $aType");
        dprint("B TYPE >>>>>> $bType");
        dprint("C TYPE >>>>>> $cType");




        if(g.mfnDbl(cCount) >0 ){
          if(cType.isNotEmpty){
            countList.add({
              "PLAN":aType,
              "NUMBER":num,
              "AMOUNT":priceWp,
              "COUNT":aCount,
            });
            countList.add({
              "PLAN":bType,
              "NUMBER":num,
              "COUNT":bCount,
              "AMOUNT":priceWp,
            });
            countList.add({
              "PLAN":cType,
              "NUMBER":num,
              "COUNT":cCount,
              "AMOUNT":priceWp,
            });
          }else{
            if(aType.isNotEmpty){
              countList.add({
                "PLAN":aType,
                "NUMBER":num,
                "COUNT":aCount,
                "AMOUNT":priceWp,
              });
              countList.add({
                "PLAN":aType,
                "NUMBER":num,
                "COUNT":bCount,
                "AMOUNT":priceWp,
              });
              countList.add({
                "PLAN":aType,
                "NUMBER":num,
                "COUNT":cCount,
                "AMOUNT":priceWp,
              });
            }
          }
        }
        else if(g.mfnDbl(bCount) >0){
          if(bType.isNotEmpty){
            countList.add({
              "PLAN":aType,
              "NUMBER":num,
              "COUNT":aCount,
              "AMOUNT":priceWp,
            });
            countList.add({
              "PLAN":bType,
              "NUMBER":num,
              "COUNT":bCount,
              "AMOUNT":priceWp,
            });
          }else{
            if(aType.isNotEmpty){
              countList.add({
                "PLAN":aType,
                "NUMBER":num,
                "COUNT":aCount,
                "AMOUNT":priceWp,
              });
              countList.add({
                "PLAN":aType,
                "NUMBER":num,
                "COUNT":bCount,
                "AMOUNT":priceWp,
              });
            }
          }
        }
        else if(g.mfnDbl(aCount) >0){
          if(cType.isNotEmpty){
            countList.add({
              "PLAN":aType,
              "NUMBER":num,
              "COUNT":aCount,
              "AMOUNT":priceWp,
            });
            countList.add({
              "PLAN":bType,
              "NUMBER":num,
              "COUNT":aCount,
              "AMOUNT":priceWp,
            });
            countList.add({
              "PLAN":cType,
              "NUMBER":num,
              "COUNT":aCount,
              "AMOUNT":priceWp,
            });
          }else if(bType.isNotEmpty){
            countList.add({
              "PLAN":aType,
              "NUMBER":num,
              "COUNT":aCount,
              "AMOUNT":priceWp,
            });
            countList.add({
              "PLAN":bType,
              "NUMBER":num,
              "COUNT":aCount,
              "AMOUNT":priceWp,
            });
          }
          else if(aType.isNotEmpty){
            countList.add({
              "PLAN":aType,
              "NUMBER":num,
              "COUNT":aCount,
              "AMOUNT":priceWp,
            });
          }
        }
      }


    }

    if(mounted){
      setState(() {
        countList.removeWhere((element) => element["PLAN"] =="");
        txtWhatsapp.clear();
      });
    }

    fnCalc();
    dprint(countList);

  }
  List<String> splitTextWithDelimiters(String text, List<String> delimiters) {
    String pattern = delimiters.map((delimiter) => '\\$delimiter').join('|');
    RegExp regExp = RegExp(pattern);
    return text.split(regExp);
  }


  fnGetNum(list,index){
    var result = "";
    try{
      result  = list[index].toString().toUpperCase().replaceAll(" ", "");
    }catch(e){
      dprint(e);
    }
    return result;
  }



  //=======================================API CALL


  apiValidateGame(game){
    futureForm =  ApiCall().apiValidateGame(g.wstrCompany, g.wstrUserCd,  game, setDate(2, DateTime.now()));
    futureForm.then((value) => apiValidateGameRes(value));
  }
  apiValidateGameRes(value){
    if(mounted){
      if(g.fnValCheck(value)){
        try{
          var sts  =  (value[0]["STATUS"]??"").toString();
          var msg  =  value[0]["MSG"];
          if(sts == "1"){
            var docno  =   value[0]["DOCNO"];
            var doctype  =   value[0]["DOCTYPE"];
            var startTime  =   value[0]["START_TIME"];
            var endTime  =   value[0]["END_TIME"];
            var sysTime  =   value[0]["SYS_TIME"];
            var currTime  =   DateTime.now();
            setState(() {
              g.wstrSGameDocNo = docno;
              g.wstrSGameDoctype = doctype;
              g.wstrSGameStart = startTime;
              g.wstrSGameEnd = endTime;
              try{
                g.wstrSysTime = DateTime.parse(sysTime.toString());
              }catch(e){
                dprint(e);
              }
              g.wstrCurrTime = currTime;
            });
            apiGetDetails();
            fnGetPageData();
          }else{
            Navigator.pop(context);
            errorMsg(context, msg.toString());
          }
        }catch(e){
          Navigator.pop(context);
          errorMsg(context, "Booking not active!");
          dprint(e);
        }
      }else{
        Navigator.pop(context);
        errorMsg(context, "Booking not active!");
      }
    }

  }


  apiGetGameList(){
    //api for get user wise game list
    futureForm = apiCall.apiGetUserGames(g.wstrCompany, g.wstrUserCd, "");
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

  apiAvailableGames(){
    //api for get user wise game list
    futureForm = apiCall.apiAvailableGames(g.wstrCompany, g.wstrUserCd);
    futureForm.then((value) => apiAvailableGamesRes(value));
  }
  apiAvailableGamesRes(value){
    if(mounted){
      setState(() {
        frGameList = [];
        if(g.fnValCheck(value)){
          frGameList = value;
        }
      });
    }
  }

  apiSaveBooking(det){
    futureForm = apiCall.apiSaveBooking("",g.wstrSGameDocNo, g.wstrSGameDoctype, g.wstrCompany, g.wstrUserCd, txtName.text, txtName.text, g.wstrDeivceId, fAgentCode, "ADD", det);
    futureForm.then((value) => apiSaveBookingRes(value));
  }
  apiSaveBookingRes(value){
    if(mounted){

      if(g.fnValCheck(value)){

        try{
          var sts = (value[0]["STATUS"])??"";
          var msg = (value[0]["MSG"])??"";
          if(sts == "1"){
            var docno = (value[0]["DOCNO"])??"";
            if(wstrPageMode == "ADD"){
              fnClear();
            }else{
              Get.back();
            }
            PageDialog().showSaveSuccess(context,(){
              Navigator.pop(context);
            },docno);
          }else if(sts == "0"){
            errorMsg(context, msg);
            try{
              var errorList =  jsonDecode(value[0]["ERROR"]);
              var errorDataList = [];
              print(errorList);


              for(var e in countList){
                if(errorList.where((element) => element["NUMBER"] == e["NUMBER"]).isNotEmpty){
                  errorDataList.add(e);
                }
              }
              for(var e in errorDataList){
                setState(() {
                  countList.remove(e);
                });
              }
              for(var e in errorDataList){
                setState(() {
                  countList.add(e);
                  e["ERROR_YN"]="Y";
                });
              }


            }catch(e){
              dprint(e);
            }
          }else{
            errorMsg(context, msg);
          }
        }catch(e){
          dprint(e);
        }

      }else{
        errorMsg(context, "Failed");
      }

    }
  }

  apiEditBooking(det){
    futureForm = apiCall.apiSaveBooking(editDocno,editGameDocno, g.wstrSGameDoctype, g.wstrCompany, g.wstrUserCd, txtName.text, txtName.text, g.wstrDeivceId, editAgent, "EDIT", det);
    futureForm.then((value) => apiEditBookingRes(value));
  }
  apiEditBookingRes(value){
    if(mounted){

      if(g.fnValCheck(value)){

        try{
          var sts = (value[0]["STATUS"])??"";
          var msg = (value[0]["MSG"])??"";
          if(sts == "1"){
            widget.fnCallBack!();
            Get.back();
            successMsg(context, "BOOKING UPDATED");
          }else{
            errorMsg(context, msg);
          }
        }catch(e){
          dprint(e);
          errorMsg(context, "Try Again!");
        }

      }else{
        errorMsg(context, "Failed");
      }

    }
  }

  apiDeleteBooking(){
    Navigator.pop(context);
    futureForm = apiCall.apiSaveBooking(editDocno,editGameDocno, g.wstrSGameDoctype, g.wstrCompany, g.wstrUserCd, txtName.text, txtName.text, g.wstrDeivceId, editAgent, "DELETE", []);
    futureForm.then((value) => apiDeleteBookingRes(value));
  }
  apiDeleteBookingRes(value){
    if(mounted){

      if(g.fnValCheck(value)){

        try{
          var sts = (value[0]["STATUS"])??"";
          var msg = (value[0]["MSG"])??"";
          if(sts == "1"){
            widget.fnCallBack!();
            Get.back();
            successMsg(context, "BOOKING DELETED");
          }else{
            errorMsg(context, msg);
          }
        }catch(e){
          dprint(e);
          errorMsg(context, "Try Again!");
        }

      }else{
        errorMsg(context, "Failed");
      }

    }
  }

  apiGetDetails(){
    futureForm  = apiCall.apiGetGlobalDetails(g.wstrCompany,"PRICE","");
    futureForm.then((value) => apiGetDetailsRes(value));
  }
  apiGetDetailsRes(value){
    if(mounted){
      if(g.fnValCheck(value)){

        try{
          setState(() {
            dprint("========================================>>>>>>>>>>>>>>>>>>>PRICE");
            for(var e  in value){

              var type = e["TYPE"];
              dprint(e);
              if(type == "SUPER"){
                supPrice = g.mfnDbl(e["PRICE"].toString());
              }else if(type == "BOX"){
                boxPrice = g.mfnDbl(e["PRICE"].toString());
              }else if(type == "AB"){
                twoPrice = g.mfnDbl(e["PRICE"].toString());
              }else if(type == "A"){
                onePrice = g.mfnDbl(e["PRICE"].toString());
              }

            }
            dprint("PRZE supPrice $supPrice");
            dprint("PRZE boxPrice $boxPrice");
            dprint("PRZE twoPrice $twoPrice");
            dprint("PRZE onePrice $onePrice");
            dprint("========================================>>>>>>>>>>>>>>>>>>>PRICE");
          });
        }catch(e){
          dprint(e);
        }

      }
    }
  }


  fnBack(){
    PageDialog().cDialog(context, "Close", "Do you want to close?", fnEnd);
  }
  fnEnd(){
    Navigator.pop(context);
    Navigator.pop(context);
  }

  complexTask2(SendPort sendPort) {
    var total = 0.0;
    sendPort.send(total);
  }

}


