


import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:ltr/controller/global/globalValues.dart';
import 'package:ltr/services/apiController.dart';
import 'package:ltr/views/components/common/common.dart';
import 'package:ltr/views/pages/report/salesReport.dart';
import 'package:ltr/views/pages/report/winningreport.dart';
import 'package:ltr/views/pages/user/usersearch.dart';
import 'package:ltr/views/styles/colors.dart';

class CountReport extends StatefulWidget {
  final String reportName;
  final String reportCode;
  const CountReport({Key? key, required this.reportName, required this.reportCode}) : super(key: key);

  @override
  State<CountReport> createState() => _CountReportState();
}
enum Menu { itemOne, itemTwo, itemThree, itemFour }
class _CountReportState extends State<CountReport> {

  //Global
  var g = Global();
  var apiCall = ApiCall();
  late Future<dynamic> futureForm;

  //Page Variable
  var reportList = [];
  var fFromDate =  DateTime.now();
  var fToDate =  DateTime.now();

  var fStockistCode = "ALL";
  var fDealerCode = "ALL";
  var fAgentCode = "ALL";

  var blFullView = false;
  var blRate = false;

  var gCountNum = 0;
  var fSelectedGame = "";

  var reportDate = [];
  var typeList = [];
  var frGameList = [];
  var fGame = "";

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
                  tcn("${widget.reportName} (${g.wstrSelectedGame})", Colors.white, 18)
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
                      (g.wstrUserRole == "ADMIN")?
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
                  Bounce(
                    onPressed: (){
                      apiGetCountSummaryReport();
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
                  ),
                  gapHC(15),
                  Container(
                    decoration: boxBaseDecoration(Colors.grey.withOpacity(0.3), 3),
                    padding: const EdgeInsets.symmetric(horizontal: 6,vertical: 5),
                    child: Row(
                      children: [
                        wRowDet(2,'GAME'),
                        wRowDet(2,'COUNT'),
                        wRowDet(2,'RATE'),
                        wRowDet(2,'CASH'),
                      ],
                    ),
                  ),
                  // Column(
                  //   children: wCountData(),
                  // ),
                  Column(
                    children: wTypeList(),
                  ),




                ],
              ),
            ))
          ],
        ),
      ),
    );
  }

  //===============================WIDGET

  Widget wRowDet(flx,txt){
    return  Flexible(
        flex: flx,
        child: Row(
          children: [
            tc(txt.toString(), Colors.black, 12)
          ],
        ));
  }
  Widget wRowDetRed(flx,txt){
    return  Flexible(
        flex: flx,
        child: Row(
          children: [
            tc(txt.toString(), Colors.red, 12)
          ],
        ));
  }

  List<Widget> wCountData(){
    List<Widget> rtnList  = [];

    for(var e in reportDate){
      var grandTotal = 0.0;
      grandTotal  =  g.mfnDbl(e["TOTAL"].toString())+g.mfnDbl(e["COMM"].toString());
      rtnList.add(
          Container(
            decoration: boxBaseDecoration(Colors.white.withOpacity(0.3), 3),
            padding: const EdgeInsets.symmetric(horizontal: 6,vertical: 8),
            child: Row(
              children: [
                wRowDet(2,(e["GAME_TYPE"]??"").toString()),
                wRowDet(2,(e["QTY"]??"").toString()),
                wRowDet(2,(e["TOT_AMT"]??"").toString()),
                wRowDet(2,(grandTotal.toString()))
              ]),
          )
      );
    }

    return rtnList;
  }
  List<Widget> wTypeList(){
    List<Widget> rtnList  = [];

    for(var e in typeList){
      var values = fnGetVal(e)??[];
      rtnList.add(
        Container(
          decoration: boxBaseDecoration(Colors.white.withOpacity(0.3), 3),
          padding: const EdgeInsets.symmetric(horizontal: 6,vertical: 8),
          child: Row(
              children: [
                wRowDet(2,e),
                wRowDet(2,(values[0]["COUNT"]).toString()),
                wRowDet(2,(values[0]["RATE"]).toString()),
                wRowDet(2,(values[0]["CASH"]).toString())
              ]),
        ),
      );
    }
    var values = fnGetVal("TOTAL")??[];
    rtnList.add(Divider());
    rtnList.add(
      Container(
        decoration: boxBaseDecoration(Colors.grey.withOpacity(0.1), 3),
        padding: const EdgeInsets.symmetric(horizontal: 6,vertical: 8),
        child: Row(
            children: [
              wRowDetRed(2,"Total"),
              wRowDetRed(2,(values[0]["COUNT"]).toString()),
              wRowDetRed(2,(values[0]["RATE"]).toString()),
              wRowDetRed(2,(values[0]["CASH"]).toString())
            ]),
      ),
    );

    return rtnList;
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

    setState(() {
      fGame = g.wstrSelectedGame;
      typeList = [
        "SUPER",
        "BOX",
        "AB/BC/AC",
        "A/B/C",
      ];
    });

    apiGetGameList();

  }

  fnGetVal(mode){

    if(mode == "TOTAL"){
      var count = 0.0 ;
      var rate = 0.0 ;
      var cash = 0.0 ;
      for(var e in reportDate){
        count = count+g.mfnDbl(e["QTY"].toString());
        rate = 0.0;
        cash = cash+g.mfnDbl(e["TOT_AMT"].toString());
      }

      return [
        {
          "COUNT":count==0?"-":count.toStringAsFixed(0),
          "RATE":rate==0?"-":rate.toStringAsFixed(2),
          "CASH":cash==0?"-":cash.toStringAsFixed(2),
        }
      ];
    }else{
      var key1 = "";
      var key2 = "";
      var key3 = "";

      if(mode == "AB/BC/AC"){
        key1 = "AB";
        key2 = "BC";
        key3 = "AC";
      }else if(mode == "A/B/C"){
        key1 = "A";
        key2 = "B";
        key3 = "C";
      }else{
        key1 = mode;
      }
      var count = 0.0 ;
      var rate = 0.0 ;
      var cash = 0.0 ;
      for(var e in reportDate.where((element) => element["GAME_TYPE"] == key1 || element["GAME_TYPE"] == key2 || element["GAME_TYPE"] == key3 )){
        count = count+g.mfnDbl(e["QTY"].toString());
        rate = g.mfnDbl(e["RATE"].toString());
        cash = cash+g.mfnDbl(e["TOT_AMT"].toString());
      }

      return [
        {
          "COUNT":count==0?"-":count.toStringAsFixed(0),
          "RATE":rate==0?"-":rate.toStringAsFixed(2),
          "CASH":cash==0?"-":cash.toStringAsFixed(2),
        }
      ];
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
    }
  }

  Future<void> _selectFromDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: fFromDate,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
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
      lastDate: DateTime.now(),
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
    var number = txtNum.text.isEmpty ?null:txtNum.text;

    var filterData = [];
    filterData.add({
      "STOCKIST":stockist,
      "DEALER":dealer,
      "AGENT":agent,
      "TYPE":type,
      "NUMBER":number,
      "DATE_FROM":setDate(2, fFromDate),
      "DATE_TO":setDate(2, fToDate),
      "MODE":blFullView? "FULL":"SUM",
      "CHILD":blRate? 1:0,
    });


    if(widget.reportCode == "2"){
      Navigator.push(context, MaterialPageRoute(builder: (context) =>  WinningReport(pFilterData: filterData,)));
    }else
    if(widget.reportCode == "1"){
      Navigator.push(context, MaterialPageRoute(builder: (context) =>  SalesReport(pFilterData: filterData,)));
    }
  }

//===============================API CALL


  apiGetCountSummaryReport(){

    var stockist = fStockistCode.isEmpty || fStockistCode == "ALL"?null:fStockistCode;
    var dealer = fDealerCode.isEmpty || fDealerCode == "ALL"?null:fDealerCode;
    var agent = fAgentCode.isEmpty || fAgentCode == "ALL"?null:fAgentCode;
    var type = fSelectedGame.isEmpty || fSelectedGame == "ALL"?null:fSelectedGame;
    var number = txtNum.text.isEmpty ?null:txtNum.text;
    var child = blRate? 1:0;


    futureForm =  ApiCall().apiCountSummaryReport(g.wstrCompany, setDate(2, fFromDate),setDate(2, fToDate), fGame, "",stockist, dealer, agent, type, number,child);
    futureForm.then((value) => apiGetCountSummaryRes(value));
  }
  apiGetCountSummaryRes(value){
    if(mounted){
      setState(() {
        reportDate = [];
        if(g.fnValCheck(value)){
          reportDate = value??[];
        }else{
          errorMsg(context, "No Result Found!!");
        }
      });
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
}

