

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

  var fDetCount = 0;
  var fDetGTotal = 0.0;
  var fDetTotal = 0.0;
  var fDetComm = 0.0;
  var fGame = "";

  var typeList  =  [];
  var reportData = [];
  var reportDet = [];

  var blFullView = false;


  //Selected Data
  var selectedData = [];


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
                      tcn("Winning Report (${fGame.toString()})", Colors.white, 18)
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
            Expanded(
              child: ListView.builder(

                  padding: const EdgeInsets.all(0),
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemCount: typeList.length,
                  itemBuilder: (context, index) {
                    var e = typeList.reversed.toList()[index];
                    return
                    Column(
                      children: [
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
                        fnCheckResult(e)?
                        Column(
                          children: wResultList(e),
                        ):gapHC(0)
                      ],
                    );
                  }

              ),
            )
            // Expanded(child: SingleChildScrollView(
            //   child: Column(
            //     children: wTypeList()
            //   ),
            // ))
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

        if(reportData.isNotEmpty){
          if( reportData.where((element) => element["GAME_TYPE"] == mode).isNotEmpty){
            var dataFull = reportData.where((element) => element["GAME_TYPE"] == mode).toList();
            dataFull.sort((a, b) => (g.mfnDbl(((a["PLACE"]??"") == "11" ||(a["PLACE"]??"") == "31" || (a["PLACE"]??"") == "21") ?"1":
            ((a["PLACE"]??"") == "32" || (a["PLACE"]??"") == "22") ?"2":(a["PLACE"]??"").toString())).compareTo(g.mfnDbl(((b["PLACE"]??"") == "11" ||(b["PLACE"]??"") == "31" || (b["PLACE"]??"") == "21") ?"1":
            ((b["PLACE"]??"") == "32" || (b["PLACE"]??"") == "22") ?"2":(b["PLACE"]??"").toString())));
            for(var e in dataFull){
              var grandTotal = 0.0;
              grandTotal  =  g.mfnDbl(e["TOTAL"].toString())+g.mfnDbl(e["COMM"].toString());


              var place = ((e["PLACE"]??"") == "11" ||(e["PLACE"]??"") == "31" || (e["PLACE"]??"") == "21") ?"1":
              ((e["PLACE"]??"") == "32" || (e["PLACE"]??"") == "22") ?"2":(e["PLACE"]??"").toString();

              place = g.mfnDbl(place) >= 6?"6":place;

              Color color = g.mfnDbl(place) == 1?Colors.green:g.mfnDbl(place) == 2?Colors.blue:g.mfnDbl(place) == 3?Colors.deepPurple:
              g.mfnDbl(place) == 4?Colors.pink:g.mfnDbl(place) == 5?Colors.amber:g.mfnDbl(place) >= 6?Colors.grey:Colors.grey;

              rtnList.add(GestureDetector(
                onTap: (){
                  if(mounted){
                    setState(() {
                      selectedData = [];
                      selectedData.add(e);
                    });
                    if(!blFullView){
                      apiWinningReportDet((e["NUMBER"]??"").toString(),e["PLACE"]);
                    }

                  }
                  
                },
                child: Container(
                  decoration: boxDecoration(Colors.white, 10),
                  margin: const EdgeInsets.symmetric(vertical: 5,horizontal: 5),
                  padding: const EdgeInsets.all(5),
                  child: Column(
                    children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: boxBaseDecoration(color.withOpacity(0.1), 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  tcn("Prize  ", Colors.black , 15),
                                  tc(place, Colors.black , 20)
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
                                  blFullView?
                                  Column(
                                    children: [
                                      wRow("BILL ID",(e["BILL_ID"]??"").toString()),
                                      g.wstrUserRole == "ADMIN"?
                                      wRow("Stockist",(e["STOCKIST_CODE"]??"").toString()):gapHC(0),
                                      g.wstrUserRole == "ADMIN" || g.wstrUserRole == "STOCKIST"?
                                      wRow("Dealer",(e["DEALER_CODE"]??"").toString()):gapHC(0),
                                      g.wstrUserRole == "ADMIN" || g.wstrUserRole == "STOCKIST" || g.wstrUserRole == "DEALER"?
                                      wRow("Agent",(e["AGENT_CODE"]??"").toString()):gapHC(0),
                                      wRow("CUSTOMER",(e["CUST_NAME"]??"").toString()),
                                    ],
                                  ):gapHC(0),
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

  Widget wRowDetWhite(flx,txt){
    return  Flexible(
        flex: flx,
        child: Row(
          children: [
            tc(txt.toString(), Colors.white, 12)
          ],
        ));
  }

  Widget wRowDet(flx,txt){
    return  Flexible(
        flex: flx,
        child: Row(
          children: [
            tc(txt.toString(), Colors.black, 12)
          ],
        ));
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
      if(reportData.isNotEmpty){
        if( reportData.where((element) => element["GAME_TYPE"] == mode).isNotEmpty){
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
      var typeList = (filterData[0]["TYPE_LIST"]);
      var game = (filterData[0]["GAME"]);

      if(mounted){
        setState(() {
          fGame = game;
          blFullView = mode == "FULL"?true:false;
          mode = mode == "FULL"?"FULL":"SUM";
        });
      }

      futureForm =  ApiCall().apiWinningReport(g.wstrCompany, fromDate,toDate, game , stockist, dealer, agent, type, number,mode,child,typeList,null);
      futureForm.then((value) => apiWinningReportRes(value));
    }
    apiWinningReportRes(value){
      if(mounted){
        setState(() {
          reportData = [];
          fCount = 0;
          fGTotal = 0.0;
          fTotal = 0.0;
          fComm = 0.0;
          if(g.fnValCheck(value)){
            reportData = value??[];

            for(var e in reportData){
              var grandTotal = 0.0;
              var total = 0.0;
              var comm = 0.0;
              var count = 0;
              grandTotal  =  g.mfnDbl(e["TOTAL"].toString())+g.mfnDbl(e["COMM"].toString());
              count = g.mfnInt(e["COUNT"].toString());
              total = g.mfnDbl(e["TOTAL"].toString());
              comm = g.mfnDbl(e["COMM"].toString());
              fCount = fCount+count;
              fGTotal =  fGTotal +grandTotal;
              fTotal =  fTotal +total;
              fComm =  fComm +comm;
            }


          }else{
            errorMsg(context, "No Result Found!!");
          }
        });
      }
    }

    apiWinningReportDet(number,rank){
      var filterData = [];
      filterData = widget.pFilterData;

      var stockist = (filterData[0]["STOCKIST"]);
      var dealer = (filterData[0]["DEALER"]);
      var agent = (filterData[0]["AGENT"]);
      var type = (filterData[0]["TYPE"]);
      var fromDate = (filterData[0]["DATE_FROM"]);
      var toDate = (filterData[0]["DATE_TO"]);
      var mode = "DET";
      var child = (filterData[0]["CHILD"]);
      var typeList = (filterData[0]["TYPE_LIST"]);
      var game = (filterData[0]["GAME"]);


      futureForm =  ApiCall().apiWinningReport(g.wstrCompany, fromDate,toDate, game , stockist, dealer, agent, type, number,mode,child,typeList,rank);
      futureForm.then((value) => apiWinningReportDetRes(value));
    }

    apiWinningReportDetRes(value){
      if(mounted){
        setState(() {
          reportDet = [];
          if(g.fnValCheck(value)){
            reportDet = value??[];
          }
        });
        if(g.fnValCheck(reportDet)){

          var detCount = 0.0;
          var detAmt = 0.0;
          var detComm = 0.0;
          var detTotal = 0.0;

          for(var k in reportDet){
            var com =  g.wstrUserRole == "ADMIN"?(k["ADMIN_COM_RATE"]??""):
            g.wstrUserRole == "STOCKIST"?(k["STOCKIST_COM_RATE"]??""):
            g.wstrUserRole == "DEALER"?(k["DEALER_COM_RATE"]??""):(k["AGENT_COM"]??"");

            var amt =  g.wstrUserRole == "ADMIN"?(k["ADMIN_WIN"]??""):
            g.wstrUserRole == "STOCKIST"?(k["STOCKIST_WIN"]??""):
            g.wstrUserRole == "DEALER"?(k["DEALER_WIN"]??""):(k["AGENT_WIN"]??"");

            detCount =  detCount + g.mfnDbl(k["QTY"].toString());
            detComm =  detComm + g.mfnDbl(com.toString());
            detAmt =  detAmt + g.mfnDbl(amt.toString());

          }
          detTotal = detAmt +detComm;

          var e = selectedData[0];
          var place = ((e["PLACE"]??"") == "11" ||(e["PLACE"]??"") == "31" || (e["PLACE"]??"") == "21") ?"1":
          ((e["PLACE"]??"") == "32" || (e["PLACE"]??"") == "22") ?"2":(e["PLACE"]??"").toString();

          var userTitle =  g.wstrUserRole == "ADMIN"?"STOCKIST":g.wstrUserRole == "STOCKIST"?"DEALER":"AGENT";

          bottomPopUpL(context,
              Container(
                decoration: boxBaseDecoration( Colors.white, 20),
                child: Column(
                  children: [
                    Container(
                      padding:  EdgeInsets.all(10),
                      decoration: boxBaseDecorationC(g.wstrGameColor, 20,20,0,0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              tc('PRIZE  $place   ${(e["GAME_TYPE"]??"")}', Colors.white, 15),
                              Container(
                                decoration: boxDecoration(Colors.white, 30),
                                padding: const EdgeInsets.symmetric(vertical: 5,horizontal:20),
                                child: Row(
                                  children: [
                                    tcn('Number :', Colors.black, 15),
                                    tc((e["NUMBER"]??""), Colors.black, 15),
                                  ],
                                ),
                              )
                            ],
                          ),
                          gapHC(10),
                          const  Divider(
                            height: 0.6,
                            color: Colors.white,
                          ),
                          gapHC(5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    tcn('Count', Colors.white, 12),
                                    gapWC(10),
                                    tc(detCount.toStringAsFixed(0), Colors.white, 14)
                                  ],
                                ),
                              ),
                              Expanded(child: Row(
                                children: [
                                  tcn('Total', Colors.white, 12),
                                  gapWC(10),
                                  tc(detTotal.toStringAsFixed(2), Colors.white, 14)
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
                                    tcn('AMT', Colors.white, 12),
                                    gapWC(10),
                                    tc(detAmt.toStringAsFixed(2), Colors.white, 14)
                                  ],
                                ),
                              ),
                              Expanded(child: Row(
                                children: [
                                  tcn('Commission', Colors.white, 12),
                                  gapWC(10),
                                  tc(detComm.toStringAsFixed(2), Colors.white, 14)
                                ],
                              ),)
                            ],
                          )
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      decoration: boxBaseDecorationC(Colors.blueGrey, 0,0,0,0),
                      child: Row(
                        children: [
                          wRowDetWhite(2,userTitle),
                          wRowDetWhite(2,'COUNT'),
                          wRowDetWhite(2,'AMT'),
                          wRowDetWhite(2,'COM'),
                          wRowDetWhite(2,'TOTAL'),
                        ],
                      ),
                    ),
                    gapHC(5),
                    Expanded(
                        child: ListView.builder(
                            padding: const EdgeInsets.all(0),
                            physics: const AlwaysScrollableScrollPhysics(),
                            itemCount: reportDet.length,
                            itemBuilder: (context, index) {
                              var eDet = reportDet[index];
                              var grandTotal = 0.0;
                              grandTotal  =  g.mfnDbl(e["TOTAL"].toString())+g.mfnDbl(e["COM"].toString());
                              var com =  g.wstrUserRole == "ADMIN"?(eDet["ADMIN_COM_RATE"]??""):
                              g.wstrUserRole == "STOCKIST"?(eDet["STOCKIST_COM_RATE"]??""):
                              g.wstrUserRole == "DEALER"?(eDet["DEALER_COM_RATE"]??""):(eDet["AGENT_COM"]??"");

                              var amt =  g.wstrUserRole == "ADMIN"?(eDet["ADMIN_WIN"]??""):
                              g.wstrUserRole == "STOCKIST"?(eDet["STOCKIST_WIN"]??""):
                              g.wstrUserRole == "DEALER"?(eDet["DEALER_WIN"]??""):(eDet["AGENT_WIN"]??"");


                              var editYn = (eDet["EDIT_YN"]??"").toString();
                              var deleteYn = (eDet["DELETE_YN"]??"").toString();

                              return Container(
                                decoration: boxBaseDecoration( deleteYn == "Y"?Colors.red.withOpacity(0.3):editYn == "Y"?Colors.amber.withOpacity(0.3):  index%2==0? Colors.grey.withOpacity(0.1):Colors.white, 0),
                                padding: const EdgeInsets.symmetric(vertical: 3),
                                child: Row(
                                  children: [
                                    g.wstrUserRole == "ADMIN"?
                                    wRowDet(2,(eDet["STOCKIST_CODE"]??"").toString()):
                                    g.wstrUserRole == "STOCKIST"?
                                    wRowDet(2,(eDet["DEALER_CODE"]??"").toString()):
                                    g.wstrUserRole == "DEALER"?
                                    wRowDet(2,(eDet["AGENT_CODE"]??"").toString()):Container(),
                                    wRowDet(2,(eDet["QTY"]??"").toString()),
                                    wRowDet(2,g.mfnDbl(amt.toString()).toStringAsFixed(2)),
                                    wRowDet(2,g.mfnDbl(com).toStringAsFixed(2)),
                                    wRowDet(2,(g.mfnDbl(amt.toString())+g.mfnDbl(com.toString())).toStringAsFixed(2)),
                                  ],
                                ),
                              );
                            }

                        )),
                  ],
                ),
              )
          );
        }
      }
    }
}
