
 
import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:get/get.dart';
import 'package:ltr/controller/global/globalValues.dart';
import 'package:ltr/services/apiController.dart';
import 'package:ltr/views/components/common/common.dart';
import 'package:ltr/views/components/inputfield/commonTextField.dart';
import 'package:ltr/views/pages/user/usersearch.dart';
import 'package:ltr/views/styles/colors.dart';
import 'package:marquee/marquee.dart';

class Booking extends StatefulWidget {
  const Booking({Key? key}) : super(key: key);

  @override
  _BookingState createState() => _BookingState();
}
enum Menu { itemOne, itemTwo, itemThree, itemFour }
class _BookingState extends State<Booking> {

  //Global
  var g =  Global();
  var apiCall  = ApiCall();
  late Future<dynamic> futureForm;
  var wstrPageMode = "ADD";

  //Page variable
  var lstrSelectedGame = "1PM";
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
  var supPrice  = 8.0;
  var boxPrice  = 7.0;
  var twoPrice  = 9.0;
  var onePrice  = 10.0;



  //Controller

  var txtNum = TextEditingController();
  var txtNumTo = TextEditingController();
  var txtDiff = TextEditingController();
  var txtCount = TextEditingController();
  var txtBoxCount = TextEditingController();
  var txtName = TextEditingController();

  var fnNum = FocusNode();
  var fnNumTo = FocusNode();
  var fnDiff = FocusNode();
  var fnCount = FocusNode();
  var fnBoxCount = FocusNode();
  var fnName = FocusNode();


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
        //margin: MediaQuery.of(context).padding,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: boxDecoration(g.wstrGameColor, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  gapHC(25),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.arrow_back_ios,color: Colors.white,size: 20,),
                          gapWC(5),
                          tcn('$lstrSelectedGame Game', Colors.white, 20)
                        ],
                      ),
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
                            child: wGamePopup(),
                          ),
                        ],
                        child:   const Icon(Icons.dashboard_outlined,color: Colors.white,size: 20,),
                      )

                    ],
                  ),
                ],
              ),
            ),
            gapHC(5),
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
                          Navigator.push(context, MaterialPageRoute(builder: (context) =>   UserSearch(pRoleCode: "Stockist", pUserCode: g.wstrUserCd.toString(), pFnCallBack: fnSearchCallBack,)));
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

                          Navigator.push(context, MaterialPageRoute(builder: (context) =>   UserSearch(pRoleCode: "Dealer", pUserCode: fStockistCode, pFnCallBack: fnSearchCallBack,)));

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

                          Navigator.push(context, MaterialPageRoute(builder: (context) =>   UserSearch(pRoleCode: "Agent", pUserCode: fDealerCode, pFnCallBack: fnSearchCallBack,)));

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
                      wNumberCard(1),
                      gapWC(5),
                      wNumberCard(2),
                      gapWC(5),
                      wNumberCard(3),
                      gapWC(20),
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
                      ))

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
                      blFromTo?
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
                                if(gOption == "Any"){
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
                      blFromTo && gOption =="Any"?
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
                      blFromTo && gOption =="Any"?gapWC(5):gapWC(0),
                      Flexible(
                        child: Container(
                          height: 35,
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          decoration: boxBaseDecoration(greyLight, 5),
                          child: TextFormField(
                            controller: txtCount,
                            focusNode: fnCount,
                            inputFormatters: mfnInputFormatters(),
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              hintText: 'Count',
                              border: InputBorder.none,
                            ),
                            onFieldSubmitted: (val){
                              fnBoxCount.requestFocus();
                            },
                          ),
                        ),
                      ),
                      gapWC(5),
                      gCountNum == 3 &&  !blFromTo?
                      Flexible(
                        child: Container(
                          height: 35,
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          decoration: boxBaseDecoration(greyLight, 5),
                          child: TextFormField(
                            controller: txtBoxCount,
                            focusNode: fnBoxCount,
                            inputFormatters: mfnInputFormatters(),
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              hintText: 'Box',
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ):gapHC(0),
                    ],
                  ),
                  gapHC(5),
                  gCountNum == 3?
                  Row(
                    children: [
                      wButton("BOTH",Colors.blueGrey),
                      gapWC(5),
                      wButton("BOX",Colors.pink),
                      gapWC(5),
                      wButton("SUPER",bgColorDark),
                    ],
                  ):
                  gCountNum == 2?
                  Row(
                    children: [
                      wButton("AB",Colors.green),
                      gapWC(5),
                      wButton("BC",Colors.green),
                      gapWC(5),
                      wButton("AC",Colors.green),
                      gapWC(5),
                      wButton("ALL",bgColorDark),
                    ],
                  ):
                  Row(
                    children: [
                      wButton("A",Colors.orange),
                      gapWC(5),
                      wButton("B",Colors.orange),
                      gapWC(5),
                      wButton("C",Colors.orange),
                      gapWC(5),
                      wButton("ALL",bgColorDark),
                    ],
                  ),
                  gapHC(10),
                  gCountNum == 3?
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      wOption("Book"),
                      wOption("Any"),
                      wOption("100s"),
                      wOption("111s"),
                      wOption("Box"),
                    ],
                  ):gapHC(0),
                  gCountNum == 2?
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      wOption("Book"),
                      wOption("Any"),
                      wOption("10s"),
                      wOption("11s"),
                    ],
                  ):gapHC(0),


                ],
              ),
            ),
            gapHC(5),

            
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                decoration: boxDecoration(Colors.white, 10),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Table(
                        border: const TableBorder(horizontalInside: BorderSide(width: 0.3, color: grey)),
                        columnWidths: const <int, TableColumnWidth>{
                          0: FlexColumnWidth(3),
                          1: FlexColumnWidth(10),
                          2: FlexColumnWidth(6),
                          3: FlexColumnWidth(6),
                          4: FlexColumnWidth(6),
                          5: FlexColumnWidth(6),
                        },
                        children: wCountList(),
                      )
                    ],
                  ),
                ),
              ),
            ),
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
            ),
            gapHC(5),
          ],
        ),
      ),
    );
  }

  //=======================================WIDGET


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
        height: 25,
        width: 25,
        alignment: Alignment.center,
        decoration: gCountNum == num?boxBaseDecoration(g.wstrGameBColor, 5):boxOutlineCustom1(Colors.white, 5, g.wstrGameBColor, 1.0),
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
    return  Bounce(
      onPressed: (){
        if(mounted){
          setState(() {

            gOption = gOption==  rs?"": rs;
            blFromTo = gOption.isNotEmpty? true :false;

            if(gOption == "Any"){
               txtDiff.text = "1";
            }

          });
        }
      },
      duration: const Duration(milliseconds: 110),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 2,horizontal: 6),
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
          //fnButtonPres(text);
          fnGenerateNumber(text);
        },
        duration: const Duration(milliseconds: 110),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: boxBaseDecoration(color, 5),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  text == "SUPER"?const Icon(Icons.star_border,color: Colors.white,size: 15,):gapHC(0),
                  text == "SUPER"?gapWC(5):gapHC(0),
                  tc(text.toString(), Colors.white, 15)
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
  Widget wGamePopup(){
    return Container(
      width: 100,
      decoration: boxBaseDecoration(Colors.white, 0),
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: wBranchCard(),
      ),
    );
  }
  List<Widget> wBranchCard(){
    List<Widget> rtnList  =  [];

    for(var e in frGameList){
      rtnList.add(GestureDetector(
        onTap: (){

          Navigator.pop(context);
          setState(() {
            lstrSelectedGame = (e["GAME_CODE"]??"").toString();
          });
        },
        child: Container(
          decoration: boxBaseDecoration(greyLight, 5),
          padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 5),
          margin: const EdgeInsets.only(bottom: 5),
          child: Row(
            children: [
              const Icon(Icons.confirmation_num,color:bgColorDark,size: 15,),
              gapWC(5),
              Expanded(child: tcn((e["GAME_CODE"]??"").toString(), Colors.black, 12))
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
                  child: tcn('Sr.', Colors.white, 10),
                )
            ),
            TableCell(
                child: Container(
                  padding: const EdgeInsets.all(5),
                  child: tcn('Plan', Colors.white, 10),
                )
            ),
            TableCell(
                child: Container(
                  padding: const EdgeInsets.all(5),
                  child: tcn('Number', Colors.white, 10),
                )
            ),
            TableCell(
                child: Container(
                  padding: const EdgeInsets.all(5),
                  child: tcn('Count', Colors.white, 10),
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
                  child: tcn('Total', Colors.white, 10),
                )
            ),
            TableCell(
                child: Container(
                  padding: const EdgeInsets.all(5),
                  child: tcn('', Colors.white, 10),
                )
            ),


          ])
    );
    var srno = 1;
    var totalAmount = 0.0;
    var totalCount = 0.0;
    for(var e in countList){
      var qty = g.mfnDbl(e["COUNT"].toString());
      var amount = g.mfnDbl(e["AMOUNT"].toString());
      var total = qty*amount;
      var color = Colors.white;
      color = (e["STATUS"]??"")=="Y"?Colors.white:e["PLAN"] == "SUPER"?Colors.black: e["PLAN"] == "BOX"? Colors.pink: e["PLAN"].toString().length == 2?Colors.green:e["PLAN"].toString().length ==1?Colors.orange:Colors.white;
      rtnList.add(TableRow(
          decoration: boxBaseDecoration((e["STATUS"]??"")=="Y"?Colors.redAccent.withOpacity(0.8): Colors.white, 0),
          children: [
            TableCell(
                child:    Container(
                  padding: const EdgeInsets.all(5),
                  child: tc(srno.toString(), Colors.black, 12),
                )
            ),
            TableCell(
                child: GestureDetector(
                  onTap: (){

                  },
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    child: tc(e["PLAN"].toString(), color, 12),
                  ),
                )
            ),
            TableCell(
                child: Container(
                  padding: const EdgeInsets.all(5),
                  child: tc(e["NUMBER"].toString(), color, 12),
                )
            ),
            TableCell(
                child: Container(
                  padding: const EdgeInsets.all(5),
                  child: tc(e["COUNT"].toString(), color, 12),
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
                  child: tc(total.toString(), color, 12),
                )
            ),
            TableCell(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: (){
                        if(mounted){
                          setState(() {
                            e["STATUS"] = (e["STATUS"]??"") == ""?"Y":"";
                          });
                          fnCalc();
                        }
                      },
                      child: Container(
                        margin: const EdgeInsets.only(top: 2),
                        padding: const  EdgeInsets.all(1),
                        decoration: boxOutlineCustom1((e["STATUS"]??"")=="Y"?Colors.transparent:Colors.black, 5,(e["STATUS"]??"")=="Y"?Colors.white:Colors.black, 1.0),
                        child: Icon(Icons.done,color: (e["STATUS"]??"")=="Y"?Colors.transparent:Colors.white,size: 14,),
                      ),
                    )
                  ],
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

  fnGetPageData(){
      if(mounted){
        setState(() {
          lstrSelectedGame = g.wstrSelectedGame;
        });
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


        apiAvailableGames();
      }
    }
  fnSearchCallBack(rolecode,usercd){
    if(mounted){
      setState(() {
        if(rolecode == "Stockist"){
          if(fStockistCode != usercd){
            fDealerCode = "";
            fAgentCode = "";
          }
          fStockistCode = usercd;
        }else if(rolecode == "Dealer"){
          if(fDealerCode != usercd){
            fAgentCode = "";
          }
          fDealerCode = usercd;

        }else if(rolecode == "Agent"){
          fAgentCode = usercd;

        }
      });
      if(rolecode == "Agent"){
        apiGetDetails();
      }
    }
  }
  fnButtonPres(plan){

    if(txtNum.text.toString().length != gCountNum ){
      return;
    }
    if(txtCount.text.isEmpty){
      return;
    }
    if(txtBoxCount.text.isEmpty && plan == "BOTH"){
      return;
    }

    if(mounted){
      setState(() {
        if(gCountNum ==3){

          if(blFromTo){


            if(gOption == "100s"){

              var fromNum = txtNum.text[0];
              var toNum = txtNumTo.text[0];
              fromNum = fromNum.isEmpty?"1":fromNum;

              for(var i = g.mfnDbl(fromNum);i <= g.mfnDbl(toNum);i++ ){
                countList.add({
                  "PLAN":plan,
                  "NUMBER":"${i.toString()[0]}00",
                  "COUNT":txtCount.text,
                  "AMOUNT":10.00,
                });
              }


            }
            else if(gOption == "111s"){

              var fromNum = txtNum.text[0];
              var toNum = txtNumTo.text[0];

              fromNum = fromNum.isEmpty?"1":fromNum;

              for(var i = g.mfnDbl(fromNum);i <= g.mfnDbl(toNum);i++ ){
                countList.add({
                  "PLAN":plan,
                  "NUMBER":(i.toString()[0]+i.toString()[0]+i.toString()[0]).toString(),
                  "COUNT":txtCount.text,
                  "AMOUNT":10.00,
                });
              }

            }


          }


          if(plan == "BOTH"){
            countList.add({
              "PLAN":"SUPER",
              "NUMBER":txtNum.text,
              "COUNT":txtCount.text,
              "AMOUNT":10.00,
            });
            countList.add({
              "PLAN":"BOX",
              "NUMBER":txtNum.text,
              "COUNT":txtBoxCount.text,
              "AMOUNT":10.00,
            });
          }else{
            countList.add({
              "PLAN":plan,
              "NUMBER":txtNum.text,
              "COUNT":txtCount.text,
              "AMOUNT":10.00,
            });
          }
        }
        else if(gCountNum ==2){
          if(plan == "ALL"){
            countList.add({
              "PLAN":"AB",
              "NUMBER":txtNum.text,
              "COUNT":txtCount.text,
              "AMOUNT":10.00,
            });
            countList.add({
              "PLAN":"BC",
              "NUMBER":txtNum.text,
              "COUNT":txtCount.text,
              "AMOUNT":10.00,
            });
            countList.add({
              "PLAN":"AC",
              "NUMBER":txtNum.text,
              "COUNT":txtCount.text,
              "AMOUNT":10.00,
            });
          }else{
            countList.add({
              "PLAN":plan,
              "NUMBER":txtNum.text,
              "COUNT":txtCount.text,
              "AMOUNT":10.00,
            });
          }
        }
        else if(gCountNum ==1){
          if(plan == "ALL"){
            countList.add({
              "PLAN":"A",
              "NUMBER":txtNum.text,
              "COUNT":txtCount.text,
              "AMOUNT":10.00,
            });
            countList.add({
              "PLAN":"B",
              "NUMBER":txtNum.text,
              "COUNT":txtCount.text,
              "AMOUNT":10.00,
            });
            countList.add({
              "PLAN":"C",
              "NUMBER":txtNum.text,
              "COUNT":txtCount.text,
              "AMOUNT":10.00,
            });
          }else{
            countList.add({
              "PLAN":plan,
              "NUMBER":txtNum.text,
              "COUNT":txtCount.text,
              "AMOUNT":10.00,
            });
          }
        }


        txtNum.clear();
        txtNumTo.clear();
        txtCount.clear();
        txtBoxCount.clear();
        fnNum.requestFocus();

      });
    }
  }
  fnGenerateNumber(plan){

    if(fAgentCode.isEmpty){
      errorMsg(context, "Choose Agent");
      return;
    }

    if(txtCount.text.isEmpty && plan == "BOX" && txtBoxCount.text.isNotEmpty){
      txtCount.text =  txtBoxCount.text;
    }

    if(txtCount.text.isEmpty ){
      if(!(gCountNum == 3 && blFromTo && gOption == "Book")){
        return;
      }
    }

    var price  = plan == "SUPER" ?supPrice:plan == "BOX" ?boxPrice:gCountNum ==2 ?twoPrice:gCountNum ==1 ?onePrice:0.0;

    if(gCountNum == 3){

      if(blFromTo){

        if(g.mfnDbl(txtNum.text) >= g.mfnDbl(txtNumTo.text) && gOption != "Box"){
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
                    "COUNT":txtCount.text,
                    "AMOUNT":supPrice,
                  });
                }
                if(fnCheckNumberInList("${i.toString()[0]}00","BOX")){
                  countList.add({
                    "PLAN":"BOX",
                    "NUMBER":"${i.toString()[0]}00",
                    "COUNT":txtCount.text,
                    "AMOUNT":boxPrice,
                  });
                }

              }else{
                if(fnCheckNumberInList("${i.toString()[0]}00",plan)){
                  countList.add({
                    "PLAN":plan,
                    "NUMBER":"${i.toString()[0]}00",
                    "COUNT":txtCount.text,
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
                    "COUNT":txtCount.text,
                    "AMOUNT":supPrice,
                  });
                }
                if(fnCheckNumberInList((i.toString()[0]+i.toString()[0]+i.toString()[0]).toString(),"BOX")){
                  countList.add({
                    "PLAN":"BOX",
                    "NUMBER":(i.toString()[0]+i.toString()[0]+i.toString()[0]).toString(),
                    "COUNT":txtCount.text,
                    "AMOUNT":boxPrice,
                  });
                }

              }else{
                if(fnCheckNumberInList((i.toString()[0]+i.toString()[0]+i.toString()[0]).toString(),plan)){
                  countList.add({
                    "PLAN":plan,
                    "NUMBER":(i.toString()[0]+i.toString()[0]+i.toString()[0]).toString(),
                    "COUNT":txtCount.text,
                    "AMOUNT":price,
                  });
                }

              }


            }
          }
        }
        else if(gOption == "Book" ){
          if(txtNum.text.toString().length != gCountNum  || txtNumTo.text.toString().length != gCountNum){
            return;
          }
          var fromNum = txtNum.text;
          var toNum = txtNumTo.text;
          for(var i = g.mfnDbl(fromNum);i <= g.mfnDbl(toNum);i++ ){

            var iNum = i.toStringAsFixed(0);
            iNum = iNum.length ==1?('00$iNum').toString():iNum.length ==2?('0$iNum').toString():iNum;

            if(plan == "BOTH"){
              if(fnCheckNumberInList(iNum.toString(),"SUPER")){
                countList.add({
                  "PLAN":"SUPER",
                  "NUMBER":iNum.toString(),
                  "COUNT":5,
                  "AMOUNT":supPrice,
                });
              }
              if(fnCheckNumberInList(iNum.toString(),"BOX")){
                countList.add({
                  "PLAN":"BOX",
                  "NUMBER":iNum.toString(),
                  "COUNT":5,
                  "AMOUNT":boxPrice,
                });
              }

            }else{
              if(fnCheckNumberInList(iNum.toString(),plan)){
                countList.add({
                  "PLAN":plan,
                  "NUMBER":iNum.toString(),
                  "COUNT":5,
                  "AMOUNT":price,
                });
              }

            }
          }

        }
        else if(gOption == "Any"){
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
                  "COUNT":txtCount.text,
                  "AMOUNT":supPrice,
                });
              }
              if(fnCheckNumberInList(iNum.toString(),"BOX")){
                countList.add({
                  "PLAN":"BOX",
                  "NUMBER":iNum,
                  "COUNT":txtCount.text,
                  "AMOUNT":boxPrice,
                });
              }

            }else{
              if(fnCheckNumberInList(iNum.toString(),plan)){
                countList.add({
                  "PLAN":plan,
                  "NUMBER":iNum,
                  "COUNT":txtCount.text,
                  "AMOUNT":price,
                });
              }

            }
          }

        }
        else if(gOption == "Box"){
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
                  "COUNT":txtCount.text,
                  "AMOUNT":supPrice,
                });
              }
              if(fnCheckNumberInList(num,"BOX")){
                countList.add({
                  "PLAN":"BOX",
                  "NUMBER":num,
                  "COUNT":txtCount.text,
                  "AMOUNT":boxPrice,
                });
              }
            }else{
              if(fnCheckNumberInList(num,plan)){
                countList.add({
                  "PLAN":plan,
                  "NUMBER":num,
                  "COUNT":txtCount.text,
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

        if(txtCount.text.isEmpty){
          return;
        }


        if(plan == "BOTH"){

          var bCount = txtBoxCount.text.isEmpty?txtCount.text:txtBoxCount.text;

          if(fnCheckNumberInList(txtNum.text,"SUPER")){
            countList.add({
              "PLAN":"SUPER",
              "NUMBER":txtNum.text,
              "COUNT":txtCount.text,
              "AMOUNT":supPrice,
            });
          }
          if(fnCheckNumberInList(txtNum.text,"BOX")){
            countList.add({
              "PLAN":"BOX",
              "NUMBER":txtNum.text,
              "COUNT":bCount,
              "AMOUNT":boxPrice,
            });
          }
        }else{
          var bCount = txtBoxCount.text.isEmpty?txtCount.text:txtBoxCount.text;

          if(fnCheckNumberInList(txtNum.text,plan)){
            countList.add({
              "PLAN":plan,
              "NUMBER":txtNum.text,
              "COUNT": plan == "BOX"?bCount: txtCount.text,
              "AMOUNT":price,
            });
          }
        }



      }

    }
    else if(gCountNum == 2 && blFromTo){
      if(g.mfnDbl(txtNum.text) >= g.mfnDbl(txtNumTo.text) && gOption != "Box"){
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
                  "COUNT":txtCount.text,
                  "AMOUNT":twoPrice,
                });
              }
              if(fnCheckNumberInList("${i.toString()[0]}0","BC")){
                countList.add({
                  "PLAN":"BC",
                  "NUMBER":"${i.toString()[0]}0",
                  "COUNT":txtCount.text,
                  "AMOUNT":twoPrice,
                });
              }
              if(fnCheckNumberInList("${i.toString()[0]}0","AC")){
                countList.add({
                  "PLAN":"AC",
                  "NUMBER":"${i.toString()[0]}0",
                  "COUNT":txtCount.text,
                  "AMOUNT":twoPrice,
                });
              }

            }else{
              if(fnCheckNumberInList("${i.toString()[0]}0",plan)){
                countList.add({
                  "PLAN":plan,
                  "NUMBER":"${i.toString()[0]}0",
                  "COUNT":txtCount.text,
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
                  "COUNT":txtCount.text,
                  "AMOUNT":supPrice,
                });
              }
              if(fnCheckNumberInList((i.toString()[0]+i.toString()[0]).toString(),"BC")){
                countList.add({
                  "PLAN":"BC",
                  "NUMBER":(i.toString()[0]+i.toString()[0]).toString(),
                  "COUNT":txtCount.text,
                  "AMOUNT":boxPrice,
                });
              }
              if(fnCheckNumberInList((i.toString()[0]+i.toString()[0]).toString(),"AC")){
                countList.add({
                  "PLAN":"AC",
                  "NUMBER":(i.toString()[0]+i.toString()[0]).toString(),
                  "COUNT":txtCount.text,
                  "AMOUNT":boxPrice,
                });
              }

            }else{
              if(fnCheckNumberInList((i.toString()[0]+i.toString()[0]).toString(),plan)){
                countList.add({
                  "PLAN":plan,
                  "NUMBER":(i.toString()[0]+i.toString()[0]).toString(),
                  "COUNT":txtCount.text,
                  "AMOUNT":price,
                });
              }

            }


          }
        }
      }
      else if(gOption == "Book" ){
        if(txtNum.text.toString().length != gCountNum  || txtNumTo.text.toString().length != gCountNum){
          return;
        }
        var fromNum = txtNum.text;
        var toNum = txtNumTo.text;
        for(var i = g.mfnDbl(fromNum);i <= g.mfnDbl(toNum);i++ ){

          var iNum = i.toStringAsFixed(0);
          iNum = iNum.length ==1?('0$iNum').toString():iNum;

          if(plan == "ALL"){
            if(fnCheckNumberInList(iNum.toString(),"AB")){
              countList.add({
                "PLAN":"AB",
                "NUMBER":iNum.toString(),
                "COUNT":5,
                "AMOUNT":twoPrice,
              });
            }
            if(fnCheckNumberInList(iNum.toString(),"BC")){
              countList.add({
                "PLAN":"BC",
                "NUMBER":iNum.toString(),
                "COUNT":5,
                "AMOUNT":twoPrice,
              });
            }
            if(fnCheckNumberInList(iNum.toString(),"AC")){
              countList.add({
                "PLAN":"AC",
                "NUMBER":iNum.toString(),
                "COUNT":5,
                "AMOUNT":twoPrice,
              });
            }

          }else{
            if(fnCheckNumberInList(iNum.toString(),plan)){
              countList.add({
                "PLAN":plan,
                "NUMBER":iNum.toString(),
                "COUNT":5,
                "AMOUNT":price,
              });
            }

          }
        }

      }
      else if(gOption == "Any"){
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
                "COUNT":txtCount.text,
                "AMOUNT":twoPrice,
              });
            }

            if(fnCheckNumberInList(iNum.toString(),"BC")){
              countList.add({
                "PLAN":"BC",
                "NUMBER":iNum,
                "COUNT":txtCount.text,
                "AMOUNT":twoPrice,
              });
            }

            if(fnCheckNumberInList(iNum.toString(),"AC")){
              countList.add({
                "PLAN":"AC",
                "NUMBER":iNum,
                "COUNT":txtCount.text,
                "AMOUNT":twoPrice,
              });
            }

          }else{
            if(fnCheckNumberInList(iNum.toString(),plan)){
              countList.add({
                "PLAN":plan,
                "NUMBER":iNum,
                "COUNT":txtCount.text,
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
      if(txtCount.text.isEmpty){
        return;
      }

      if(plan =="ALL"){
        var planName = txtNum.text.length == 2?"AB":"A";
        if(fnCheckNumberInList(txtNum.text,planName)){
          countList.add({
            "PLAN":planName,
            "NUMBER":txtNum.text,
            "COUNT":txtCount.text,
            "AMOUNT":price,
          });
        }
         planName = txtNum.text.length == 2?"BC":"B";
        if(fnCheckNumberInList(txtNum.text,planName)){
          countList.add({
            "PLAN":planName,
            "NUMBER":txtNum.text,
            "COUNT":txtCount.text,
            "AMOUNT":price,
          });
        }
         planName = txtNum.text.length == 2?"AC":"C";
        if(fnCheckNumberInList(txtNum.text,planName)){
          countList.add({
            "PLAN":planName,
            "NUMBER":txtNum.text,
            "COUNT":txtCount.text,
            "AMOUNT":price,
          });
        }
      }else{
        if(fnCheckNumberInList(txtNum.text,plan)){
          countList.add({
            "PLAN":plan,
            "NUMBER":txtNum.text,
            "COUNT":txtCount.text,
            "AMOUNT":price,
          });
        }
      }

    }



    if(mounted){
      setState(() {
        txtNum.clear();
        txtNumTo.clear();
        txtDiff.clear();
        txtCount.clear();
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
    if(txtName.text.isEmpty){
      errorMsg(context, "Enter Name");
      fnName.requestFocus();
      return;
    }

    // Check time
    var det =[];

    for(var e in countList){
      var qty =  g.mfnDbl(e["COUNT"].toString());
      var rate =  g.mfnDbl(e["AMOUNT"].toString());
      var sts =  e["STATUS"].toString();
      var total  =  qty * rate;
      if(sts != "Y"){
        det.add({
          "GAME_TYPE":e["PLAN"],
          "NUMBER":e["NUMBER"],
          "QTY":e["COUNT"],
          "RATE":e["AMOUNT"],
          "TOT_AMT":total
        });
      }

    }

    if(det.isEmpty) {
      errorMsg(context, "Choose Numbers");
      return;
    }

    apiSaveBooking(det);

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
    if(countList.where((element) => element["NUMBER"].toString() == number.toString() && element["PLAN"].toString() == plan.toString()).isEmpty){
      return true;
    }else{
      return false;
    }
  }
  fnCancel(){
    Get.back();
  }
  fnGameTime(){
     
  }

  //=======================================API CALL

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
    futureForm = apiCall.apiSaveBooking(g.wstrSGameDocNo, g.wstrSGameDoctype, g.wstrCompany, g.wstrUserCd, txtName.text, txtName.text, g.wstrDeivceId, fAgentCode, "ADD", det);
    futureForm.then((value) => apiSaveBookingRes(value));
  }
  apiSaveBookingRes(value){
    if(mounted){

      if(g.fnValCheck(value)){

        try{
          var sts = (value[0]["STATUS"])??"";
          var msg = (value[0]["MSG"])??"";
          if(sts == "1"){
            Get.back();
            successMsg(context, "BOOKING SAVED");
          }else{
            errorMsg(context, msg);
          }
        }catch(e){
          dprint(e);
        }

      }else{
        errorMsg(context, "Failed");
      }

      if(value == "1"){
        successMsg(context, "BOOKING SAVED");
      }
    }
  }

  apiGetDetails(){
    futureForm  = apiCall.apiGetUserDetails(g.wstrCompany, fAgentCode, "PRICE");
    futureForm.then((value) => apiGetDetailsRes(value));
  }
  apiGetDetailsRes(value){
    if(mounted){
      if(g.fnValCheck(value)){

        try{
          setState(() {
            for(var e  in value){
              var type = e["TYPE"];
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
          });
        }catch(e){
          dprint(e);
        }

      }
    }
  }



}
