

import 'package:flutter/material.dart';
import 'package:ltr/controller/global/globalValues.dart';
import 'package:ltr/services/apiController.dart';
import 'package:ltr/views/components/common/common.dart';

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
                      tcn("Sales Report (${g.wstrSelectedGame})", Colors.white, 18)
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
            gapHC(10),
            Expanded(child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      decoration: boxDecoration(Colors.white, 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding:const EdgeInsets.all(5),
                            decoration: boxBaseDecorationC(Colors.blueGrey, 10,10,0,0),
                            child: Row(
                              children: [
                                tc('Bill ID #12356', Colors.white, 15),
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
                                    wRow("Count","65"),
                                    wRow("Stockist","HAKEEM"),
                                    wRow("Dealer","HAKEEM"),
                                    wRow("Agent","HAKEEM"),

                                  ],),
                                ),
                                Expanded(child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        tcn('Total', Colors.black, 13),
                                        tc('1000', Colors.black, 15)
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        tcn('Comm', Colors.black, 13),
                                        tc('500', Colors.black, 15)
                                      ],
                                    ),
                                    Divider(
                                      color: Colors.black,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        tc('Grand Total', Colors.black, 13),
                                        tc('500.00', Colors.black, 15)
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
                                    tcn('Customer', Colors.black, 12),
                                Row(
                                  children: [
                                    const Icon(Icons.access_time_outlined,color: Colors.black,size: 12,),
                                    gapWC(5),
                                    tcn('12-06-2023 04:05 AM', Colors.black, 12)
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ))
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


  //===========================================PAGE FN

  fnGetPageData(){
    Future.delayed(const Duration(seconds: 1),(){
      apiWinningReport();
    });
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

    futureForm =  ApiCall().apiWinningReport(g.wstrCompany, fromDate,toDate, g.wstrSelectedGame, stockist, dealer, agent, type, number);
    futureForm.then((value) => apiWinningReportRes(value));
  }

  apiWinningReportRes(value){
    if(mounted){
      setState(() {
        reportDate = [];
        if(g.fnValCheck(value)){
          reportDate = value??[];
        }
      });
    }
  }
}
