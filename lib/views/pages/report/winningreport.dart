

import 'package:flutter/material.dart';
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
                children: [
                  Container(
                    padding: EdgeInsets.all(5),
                    decoration: boxDecoration(Colors.blueGrey, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        tc('SUPER', Colors.white, 15)
                      ],
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

  //===========================================WIDGET
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
