

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:ltr/controller/global/globalValues.dart';
import 'package:ltr/services/apiController.dart';
import 'package:ltr/views/components/common/common.dart';

class DailyReport extends StatefulWidget {
  final List<dynamic> pFilterData;
  const DailyReport({Key? key, required this.pFilterData}) : super(key: key);
  @override
  _DailyReportState createState() => _DailyReportState();
}

class _DailyReportState extends State<DailyReport> {

  //Global
  var g = Global();
  var apiCall = ApiCall();
  late Future<dynamic> futureForm;

  //Page Variable
  var fCount = 0;
  var fGTotal = 0.0;
  var fTotal = 0.0;
  var fComm = 0.0;

  var fFromDate  = "";
  var fToDate  = "";

  var typeList  =  [];
  var reportDate = [];


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

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
              child: Column(
                children: [
                  Row(
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
                      tcn("Daily Report (${g.wstrSelectedGame})", Colors.white, 18)
                    ],
                  ),
                  Divider(
                    color: Colors.white,
                  ),
                  Row(
                    children: [
                      Icon(Icons.calendar_month,color: Colors.white,size: 13,),
                      gapWC(5),
                      tcn('Date', Colors.white, 13),
                      gapWC(25),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            tcn(fFromDate.toString()  , Colors.white, 13),
                            gapWC(10),
                            tcn("to"  , Colors.white, 13),
                            gapWC(10),
                            tcn(fToDate.toString()  , Colors.white, 13),
                          ],
                        ),
                      )
                    ],
                  ),
                  Divider(
                    color: Colors.white,
                  ),
                  gapHC(5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            tcn('Total', Colors.white, 12),
                            gapWC(10),
                            tc(fCount.toString(), Colors.white, 14)
                          ],
                        ),
                      ),
                      Expanded(child: Row(
                        children: [
                          tcn('Prize + DC', Colors.white, 12),
                          gapWC(10),
                          tc(fGTotal.toStringAsFixed(2), Colors.white, 14)
                        ],
                      ),)
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            tcn('Sale - Prize', Colors.white, 12),
                            gapWC(10),
                            tc(fTotal.toStringAsFixed(2), Colors.white, 14)
                          ],
                        ),
                      ),
                      Expanded(child: Row(
                        children: [
                          tcn('Sale', Colors.white, 12),
                          gapWC(10),
                          tc(fComm.toStringAsFixed(2), Colors.white, 14)
                        ],
                      ),)
                    ],
                  )
                ],
              ),
            ),
            Container(
              decoration: boxBaseDecoration(Colors.blueGrey, 0),
              padding: const EdgeInsets.symmetric(horizontal: 6,vertical: 6),
              child: Row(
                children: [
                  wRowDet(2,'NAME'),
                  wRowDet(2,'SALE'),
                  wRowDet(2,'PRIZE+COMM'),
                  wRowDet(2,'TOTAL'),
                ],
              ),
            ),
            Expanded(child: SingleChildScrollView(
              child: Column(
                  children: wResultList()
              ),
            ))
          ],
        ),
      ),
    );
  }

  //===========================================WIDGET


  List<Widget> wResultList(){
    List<Widget>  rtnList  = [];
    for(var e in reportDate){
      var grandTotal = 0.0;
      var prize = 0.0;
      grandTotal  =  g.mfnDbl(e["SALE"].toString())-(g.mfnDbl(e["WIN"].toString())+g.mfnDbl(e["COMM"].toString()));
      prize  =  g.mfnDbl(e["WIN"].toString())+g.mfnDbl(e["COMM"].toString());
      rtnList.add(Container(
        decoration: boxOutlineCustom1(Colors.white, 0, Colors.black, 0.2),
        padding: const EdgeInsets.symmetric(vertical: 0),
        child: Row(
          children: [
            wRowCard(2,(e["USERCD"]??"").toString()),
            Container(
              width: 1,
              height: 30,
              decoration: boxBaseDecoration(Colors.black.withOpacity(0.2), 0),
            ),
            wRowCard(2,(e["SALE"]??"").toString()),
            Container(
              width: 1,
              height: 30,
              decoration: boxBaseDecoration(Colors.black.withOpacity(0.2), 0),
            ),
            wColumnCard(2,(prize).toString(),"${(e["WIN"]??"0.0")}+${(e["COMM"]??"0.0")}"),
            Container(
              width: 1,
              height: 30,
              decoration: boxBaseDecoration(Colors.black.withOpacity(0.2), 0),
            ),
            wRowCard(2,(grandTotal).toString()),
          ],
        ),
      ));
    }

    return rtnList;
  }

  Widget wRow(head,sub){
    return Row(
      children: [
        Flexible(
          flex: 3,
          child: Row(
            children: [
              tcn(head, Colors.black, 10),
            ],
          ),),
        Flexible(
          flex: 5,
          child: Row(
            children: [
              tc(sub, Colors.black, 10),
            ],
          ),)
      ],
    );
  }
  Widget wRowDet(flx,txt){
    return  Flexible(
        flex: flx,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            tcn(txt.toString(), Colors.white, 12)
          ],
        ));
  }
  Widget wRowCard(flx,txt){
    return  Flexible(
        flex: flx,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              tc(txt.toString(), Colors.black, 13)
            ],
          ),
        ));
  }
  Widget wColumnCard(flx,txt1,txt2){
    return  Flexible(
        flex: flx,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  tc(txt1.toString(), Colors.black, 13),
                  tcn(txt2.toString(), Colors.black, 10),
                ],
              )
            ],
          ),
        ));
  }

  //===========================================PAGE FN

  fnGetPageData(){
    Future.delayed(const Duration(seconds: 1),(){
      apiWinningReport();
    });
  }

  fnCheckResult(mode){
    var rtn = false;
    if(reportDate.isNotEmpty){
      if( reportDate.where((element) => element["GAME_TYPE"] == mode).isNotEmpty){
        rtn =  true;
      }
    }
    return rtn;
  }

  //===========================================API CALL

  apiWinningReport(){
    var filterData = [];
    filterData = widget.pFilterData;

    var stockist = (filterData[0]["STOCKIST"]);
    var dealer = (filterData[0]["DEALER"]);
    var agent = (filterData[0]["AGENT"]);
    var type = (filterData[0]["TYPE"]);
    var number = (filterData[0]["NUMBER"]);
    var fromDate = (filterData[0]["DATE_FROM"]);
    var toDate = (filterData[0]["DATE_TO"]);
    var mode = (filterData[0]["MODE"]);
    var child = (filterData[0]["CHILD"]);
    var dailyMode = (filterData[0]["DAILY_MODE"]);
    var user = (agent??"").toString().isNotEmpty?agent.toString():(dealer??"").toString().isNotEmpty?(dealer??"").toString():(stockist??"").toString().isNotEmpty?stockist.toString():null;


    if(mounted){
      setState(() {
        fFromDate =fromDate;
        fToDate =toDate;
      });
    }


    futureForm =  ApiCall().apiDailyReport(g.wstrCompany, fromDate,toDate, g.wstrSelectedGame,  user, child,dailyMode);
    futureForm.then((value) => apiWinningReportRes(value));
  }

  apiWinningReportRes(value){
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
}
