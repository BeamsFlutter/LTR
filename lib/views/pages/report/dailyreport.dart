

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:ltr/controller/global/globalValues.dart';
import 'package:ltr/services/apiController.dart';
import 'package:ltr/views/components/common/common.dart';
import 'package:ltr/views/styles/colors.dart';

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
  var fTotal = 0.0;
  var fSale = 0.0;
  var fPrize = 0.0;
  var fComm = 0.0;
  var fShare = 0.0;
  var fWin = 0.0;

  var fFromDate  = "";
  var fToDate  = "";

  var typeList  =  [];
  var reportDate = [];
  var reportHeader = [];

  var blGameYn = false;
  var blDayYn = false;


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
                          decoration: boxBaseDecoration(Colors.white,10),
                          padding: const EdgeInsets.all(5),
                          child: const Icon(Icons.arrow_back,color: Colors.black,size: 20,),
                        ),
                      ),
                      gapWC(5),
                      tcn("Daily Report (${g.wstrSelectedGame})", Colors.white, 18)
                    ],
                  ),
                  const Divider(
                    color: Colors.white,
                  ),
                  Row(
                    children: [
                      const Icon(Icons.calendar_month,color: Colors.white,size: 13,),
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
                  const Divider(
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
                            tc(fTotal.toStringAsFixed(2), Colors.white, 14)
                          ],
                        ),
                      ),
                      Expanded(child: Row(
                        children: [
                          tcn('Sale', Colors.white, 12),
                          gapWC(10),
                          tc(fSale.toStringAsFixed(2), Colors.white, 14)
                        ],
                      ),)

                    ],
                  ),
                  gapHC(5),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            tcn('Sale - Prize', Colors.white, 12),
                            gapWC(10),
                            tc((fSale-fPrize).toStringAsFixed(2), Colors.white, 14)
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            tcn('Share', Colors.white, 12),
                            gapWC(10),
                            tc((fShare).toStringAsFixed(2), Colors.white, 14)
                          ],
                        ),
                      ),

                    ],
                  ),
                  gapHC(5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(child: Row(
                        children: [
                          tcn('Prize + DC', Colors.white, 12),
                          gapWC(10),
                          tc((fPrize).toStringAsFixed(2), Colors.white, 14),
                          gapWC(10),
                          tc("(${(fWin).toStringAsFixed(2)} + ${(fComm).toStringAsFixed(2)})", Colors.white, 14),
                        ],
                      ),)


                    ],
                  ),

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
                  wRowDet(2,'SHARE'),
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
      var share = 0.0;
      var total = 0.0;
      grandTotal  =  g.mfnDbl(e["SALE"].toString())-(g.mfnDbl(e["WIN"].toString())+g.mfnDbl(e["COM"].toString()));
      prize  =  g.mfnDbl(e["WIN"].toString())+g.mfnDbl(e["COM"].toString());
      share  =  g.mfnDbl(e["SHARE"].toString());
      total  =  g.mfnDbl(e["TOTAL"].toString());
      var game = (e["GAME_CODE"]??"").toString();
      var drawDate = (e["DRAW_DATE"]??"").toString();
      var color  =  game == "1PM"?oneColor:game == "3PM"?threeColor:game == "6PM"?sixColor:game == "8PM"?eightColor:Colors.amber;
      rtnList.add(Container(
        decoration: boxOutlineCustom1(Colors.white, 0, Colors.black, 0.2),
        padding: const EdgeInsets.symmetric(vertical: 0),
        child: Row(
          children: [

            blGameYn && blDayYn?
            wColumnCard3Color(2,e["USERCD"]??"",game,drawDate,color):
            blGameYn?
            wColumnCardColor(2,e["USERCD"]??"",game,color):
            blDayYn?
            wColumnCard(2,e["USERCD"]??"",drawDate):
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
            wColumnCardPrize(2,(prize).toString(),"${(e["WIN"]??"0.0")}+${(e["COM"]??"0.0")}"),
            Container(
              width: 1,
              height: 30,
              decoration: boxBaseDecoration(Colors.black.withOpacity(0.2), 0),
            ),
            wColumnCard(2,(share).toString(),"${(e["SHARE_PER"]??"0.0")}%"),
            Container(
              width: 1,
              height: 30,
              decoration: boxBaseDecoration(Colors.black.withOpacity(0.2), 0),
            ),
            wRowCard(2,(total).toStringAsFixed(2)),
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
  Widget wColumnCardPrize(flx,txt1,txt2){
    return  Flexible(
        flex: flx,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  tc(txt1.toString(), Colors.red, 13),
                  tcn(txt2.toString(), Colors.black, 10),
                ],
              )
            ],
          ),
        ));
  }
  Widget wColumnCardColor(flx,txt1,txt2,color){
    return  Flexible(
        flex: flx,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  tc(txt1.toString(), color, 13),
                  tcn(txt2.toString(), color, 10),
                ],
              )
            ],
          ),
        ));
  }
  Widget wColumnCard3Color(flx,txt1,txt2,txt3,color){
    return  Flexible(
        flex: flx,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  tc(txt1.toString(), color, 13),
                  tcn(txt2.toString(), color, 10),
                  tcn(txt3.toString(), color, 10),
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
    var game = (filterData[0]["GAME"]);
    var gameYn = (filterData[0]["blGame"]);
    var dayYn = (filterData[0]["blDay"]);
    var user = (agent??"").toString().isNotEmpty?agent.toString():(dealer??"").toString().isNotEmpty?(dealer??"").toString():(stockist??"").toString().isNotEmpty?stockist.toString():null;

    if(mounted){
      setState(() {
        fFromDate =fromDate;
        fToDate =toDate;
        blGameYn = gameYn;
        blDayYn = dayYn;
      });
    }

    futureForm =  ApiCall().apiDailyReport(g.wstrCompany, fromDate,toDate, game,  user, child,dailyMode);
    futureForm.then((value) => apiWinningReportRes(value));
  }

  apiWinningReportRes(value){
    if(mounted){
      setState(() {
        reportDate = [];
        reportHeader = [];
        fTotal = 0.0;
        fSale = 0.0;
        fPrize = 0.0;
        fComm = 0.0;
        fWin = 0.0;
        if(g.fnValCheck(value)){
          reportDate = value["DET"]??[];
          reportHeader.add(value["HEADER"]??{});

          if(g.fnValCheck(reportHeader)){
            fSale = g.mfnDbl(reportHeader[0]["SALE"].toString());
            fPrize = g.mfnDbl(reportHeader[0]["PRIZE"].toString());
            fComm  = g.mfnDbl(reportHeader[0]["COM"].toString());
            fTotal  = g.mfnDbl(reportHeader[0]["TOTAL"].toString());
            fShare  = g.mfnDbl(reportHeader[0]["SHARE"].toString());
            fWin  = g.mfnDbl(reportHeader[0]["WIN"].toString());

          }

        }else{
          errorMsg(context, "No Result Found!!");
        }
      });
    }
  }
}
