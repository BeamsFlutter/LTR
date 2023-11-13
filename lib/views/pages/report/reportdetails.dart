

import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:ltr/controller/global/globalValues.dart';
import 'package:ltr/services/apiController.dart';
import 'package:ltr/views/components/common/common.dart';
import 'package:ltr/views/pages/report/dailyreport.dart';
import 'package:ltr/views/pages/report/salesReport.dart';
import 'package:ltr/views/pages/report/winningreport.dart';
import 'package:ltr/views/pages/user/usersearch.dart';
import 'package:ltr/views/styles/colors.dart';

class ReportDetails extends StatefulWidget {
  final String reportName;
  final String reportCode;
  const ReportDetails({Key? key, required this.reportName, required this.reportCode}) : super(key: key);

  @override
  State<ReportDetails> createState() => _ReportsState();
}
enum Menu { itemOne, itemTwo, itemThree, itemFour }
class _ReportsState extends State<ReportDetails> {

  //Global
  var g = Global();
  var apiCall  = ApiCall();
  late Future<dynamic> futureForm;

  //Page Variable
  var reportList = [];
  var fFromDate =  DateTime.now();
  var fToDate =  DateTime.now();

  var fAdminCode = "ALL";
  var fStockistCode = "ALL";
  var fDealerCode = "ALL";
  var fAgentCode = "ALL";
  var fGame = "";
  var frGameList = [];

  var blFullView = false;
  var blRate = false;
  var blDay = false;
  var blGame = false;

  var gCountNum = 0;
  var fSelectedGame = "";
  bool blAllGame  = false;

  //Controller
  var txtNum = TextEditingController();
  var fnNum = FocusNode();

  @override
  void initState() {
    // TODO: implement initState
    fnGetPageData();
    super.initState();
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
                  tcn("${widget.reportName} (${fGame.toString()})", Colors.white, 18)
                ],
              ),
            ),
            gapHC(15),

            Expanded(child: Container(
              padding: const EdgeInsets.all(10),
              child: Column(
                children:[
                  Row(
                    children: [
                      Expanded(
                        child: PopupMenuButton<Menu>(
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
                          child:   Container(
                            margin:const  EdgeInsets.symmetric(horizontal: 2),
                            padding: const EdgeInsets.all(10),
                            decoration: boxOutlineCustom1(Colors.white, 5, Colors.black, 1.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    tcn('Select Game ', Colors.black, 10),
                                    tc(fGame.toString(), Colors.black, 13),
                                  ],
                                ),
                                Icon(Icons.search,color: Colors.grey,size: 18,)
                              ],
                            ),
                          ),
                        ),
                      )

                    ],
                  ),
                  gapHC(10),
                  GestureDetector(
                    onTap: (){
                      _selectFromDate(context);
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
                              const Icon(Icons.calendar_month,color: grey,size: 18,),
                              gapWC(5),
                              tcn('From Date', grey, 15),
                            ],
                          ),
                          tcn(setDate(6, fFromDate).toString(), Colors.black, 15)
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      _selectToDate(context);
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
                              const Icon(Icons.calendar_month,color: grey,size: 18,),
                              gapWC(5),
                              tcn('To Date', grey, 15),
                            ],
                          ),
                          tcn(setDate(6, fToDate).toString(), Colors.black, 15)
                        ],
                      ),
                    ),
                  ),
                  gapHC(10),
                  Row(
                    children: [
                      (g.wstrCompany == "00")?
                      gapHC(0):(g.wstrUserRole == "ADMIN")?
                      Expanded(child: Bounce(
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) =>   UserSearch(pRoleCode: "Stockist", pUserCode: g.wstrUserCd.toString(), pFnCallBack: fnSearchCallBack,pAllYn: "Y")));
                        },
                        duration: const Duration(milliseconds: 110),
                        child: Container(
                          margin:const  EdgeInsets.symmetric(horizontal: 2),
                          padding: const EdgeInsets.all(10),
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
                      ( g.wstrUserRole.toString().toUpperCase() == "STOCKIST")?
                      Expanded(child: Bounce(
                        onPressed: (){

                          if(fStockistCode.isEmpty){
                            errorMsg(context, "Choose Stockist");
                            return;
                          }

                          Navigator.push(context, MaterialPageRoute(builder: (context) =>   UserSearch(pRoleCode: "Dealer", pUserCode: fStockistCode, pFnCallBack: fnSearchCallBack,pAllYn: "Y")));

                        },
                        duration: const Duration(milliseconds: 110),
                        child: Container(
                          margin:const  EdgeInsets.symmetric(horizontal: 2),
                          padding: const EdgeInsets.all(10),
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
                      (g.wstrUserRole.toString().toUpperCase() == "DEALER")?
                      Expanded(child: Bounce(
                        onPressed: (){

                          if(fDealerCode.isEmpty){
                            errorMsg(context, "Choose Dealer");
                            return;
                          }

                          Navigator.push(context, MaterialPageRoute(builder: (context) =>   UserSearch(pRoleCode: "Agent", pUserCode: fDealerCode, pFnCallBack: fnSearchCallBack,pAllYn: "Y",)));

                        },
                        duration: const Duration(milliseconds: 110),
                        child: Container(
                          margin:const  EdgeInsets.symmetric(horizontal: 2),
                          padding: const EdgeInsets.all(10),
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
                      )):gapHC(0),
                    ],
                  ),
                  gapHC(10),
                  widget.reportCode == "4"?
                  GestureDetector(
                    onTap: (){
                      if(mounted){
                        setState(() {
                          blAllGame = !blAllGame;
                        });
                      }
                    },
                    child: Container(
                      decoration: boxBaseDecoration(greyLight, 30),
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
                              decoration: blAllGame?boxDecoration( bgColorDark, 30):boxBaseDecoration( Colors.white, 30),
                              child: const Icon(Icons.done,color: Colors.white,size: 13,),
                            ),
                          ),
                          gapWC(10),
                          tcn('All Game',blAllGame? Colors.black: Colors.black, 15)
                        ],
                      ),
                    ),
                  ):gapHC(0),
                  gapHC(10),
                  widget.reportCode != "4"?
                  Row(
                    children: [
                      tcn('Full View', Colors.black, 15),
                      Transform.scale(
                          scale: 1.3,
                          child: Switch(
                            onChanged: (val){
                              if(mounted){
                                setState(() {
                                  blFullView = !blFullView;
                                });
                              }
                            },
                            value: blFullView,
                            activeColor: g.wstrGameColor,
                            activeTrackColor: g.wstrGameColor.withOpacity(0.5),
                            inactiveThumbColor: Colors.grey.withOpacity(0.9),
                            inactiveTrackColor:Colors.grey.withOpacity(0.5),
                          )
                      ),
                    ],
                  ):gapHC(0),
                  gapHC(3),
                  blFullView?
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            wNumberCard(1),
                            gapWC(5),
                            wNumberCard(2),
                            gapWC(5),
                            wNumberCard(3),
                            gapWC(5),
                            wNumberCard(0),
                          ],
                        ),
                        gapHC(10),
                        Row(
                          children: [
                            gCountNum == 3?
                            Expanded(
                              child: Row(
                                children: [
                                  // wButton("BOTH",Colors.red),
                                  wButton("ALL",Colors.pink),
                                  gapWC(5),
                                  wButton("BOX",Colors.pink),
                                  gapWC(5),
                                  wButton("SUPER",bgColorDark),
                                ],
                              ),
                            ):
                            gCountNum == 2?
                            Expanded(
                              child: Row(
                                children: [
                                  wButton("ALL",bgColorDark),
                                  gapWC(5),
                                  wButton("AB",Colors.green),
                                  gapWC(5),
                                  wButton("BC",Colors.green),
                                  gapWC(5),
                                  wButton("AC",Colors.green),
                                ],
                              ),
                            ):
                            gCountNum == 1?
                            Expanded(
                              child: Row(
                                children: [
                                  wButton("ALL",bgColorDark),
                                  gapWC(5),
                                  wButton("A",Colors.orange),
                                  gapWC(5),
                                  wButton("B",Colors.orange),
                                  gapWC(5),
                                  wButton("C",Colors.orange),
                                ],
                              ),
                            ):gapHC(0),
                          ],
                        ),
                      ],
                    ),
                  ):gapHC(0),
                  blFullView?
                  gapHC(10):gapHC(0),
                  blFullView?
                  Container(
                    height: 40,
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    decoration: boxBaseDecoration(greyLight, 5),
                    child: TextFormField(
                      controller: txtNum,
                      focusNode: fnNum,
                      maxLength: 3,
                      inputFormatters: mfnInputFormatters(),
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        hintText: 'Num',
                        counterText: "",
                        border: InputBorder.none,
                      ),
                      onChanged: (val){

                      },
                    ),
                  ):gapHC(0),

                  gapHC(3),
                  g.wstrUserRole != "AGENT"?
                  Row(
                    children: [
                      tcn('${g.wstrUserRole == "ADMIN"?"Stockist":g.wstrUserRole == "STOCKIST"?"Dealer":g.wstrUserRole == "DEALER"?"Agent":""} Rate', Colors.black, 15),
                      Transform.scale(
                          scale: 1.3,
                          child: Switch(
                            onChanged: (val){
                              if(mounted){
                                setState(() {
                                  blRate = !blRate;
                                });
                              }
                            },
                            value: blRate,
                            activeColor: g.wstrGameColor,
                            activeTrackColor: g.wstrGameColor.withOpacity(0.5),
                            inactiveThumbColor: Colors.grey.withOpacity(0.9),
                            inactiveTrackColor:Colors.grey.withOpacity(0.5),
                          )
                      ),
                    ],
                  ):
                  gapHC(5),
                  widget.reportCode == "4"?
                  Column(
                    children: [
                      Row(
                        children: [
                          tcn('Day Detail', Colors.black, 15),
                          Transform.scale(
                              scale: 1.3,
                              child: Switch(
                                onChanged: (val){
                                  if(mounted){
                                    setState(() {
                                      blDay = !blDay;
                                    });
                                  }
                                },
                                value: blDay,
                                activeColor: g.wstrGameColor,
                                activeTrackColor: g.wstrGameColor.withOpacity(0.5),
                                inactiveThumbColor: Colors.grey.withOpacity(0.9),
                                inactiveTrackColor:Colors.grey.withOpacity(0.5),
                              )
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          tcn('Game Detail', Colors.black, 15),
                          Transform.scale(
                              scale: 1.3,
                              child: Switch(
                                onChanged: (val){
                                  if(mounted){
                                    setState(() {
                                      blGame = !blGame;
                                    });
                                  }
                                },
                                value: blGame,
                                activeColor: g.wstrGameColor,
                                activeTrackColor: g.wstrGameColor.withOpacity(0.5),
                                inactiveThumbColor: Colors.grey.withOpacity(0.9),
                                inactiveTrackColor:Colors.grey.withOpacity(0.5),
                              )
                          ),
                        ],
                      )
                    ],
                  ):gapHC(0),
                  gapHC(5),
                  Bounce(
                    onPressed: (){
                      fnShowReport();
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
                          tcn('Show Report', Colors.white, 16)
                        ],
                      ),
                    ),
                  )


                ],
              ),
            ))
          ],
        ),
      ),
    );
  }

  //===============================WIDGET

  Widget wNumberCard(num){
    return  Bounce(
      onPressed: (){
        if(mounted){
          setState(() {
            gCountNum = gCountNum == num?0:num;
            txtNum.clear();
          });
        }
      },
      duration: const Duration(milliseconds: 110),
      child: Container(
        height: 25,
        width: 25,
        alignment: Alignment.center,
        decoration: gCountNum == num?boxBaseDecoration(g.wstrGameBColor, 5):boxOutlineCustom1(Colors.white, 5, g.wstrGameBColor, 1.0),
        child:num == 0?Icon(Icons.star,color:  gCountNum == num?g.wstrGameOTColor:g.wstrGameBColor,size: 15,): tc( num.toString(), gCountNum == num?g.wstrGameOTColor:g.wstrGameBColor, 15),
      ),
    );
  }

  Widget wButton(text,color){
    return Flexible(
      child: Bounce(
        onPressed: (){
          //fnButtonPres(text);
          //fnGenerateNumber(text);
          if(mounted){
            setState(() {
              if(text ==  fSelectedGame){
                fSelectedGame ="";
              }else{
                fSelectedGame =text;
              }

            });
          }
        },
        duration: const Duration(milliseconds: 110),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 5),
          decoration: fSelectedGame == text?boxBaseDecoration(g.wstrGameBColor, 5):boxOutlineCustom1(Colors.white, 5, g.wstrGameBColor, 1.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  text == "ALL"?
                  Icon(Icons.star_border,color:fSelectedGame == text? Colors.white :g.wstrGameTColor,size: 15,):
                  tc(text.toString(),fSelectedGame == text? Colors.white :g.wstrGameTColor, 14)
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
            fGame = (e["CODE"]??"").toString();
          });
        },
        child: Container(
          decoration: boxBaseDecoration(color, 5),
          padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 5),
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

  //===============================PAGE FN

  fnGetPageData(){
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
    if(mounted){
      setState(() {
        fGame =  g.wstrSelectedGame;
      });
    }
    apiGetGameList();
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

        }else if(rolecode == "Admin"){
          fAdminCode = usercd;
          fStockistCode = "";
          fDealerCode = "";
          fAgentCode = "";

        }
      });
    }
  }

  Future<void> _selectFromDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: fFromDate,
        firstDate: DateTime(2020),
        lastDate:  DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: g.wstrGameColor,
            ),
          ),
          child: child!,
        );
      },
    );
    if (pickedDate != null && pickedDate != fFromDate) {
      setState(() {
        fFromDate = pickedDate;
      });

    }
  }

  Future<void> _selectToDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: fToDate,
        firstDate: DateTime(2020),
        lastDate:  DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: g.wstrGameColor,
            ),
          ),
          child: child!,
        );
      },

    );
    if (pickedDate != null && pickedDate != fToDate) {
      setState(() {
        fToDate = pickedDate;
      });

    }
  }

  fnShowReport(){


    var stockist = fStockistCode.isEmpty || fStockistCode == "ALL"?null:fStockistCode;
    var dealer = fDealerCode.isEmpty || fDealerCode == "ALL"?null:fDealerCode;
    var agent = fAgentCode.isEmpty || fAgentCode == "ALL"?null:fAgentCode;
    var type = fSelectedGame.isEmpty || fSelectedGame == "ALL"?null:fSelectedGame;


    var typeList  = [];

    if(gCountNum > 0){
      if(fSelectedGame.isEmpty || fSelectedGame == "ALL"){
        if(gCountNum == 3){
          typeList.add({"COL_VAL":"BOX"});
          typeList.add({"COL_VAL":"SUPER"});
        }else  if(gCountNum == 2){
          typeList.add({"COL_VAL":"AB"});
          typeList.add({"COL_VAL":"BC"});
          typeList.add({"COL_VAL":"AC"});
        }else  if(gCountNum == 1){
          typeList.add({"COL_VAL":"A"});
          typeList.add({"COL_VAL":"B"});
          typeList.add({"COL_VAL":"C"});
        }
      }else{
        typeList.add({"COL_VAL":fSelectedGame});
      }
    }


    var number = txtNum.text.isEmpty ?null:txtNum.text;

    var filterData = [];
    filterData.add({
      "STOCKIST":stockist,
      "DEALER":dealer,
      "AGENT":agent,
      "TYPE":blFullView?type:null,
      "TYPE_LIST":blFullView?typeList:[],
      "NUMBER":blFullView?number:null,
      "DATE_FROM":setDate(2, fFromDate),
      "DATE_TO":setDate(2, fToDate),
      "MODE":blFullView? "FULL":"SUM",
      "CHILD":blRate? 1:0,
      "GAME":blAllGame? null: fGame,
      "DAILY_MODE":blDay && blGame? "GAMEDATE":blDay?"DATE":blGame?"GAME":"USER",
      "blGame":blGame,
      "blDay":blDay
    });


    if(widget.reportCode == "2"){
      Navigator.push(context, MaterialPageRoute(builder: (context) =>  WinningReport(pFilterData: filterData,)));
    }else
    if(widget.reportCode == "1"){
      Navigator.push(context, MaterialPageRoute(builder: (context) =>  SalesReport(pFilterData: filterData,)));
    }
    else
    if(widget.reportCode == "4"){
      Navigator.push(context, MaterialPageRoute(builder: (context) =>  DailyReport(pFilterData: filterData,)));
    }
  }

//===============================API CALL


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


}
