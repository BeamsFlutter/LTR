

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ltr/controller/global/globalValues.dart';
import 'package:ltr/services/apiController.dart';
import 'package:ltr/views/components/alertDialog/alertDialog.dart';
import 'package:ltr/views/components/common/common.dart';
import 'package:ltr/views/pages/home/mainscreen.dart';

class SalesReport extends StatefulWidget {
  final List<dynamic> pFilterData;
  const SalesReport({Key? key, required this.pFilterData}) : super(key: key);
  @override
  _SalesReportState createState() => _SalesReportState();
}

class _SalesReportState extends State<SalesReport> {

  //Global
  var g = Global();
  var apiCall = ApiCall();
  late Future<dynamic> futureForm;

  //Page Variable
  var fCount = 0;
  var fGTotal = 0.0;
  var fTotal = 0.0;
  var fComm = 0.0;

  var fPageMode = "";
  var fGame = "";

  var reportDate = [];
  var reportHeader = [];
  var reportLog  = [];


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
                      tcn("Sales Report (${fGame.toString()})", Colors.white, 18)
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
                      g.wstrUserRole == "AGENT" && g.wstrCanViewComm != "Y"?
                      gapHC(0):
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
            gapHC(5),
            fPageMode != "SUM"?
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: Row(
                children: [
                  wRowDet(2,'GAME'),
                  wRowDet(2,'NUM'),
                  wRowDet(2,'CNT'),
                  wRowDet(2,'COM'),
                  wRowDet(2,'AMT'),
                  wRowDet(2,'TOTAL'),
                ],
              ),
            ):gapHC(0),
            fPageMode == "SUM"?
              Expanded(
                child: ListView.builder(
                    padding: const EdgeInsets.all(0),
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemCount: reportDate.length,
                    itemBuilder: (context, index) {
                      var e = reportDate[index];
                      var grandTotal = 0.0;
                      grandTotal  =  g.mfnDbl(e["TOTAL"].toString())+g.mfnDbl(e["COM"].toString());

                      var det = [];
                      var headerEditYn = (e["HEADER_EDIT_YN"]??"").toString();
                      var headerDeleteYn = (e["HEADER_DELETE_YN"]??"").toString();

                      det = (e["DET"]??[]);
                      var actionDate = "";
                      try{
                        actionDate = setDate(7, DateTime.parse(e["DOCDATE"].toString()));
                      }catch(e){
                        actionDate = "";
                      }

                      return  GestureDetector(
                        onTap: (){
                          //PageDialog().showPhoneLookup(context, Container(), e["DOCNO"].toString());
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
                                              tc((e["DOCNO"]??"").toString(), Colors.white , 17),
                                              GestureDetector(
                                                onTap: (){
                                                  Navigator.pop(context);
                                                },
                                                child: const Icon(Icons.close,color: Colors.white,size: 20,),
                                              )
                                            ],
                                          ),
                                          gapHC(10),
                                          const  Divider(
                                            height: 0.6,
                                            color: Colors.white,
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              tcn('Customer  ${(e["CUSTOMER_NAME"]??"").toString().toUpperCase()}', Colors.white, 12),
                                              Row(
                                                children: [
                                                  const Icon(Icons.access_time_outlined,color: Colors.white,size: 12,),
                                                  gapWC(5),
                                                  tcn(actionDate.toString(), Colors.white, 12)
                                                ],
                                              )
                                            ],
                                          ),

                                          const  Divider(
                                            height: 0.6,
                                            color: Colors.white,
                                          ),
                                          Row(
                                            children: [
                                              g.wstrUserRole == "ADMIN"?
                                              Expanded(child: wRowWhite("Stockist",(e["STOCKIST_CODE"]??"").toString())):gapHC(0),
                                              g.wstrUserRole == "ADMIN" || g.wstrUserRole == "STOCKIST"?
                                              Expanded(child: wRowWhite("Dealer",(e["DEALER_CODE"]??"").toString())):gapHC(0),
                                              g.wstrUserRole == "ADMIN" || g.wstrUserRole == "STOCKIST" || g.wstrUserRole == "DEALER"?
                                              Expanded(child: wRowWhite("Agent",(e["AGENT_CODE"]??"").toString())):gapHC(0),
                                            ],
                                          ),
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
                                                    tc((e["QTY"]??"").toString(), Colors.white, 14)
                                                  ],
                                                ),
                                              ),
                                              Expanded(child: Row(
                                                children: [
                                                  tcn('Grand Total', Colors.white, 12),
                                                  gapWC(10),
                                                  tc(grandTotal.toStringAsFixed(2), Colors.white, 14)
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
                                                    tc((e["TOTAL"]??"").toString(), Colors.white, 14)
                                                  ],
                                                ),
                                              ),
                                              g.wstrUserRole == "AGENT" && g.wstrCanViewComm != "Y"?
                                              gapHC(0):
                                              Expanded(child: Row(
                                                children: [
                                                  tcn('Commission', Colors.white, 12),
                                                  gapWC(10),
                                                  tc((e["COM"]??"").toString(), Colors.white, 14)
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
                                          wRowDetWhite(2,'GAME'),
                                          wRowDetWhite(2,'NUM'),
                                          wRowDetWhite(2,'CNT'),
                                          wRowDetWhite(2,'COM'),
                                          wRowDetWhite(2,'AMT'),
                                          wRowDetWhite(2,'TOTAL'),
                                        ],
                                      ),
                                    ),
                                    gapHC(5),
                                    Expanded(
                                        child: ListView.builder(
                                            padding: const EdgeInsets.all(0),
                                            physics: const AlwaysScrollableScrollPhysics(),
                                            itemCount: det.length,
                                            itemBuilder: (context, index) {
                                              var e = det[index];
                                              var grandTotal = 0.0;
                                              grandTotal  =  g.mfnDbl(e["TOTAL"].toString())+g.mfnDbl(e["COM"].toString());


                                              var editYn = (e["EDIT_YN"]??"").toString();
                                              var deleteYn = (e["DELETE_YN"]??"").toString();

                                              return Container(
                                                decoration: boxBaseDecoration( deleteYn == "Y"?Colors.red.withOpacity(0.3):editYn == "Y"?Colors.amber.withOpacity(0.3):  index%2==0? Colors.grey.withOpacity(0.1):Colors.white, 0),
                                                padding: const EdgeInsets.symmetric(vertical: 3),
                                                child: Row(
                                                  children: [
                                                    wRowDet(2,(e["GAME_TYPE"]??"").toString()),
                                                    wRowDet(2,(e["NUMBER"]??"").toString()),
                                                    wRowDet(2,(e["QTY"]??"").toString()),
                                                    wRowDet(2,g.mfnDbl(e["COM"].toString()).toStringAsFixed(2)),
                                                    wRowDet(2,g.mfnDbl(e["TOTAL"].toString()).toStringAsFixed(2)),
                                                    wRowDet(2,grandTotal.toString()),
                                                  ],
                                                ),
                                              );
                                            }

                                        )),
                                    // Expanded(child: SingleChildScrollView(
                                    //   child: Column(
                                    //     children: wDetList(det),
                                    //   ),
                                    // ))
                                  ],
                                ),
                              )
                          );
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(vertical: 5),
                          decoration: boxBaseDecoration(headerDeleteYn == "Y"?Colors.red.withOpacity(0.1):headerEditYn == "Y"?Colors.amber.withOpacity(0.3): Colors.white, 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding:const EdgeInsets.all(5),
                                decoration: boxBaseDecorationC(Colors.blueGrey, 10,10,0,0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    tc('Bill ID #${e["DOCNO"].toString()}', Colors.white, 14),

                                    GestureDetector(
                                      onTap: (){
                                        apiGetLog(e["DOCNO"].toString(),e);
                                      },
                                      child: Container(
                                        decoration: boxBaseDecoration(Colors.white,30),
                                        padding:  const EdgeInsets.symmetric(horizontal: 15,vertical: 3),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            tcn('LOG VIEW', Colors.black, 12),
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              gapHC(5),
                              Padding(
                                padding: const EdgeInsets.all(5),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Column(children: [
                                        wRow("Count",(e["QTY"]??"").toString()),
                                        g.wstrUserRole == "ADMIN"?
                                        wRow("Stockist",(e["STOCKIST_CODE"]??"").toString()):gapHC(0),
                                        g.wstrUserRole == "ADMIN" || g.wstrUserRole == "STOCKIST"?
                                        wRow("Dealer",(e["DEALER_CODE"]??"").toString()):gapHC(0),
                                        g.wstrUserRole == "ADMIN" || g.wstrUserRole == "STOCKIST" || g.wstrUserRole == "DEALER"?
                                        wRow("Agent",(e["AGENT_CODE"]??"").toString()):gapHC(0),

                                      ],),
                                    ),
                                    Expanded(child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            tcn('Total', Colors.black, 13),
                                            tcn(g.mfnDbl(e["TOTAL"].toString()).toStringAsFixed(2), Colors.black, 14)
                                          ],
                                        ),
                                        g.wstrUserRole == "AGENT" && g.wstrCanViewComm != "Y"?
                                        gapHC(0):
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            tcn('Comm', Colors.black, 13),
                                            tcn(g.mfnDbl(e["COM"].toString()).toStringAsFixed(2), Colors.black, 14)
                                          ],
                                        ),
                                        Divider(
                                          color: Colors.black,
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            tc('Grand Total', Colors.black, 13),
                                            tc(grandTotal.toStringAsFixed(2), Colors.black, 15)
                                          ],
                                        ),
                                      ],
                                    ))
                                  ],
                                ),
                              ) ,
                              gapHC(10),
                              Container(
                                padding: const EdgeInsets.all(5),
                                decoration: boxBaseDecorationC(Colors.grey.withOpacity(0.05), 0,0,10,10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    tcn('Customer  ${(e["CUSTOMER_NAME"]??"").toString().toUpperCase()}', Colors.black, 12),
                                    Row(
                                      children: [
                                        const Icon(Icons.access_time_outlined,color: Colors.black,size: 12,),
                                        gapWC(5),
                                        tcn(actionDate.toString(), Colors.black, 12)
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                ),

              ):
              // Expanded(child: Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 8),
              //   child: SingleChildScrollView(
              //     child: Column(
              //       children: wSalesData(),
              //     ),
              //   ),
              // )):
              Expanded(
                  child: ListView.builder(
                      padding: const EdgeInsets.all(0),
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemCount: reportDate.length,
                      itemBuilder: (context, index) {
                        var e = reportDate[index];
                        var grandTotal = 0.0;
                        grandTotal  =  g.mfnDbl(e["TOTAL"].toString())+g.mfnDbl(e["COM"].toString());

                        var det = [];

                        det = (e["DET"]??[]);
                        var actionDate = "";
                        try{
                          actionDate = setDate(7, DateTime.parse(e["DOCDATE"].toString()));
                        }catch(e){
                          actionDate = "";
                        }
                        return Column(
                          children: [
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 1),
                              decoration: boxDecoration(Colors.white, 0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding:const EdgeInsets.all(5),
                                    decoration: boxBaseDecorationC(Colors.blueGrey, 0,0,0,0),
                                    child: Row(
                                      children: [
                                        tc('Bill ID #${e["DOCNO"].toString()}', Colors.white, 14),
                                      ],
                                    ),
                                  ),
                                  gapHC(5),
                                  Padding(
                                    padding: const EdgeInsets.all(5),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Column(children: [
                                            wRow("Count",(e["QTY"]??"").toString()),
                                            g.wstrUserRole == "ADMIN"?
                                            wRow("Stockist",(e["STOCKIST_CODE"]??"").toString()):gapHC(0),
                                            g.wstrUserRole == "ADMIN" || g.wstrUserRole == "STOCKIST"?
                                            wRow("Dealer",(e["DEALER_CODE"]??"").toString()):gapHC(0),
                                            g.wstrUserRole == "ADMIN" || g.wstrUserRole == "STOCKIST" || g.wstrUserRole == "DEALER"?
                                            wRow("Agent",(e["AGENT_CODE"]??"").toString()):gapHC(0),
                                          ],),
                                        ),
                                        Expanded(child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                tcn('Total', Colors.black, 13),
                                                tcn(g.mfnDbl(e["TOTAL"].toString()).toStringAsFixed(2), Colors.black, 14)
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                tcn('Comm', Colors.black, 13),
                                                tcn(g.mfnDbl(e["COM"].toString()).toStringAsFixed(2), Colors.black, 14)
                                              ],
                                            ),
                                            Divider(
                                              color: Colors.black,
                                            ),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                tc('Grand Total', Colors.black, 13),
                                                tc(grandTotal.toStringAsFixed(2), Colors.black, 15)
                                              ],
                                            ),
                                          ],
                                        ))
                                      ],
                                    ),
                                  ) ,
                                  gapHC(10),
                                  Container(
                                    padding: const EdgeInsets.all(5),
                                    decoration: boxBaseDecorationC(Colors.grey.withOpacity(0.05), 0,0,10,10),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        tcn('Customer  ${(e["CUSTOMER_NAME"]??"").toString().toUpperCase()}', Colors.black, 12),
                                        Row(
                                          children: [
                                            const Icon(Icons.access_time_outlined,color: Colors.black,size: 12,),
                                            gapWC(5),
                                            tcn(actionDate.toString(), Colors.black, 12)
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              decoration: boxDecoration(Colors.white, 0),
                              padding: const EdgeInsets.symmetric(horizontal: 6),
                              child: Column(
                                children:  wDetList(det),
                              ),
                            )
                          ],
                        );

                      }
                  ),
                )
          ],
        ),
      ),
    );
  }

  //===========================================WIDGET

  Widget wRow(head,sub){
    return Row(
      children: [
        Flexible(
          flex: 3,
          child: Row(
          children: [
            tcn(head, Colors.black, 12),
          ],
        ),),
        Flexible(
          flex: 7,
          child: Row(
          children: [
            tcn(sub, Colors.black, 13),
          ],
        ),)
      ],
    );
  }

  Widget wRowWhite(head,sub){
    return Row(
      children: [
        tcn(head +" : ", Colors.white, 12),
        tcn(sub, Colors.white, 13),

      ],
    );
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

  Widget wRowDetWhite(flx,txt){
    return  Flexible(
        flex: flx,
        child: Row(
          children: [
            tc(txt.toString(), Colors.white, 12)
          ],
        ));
  }

  List<Widget> wSalesData(){
    List<Widget> rtnList  = [];

    for(var e in reportDate){
      var grandTotal = 0.0;
      grandTotal  =  g.mfnDbl(e["TOTAL"].toString())+g.mfnDbl(e["COM"].toString());

      var det = [];

      det = (e["DET"]??[]);
      var actionDate = "";
      try{
        actionDate = setDate(7, DateTime.parse(e["DOCDATE"].toString()));
      }catch(e){
        actionDate = "";
      }

      rtnList.add(
          GestureDetector(
            onTap: (){
              //PageDialog().showPhoneLookup(context, Container(), e["DOCNO"].toString());
              bottomPopUpL(context,
                  Container(
                    decoration: boxBaseDecoration(Colors.white, 20),
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
                                  tc((e["DOCNO"]??"").toString(), Colors.white , 17),
                                  GestureDetector(
                                    onTap: (){
                                      Navigator.pop(context);
                                    },
                                    child: const Icon(Icons.close,color: Colors.white,size: 20,),
                                  )
                                ],
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
                                        tc((e["QTY"]??"").toString(), Colors.white, 14)
                                      ],
                                    ),
                                  ),
                                  Expanded(child: Row(
                                    children: [
                                      tcn('Grand Total', Colors.white, 12),
                                      gapWC(10),
                                      tc(grandTotal.toStringAsFixed(2), Colors.white, 14)
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
                                        tc((e["TOTAL"]??"").toString(), Colors.white, 14)
                                      ],
                                    ),
                                  ),
                                  Expanded(child: Row(
                                    children: [
                                      tcn('Commission', Colors.white, 12),
                                      gapWC(10),
                                      tc((e["COM"]??"").toString(), Colors.white, 14)
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
                              wRowDetWhite(2,'GAME'),
                              wRowDetWhite(2,'NUM'),
                              wRowDetWhite(2,'CNT'),
                              wRowDetWhite(2,'COM'),
                              wRowDetWhite(2,'AMT'),
                              wRowDetWhite(2,'TOTAL'),
                            ],
                          ),
                        ),
                        gapHC(5),
                        Expanded(
                            child: ListView.builder(
                              padding: const EdgeInsets.all(0),
                              physics: const AlwaysScrollableScrollPhysics(),
                              itemCount: det.length,
                              itemBuilder: (context, index) {
                                var e = det[index];
                                var grandTotal = 0.0;
                                grandTotal  =  g.mfnDbl(e["TOTAL"].toString())+g.mfnDbl(e["COM"].toString());
                                return Container(
                                  decoration: boxBaseDecoration(index%2==0? g.wstrGameColor.withOpacity(0.2):Colors.white, 0),
                                  padding: const EdgeInsets.symmetric(vertical: 3),
                                  child: Row(
                                    children: [
                                      wRowDet(2,(e["GAME_TYPE"]??"").toString()),
                                      wRowDet(2,(e["NUMBER"]??"").toString()),
                                      wRowDet(2,(e["QTY"]??"").toString()),
                                      wRowDet(2,g.mfnDbl(e["COM"].toString()).toStringAsFixed(2)),
                                      wRowDet(2,g.mfnDbl(e["TOTAL"].toString()).toStringAsFixed(2)),
                                      wRowDet(2,grandTotal.toString()),
                                    ],
                                  ),
                                );
                              }

                         )),
                        // Expanded(child: SingleChildScrollView(
                        //   child: Column(
                        //     children: wDetList(det),
                        //   ),
                        // ))
                      ],
                    ),
                  )
              );
            },
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 5),
              decoration: boxDecoration(Colors.white, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding:const EdgeInsets.all(5),
                    decoration: boxBaseDecorationC(Colors.blueGrey, 10,10,0,0),
                    child: Row(
                      children: [
                        tc('Bill ID #${e["DOCNO"].toString()}', Colors.white, 14),
                      ],
                    ),
                  ),
                  gapHC(5),
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(children: [
                            wRow("Count",(e["QTY"]??"").toString()),
                            g.wstrUserRole == "ADMIN"?
                            wRow("Stockist",(e["STOCKIST_CODE"]??"").toString()):gapHC(0),
                            g.wstrUserRole == "ADMIN" || g.wstrUserRole == "STOCKIST"?
                            wRow("Dealer",(e["DEALER_CODE"]??"").toString()):gapHC(0),
                            g.wstrUserRole == "ADMIN" || g.wstrUserRole == "STOCKIST" || g.wstrUserRole == "DEALER"?
                            wRow("Agent",(e["AGENT_CODE"]??"").toString()):gapHC(0),

                          ],),
                        ),
                        Expanded(child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                tcn('Total', Colors.black, 13),
                                tcn(g.mfnDbl(e["TOTAL"].toString()).toStringAsFixed(2), Colors.black, 14)
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                tcn('Comm', Colors.black, 13),
                                tcn(g.mfnDbl(e["COM"].toString()).toStringAsFixed(2), Colors.black, 14)
                              ],
                            ),
                            Divider(
                              color: Colors.black,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                tc('Grand Total', Colors.black, 13),
                                tc(grandTotal.toStringAsFixed(2), Colors.black, 15)
                              ],
                            ),
                          ],
                        ))
                      ],
                    ),
                  ) ,
                  gapHC(10),
                  Container(
                    padding: const EdgeInsets.all(5),
                    decoration: boxBaseDecorationC(Colors.grey.withOpacity(0.05), 0,0,10,10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        tcn('Customer  ${(e["CUSTOMER_NAME"]??"").toString().toUpperCase()}', Colors.black, 12),
                        Row(
                          children: [
                            const Icon(Icons.access_time_outlined,color: Colors.black,size: 12,),
                            gapWC(5),
                            tcn(actionDate.toString(), Colors.black, 12)
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
      );
    }

    return rtnList;
  }
  List<Widget> wSalesDataFull(){
    List<Widget> rtnList  = [];

    for(var e in reportDate){
      var grandTotal = 0.0;
      grandTotal  =  g.mfnDbl(e["TOTAL"].toString())+g.mfnDbl(e["COM"].toString());

      var det = [];

      det = (e["DET"]??[]);
      var actionDate = "";
      try{
        actionDate = setDate(7, DateTime.parse(e["DOCDATE"].toString()));
      }catch(e){
        actionDate = "";
      }

      rtnList.add(
          Container(
            margin: EdgeInsets.symmetric(vertical: 1),
            decoration: boxDecoration(Colors.white, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding:const EdgeInsets.all(5),
                  decoration: boxBaseDecorationC(Colors.blueGrey, 0,0,0,0),
                  child: Row(
                    children: [
                      tc('Bill ID #${e["DOCNO"].toString()}', Colors.white, 14),
                    ],
                  ),
                ),
                gapHC(5),
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(children: [
                          wRow("Count",(e["QTY"]??"").toString()),
                          g.wstrUserRole == "ADMIN"?
                          wRow("Stockist",(e["STOCKIST_CODE"]??"").toString()):gapHC(0),
                          g.wstrUserRole == "ADMIN" || g.wstrUserRole == "STOCKIST"?
                          wRow("Dealer",(e["DEALER_CODE"]??"").toString()):gapHC(0),
                          g.wstrUserRole == "ADMIN" || g.wstrUserRole == "STOCKIST" || g.wstrUserRole == "DEALER"?
                          wRow("Agent",(e["AGENT_CODE"]??"").toString()):gapHC(0),

                        ],),
                      ),
                      Expanded(child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              tcn('Total', Colors.black, 13),
                              tcn(g.mfnDbl(e["TOTAL"].toString()).toStringAsFixed(2), Colors.black, 14)
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              tcn('Comm', Colors.black, 13),
                              tcn(g.mfnDbl(e["COM"].toString()).toStringAsFixed(2), Colors.black, 14)
                            ],
                          ),
                          Divider(
                            color: Colors.black,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              tc('Grand Total', Colors.black, 13),
                              tc(grandTotal.toStringAsFixed(2), Colors.black, 15)
                            ],
                          ),
                        ],
                      ))
                    ],
                  ),
                ) ,
                gapHC(10),
                Container(
                  padding: const EdgeInsets.all(5),
                  decoration: boxBaseDecorationC(Colors.grey.withOpacity(0.05), 0,0,10,10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      tcn('Customer  ${(e["CUSTOMER_NAME"]??"").toString().toUpperCase()}', Colors.black, 12),
                      Row(
                        children: [
                          const Icon(Icons.access_time_outlined,color: Colors.black,size: 12,),
                          gapWC(5),
                          tcn(actionDate.toString(), Colors.black, 12)
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          )
      );
      rtnList.add(
        Container(
          decoration: boxDecoration(Colors.white, 0),
          padding: const EdgeInsets.symmetric(horizontal: 6),
          child: Column(
            children:  wDetList(det),
          ),
        )
      );
    }

    return rtnList;
  }
  List<Widget> wDetList(det){
    List<Widget> rtnList = [];
    var srno = 0;
    for(var e in det){
      var grandTotal = 0.0;
      grandTotal  =  g.mfnDbl(e["TOTAL"].toString())+g.mfnDbl(e["COM"].toString());
      rtnList.add(
        Container(
          decoration: boxBaseDecoration(srno%2==0? g.wstrGameColor.withOpacity(0.2):Colors.white, 0),
          padding: const EdgeInsets.symmetric(vertical: 3),
          child: Row(
            children: [
              wRowDet(2,(e["GAME_TYPE"]??"").toString()),
              wRowDet(2,(e["NUMBER"]??"").toString()),
              wRowDet(2,(e["QTY"]??"").toString()),
              wRowDet(2,g.mfnDbl(e["COM"].toString()).toStringAsFixed(2)),
              wRowDet(2,g.mfnDbl(e["TOTAL"].toString()).toStringAsFixed(2)),
              wRowDet(2,grandTotal.toString()),
            ],
          ),
        ),
      );
      srno =srno+1;
    }
    return rtnList;
  }


  //===========================================PAGE FN

  fnGetPageData(){
    Future.delayed(const Duration(seconds: 1),(){
      apiSalesReport();
    });
  }

  //===========================================API CALL

  apiSalesReport(){

    var filterData = [];
    filterData = widget.pFilterData;

    var admCode = "";
    var stockist = (filterData[0]["STOCKIST"]);
    var dealer = (filterData[0]["DEALER"]);
    var agent = (filterData[0]["AGENT"]);
    var type = (filterData[0]["TYPE"]);
    var number = (filterData[0]["NUMBER"]);
    var fromDate = (filterData[0]["DATE_FROM"]);
    var toDate = (filterData[0]["DATE_TO"]);
    var mode = (filterData[0]["MODE"]);
    var child = (filterData[0]["CHILD"]);
    var game = (filterData[0]["GAME"]);
    var typeList = (filterData[0]["TYPE_LIST"]);

    if(mounted){
      setState(() {
        fGame = game;
        fPageMode = mode;
      });
    }
    var supYn =  g.wstrCompany == "00"?"Y":"";
    futureForm =  ApiCall().apiSalesReport(g.wstrCompany, fromDate,toDate, game, admCode,stockist, dealer, agent, type, number,"",child,typeList,supYn);
    futureForm.then((value) => apiSalesReportRes(value));
  }

  apiSalesReportRes(value){
    if(mounted){
      setState(() {
        reportDate = [];
        reportHeader = [];

        fCount =0;
        fTotal =0.0;
        fComm =0.0;
        fGTotal= 0.0;

        if(g.fnValCheck(value)){
          reportDate = value["DET"]??[];
          reportHeader.add(value["HEADER"]??{});

          if(g.fnValCheck(reportHeader)){
            fCount = g.mfnInt(reportHeader[0]["QTY"].toString());
            fTotal = g.mfnDbl(reportHeader[0]["TOTAL"].toString());
            fComm = g.mfnDbl(reportHeader[0]["COM"].toString());
            fGTotal  = fTotal+fComm;
          }

        }else{
          errorMsg(context, "No Result Found!!");
        }
      });
    }
  }


  apiGetLog(docno,data){
    futureForm =  ApiCall().apiGetLog(docno, "BKD");
    futureForm.then((value) => apiGetLogRes(value,data));
  }

  apiGetLogRes(value,e){
    if(mounted){
      setState(() {
        reportLog = [];
        if(g.fnValCheck(value)){
          reportLog = value;
        }
      });

      if(g.fnValCheck(value)){

        var actionDate = "";
        try{
          actionDate = setDate(7, DateTime.parse(e["DOCDATE"].toString()));
        }catch(e){
          actionDate = "";
        }

        bottomPopUpL(context,
            Container(
              decoration: boxBaseDecoration(Colors.white, 20),
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
                            tc((e["DOCNO"]??"").toString(), Colors.white , 17),
                            GestureDetector(
                              onTap: (){
                                Navigator.pop(context);
                              },
                              child: const Icon(Icons.close,color: Colors.white,size: 20,),
                            )
                          ],
                        ),
                        gapHC(5),
                        gapHC(10),
                        const  Divider(
                          height: 0.6,
                          color: Colors.white,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            tcn('Customer  ${(e["CUSTOMER_NAME"]??"").toString().toUpperCase()}', Colors.white, 12),
                            Row(
                              children: [
                                const Icon(Icons.access_time_outlined,color: Colors.white,size: 12,),
                                gapWC(5),
                                tcn(actionDate.toString(), Colors.white, 12)
                              ],
                            )
                          ],
                        ),

                        const  Divider(
                          height: 0.6,
                          color: Colors.white,
                        ),
                        Row(
                          children: [
                            g.wstrUserRole == "ADMIN"?
                            Expanded(child: wRowWhite("Stockist",(e["STOCKIST_CODE"]??"").toString())):gapHC(0),
                            g.wstrUserRole == "ADMIN" || g.wstrUserRole == "STOCKIST"?
                            Expanded(child: wRowWhite("Dealer",(e["DEALER_CODE"]??"").toString())):gapHC(0),
                            g.wstrUserRole == "ADMIN" || g.wstrUserRole == "STOCKIST" || g.wstrUserRole == "DEALER"?
                            Expanded(child: wRowWhite("Agent",(e["AGENT_CODE"]??"").toString())):gapHC(0),
                          ],
                        ),
                      ],
                    ),
                  ),
                  gapHC(5),
                  Expanded(
                      child: ListView.builder(
                          padding: const EdgeInsets.all(0),
                          physics: const AlwaysScrollableScrollPhysics(),
                          itemCount: reportLog.length,
                          itemBuilder: (context, index) {
                            var k = reportLog[index];
                            var grandTotal = 0.0;

                            var logAction = "";
                            try{
                              logAction = setDate(7, DateTime.parse(k["ACTIONDATE"].toString()));
                            }catch(e){
                              logAction = "";
                            }


                            return Container(
                              decoration: boxBaseDecoration( Colors.grey.withOpacity(0.2), 10),
                              padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                              margin: EdgeInsets.all(5),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  tc((k["ACTION"]??"").toString(), Colors.black, 15),
                                  Row(
                                    children: [
                                      Icon(Icons.access_time,color: Colors.black,size: 13,),
                                      gapWC(5),
                                      tcn(logAction.toString(), Colors.black, 13)
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Icon(Icons.person,color: Colors.black,size: 13,),
                                      gapWC(5),
                                      tcn("${(k["USERCODE"]??"").toString().toUpperCase()} (${(k["USER_ROLE"]??"").toString().toUpperCase()})", Colors.black, 13)
                                    ],
                                  )
                                ],
                              ),
                            );
                          }

                      )),
                  // Expanded(child: SingleChildScrollView(
                  //   child: Column(
                  //     children: wDetList(det),
                  //   ),
                  // ))
                ],
              ),
            )
        );
      }
    }
  }

}



