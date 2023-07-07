

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:ltr/controller/global/globalValues.dart';
import 'package:ltr/services/apiController.dart';
import 'package:ltr/views/components/common/common.dart';

class WinningReport extends StatefulWidget {
  final List<dynamic> pFilterData;
  const WinningReport({Key? key, required this.pFilterData}) : super(key: key);
  @override
  _WinningReportState createState() => _WinningReportState();
}

class _WinningReportState extends State<WinningReport> {

  //Global
  var g = Global();
  var apiCall = ApiCall();
  late Future<dynamic> futureForm;

  //Page Variable
  var fCount = 0;
  var fGTotal = 0.0;
  var fTotal = 0.0;
  var fComm = 0.0;

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
                      tcn("Winning Report (${g.wstrSelectedGame})", Colors.white, 18)
                    ],
                  ),
                  gapHC(10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            tcn('Total Count', Colors.white, 12),
                            gapWC(10),
                            tc(fCount.toString(), Colors.white, 14)
                          ],
                        ),
                      ),
                      Expanded(child: Row(
                        children: [
                          tcn('Grand Total', Colors.white, 12),
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
                            tcn('Total', Colors.white, 12),
                            gapWC(10),
                            tc(fTotal.toStringAsFixed(2), Colors.white, 14)
                          ],
                        ),
                      ),
                      Expanded(child: Row(
                        children: [
                          tcn('Commission', Colors.white, 12),
                          gapWC(10),
                          tc(fComm.toStringAsFixed(2), Colors.white, 14)
                        ],
                      ),)
                    ],
                  )
                ],
              ),
            ),
            Expanded(child: SingleChildScrollView(
              child: Column(
                children: wTypeList()
              ),
            ))
          ],
        ),
      ),
    );
  }

  //===========================================WIDGET

    List<Widget> wTypeList(){
        List<Widget>  rtnList  = [];
        for(var e in typeList){
          rtnList.add(
            fnCheckResult(e)?
            Container(
              padding: const EdgeInsets.all(5),
              decoration: boxDecoration(Colors.blueGrey, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  tc(e, Colors.white, 15)
                ],
              ),
            ):gapHC(0),
          );
          rtnList.add( fnCheckResult(e)?
          Column(
            children: wResultList(e),
          ):gapHC(0));
        }
        return rtnList;
    }
    List<Widget> wResultList(mode){
        List<Widget>  rtnList  = [];

        if(reportDate.isNotEmpty){
          if( reportDate.where((element) => element["GAME_TYPE"] == mode).isNotEmpty){
            for(var e in reportDate.where((element) => element["GAME_TYPE"] == mode)){
              var grandTotal = 0.0;
              grandTotal  =  g.mfnDbl(e["TOTAL"].toString())+g.mfnDbl(e["COMM"].toString());
              rtnList.add(Container(
                decoration: boxDecoration(Colors.white, 10),
                margin: EdgeInsets.symmetric(vertical: 5,horizontal: 5),
                padding: EdgeInsets.all(5),
                child: Column(
                  children: [
                      Container(
                        padding: EdgeInsets.all(8),
                        decoration: boxBaseDecoration(g.wstrGameColor.withOpacity(0.1), 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                tcn("Prize  ", Colors.black , 15),
                                tc((e["PLACE"]??"").toString(), Colors.black , 20)
                              ],
                            ),
                            Row(
                              children: [
                                tcn("NUMBER :", Colors.black , 13),
                                tc((e["NUMBER"]??"").toString(), Colors.black , 20)
                              ],
                            ),
                          ],
                        ),
                      ),
                    gapHC(5),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                wRow("COUNT",(e["COUNT"]??"").toString()),
                                wRow("BILL ID",(e["BILL_ID"]??"").toString()),
                                g.wstrUserRole == "ADMIN"?
                                wRow("Stockist",(e["STOCKIST_CODE"]??"").toString()):gapHC(0),
                                g.wstrUserRole == "ADMIN" || g.wstrUserRole == "STOCKIST"?
                                wRow("Dealer",(e["DEALER_CODE"]??"").toString()):gapHC(0),
                                g.wstrUserRole == "ADMIN" || g.wstrUserRole == "STOCKIST" || g.wstrUserRole == "DEALER"?
                                wRow("Agent",(e["AGENT_CODE"]??"").toString()):gapHC(0),
                                wRow("CUSTOMER",(e["CUST_NAME"]??"").toString()),
                              ],
                            )
                          ),
                          Expanded(child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  tcn('Total', Colors.black, 11),
                                  tcn(g.mfnDbl(e["TOTAL"].toString()).toStringAsFixed(2), Colors.black, 13)
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  tcn('Comm', Colors.black, 11),
                                  tcn(g.mfnDbl(e["COMM"].toString()).toStringAsFixed(2), Colors.black, 13)
                                ],
                              ),
                              const Divider(
                                color: Colors.black,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  tc('Grand Total', Colors.black, 11),
                                  tc(grandTotal.toStringAsFixed(2), Colors.black, 13)
                                ],
                              ),
                            ],
                          ))
                        ],
                      ),
                    )
                  ],
                ),
              ));
            }
          }
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

  //===========================================PAGE FN

    fnGetPageData(){

      if(mounted){
        setState(() {
          typeList = [
           "SUPER",
            "BOX",
            "AB",
            "BC",
            "AC",
            "A",
            "B",
            "C"
          ];
        });
      }

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

      futureForm =  ApiCall().apiWinningReport(g.wstrCompany, fromDate,toDate, g.wstrSelectedGame, stockist, dealer, agent, type, number,mode);
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
