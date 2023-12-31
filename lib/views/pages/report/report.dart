

import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:ltr/controller/global/globalValues.dart';
import 'package:ltr/views/components/common/common.dart';
import 'package:ltr/views/pages/report/balancereport.dart';
import 'package:ltr/views/pages/report/countReport.dart';
import 'package:ltr/views/pages/report/paymentReport.dart';
import 'package:ltr/views/pages/report/reportdetails.dart';
import 'package:ltr/views/styles/colors.dart';

class Reports extends StatefulWidget {
  const Reports({Key? key}) : super(key: key);

  @override
  State<Reports> createState() => _ReportsState();
}

class _ReportsState extends State<Reports> {

  //Global
  var g = Global();

  //Page Variable
  var reportList = [];

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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  tcn("Reports", Colors.white, 20),
                  GestureDetector(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Container(
                      decoration: boxBaseDecoration(Colors.white,10),
                      padding: const EdgeInsets.all(5),
                      child: const Icon(Icons.segment,color: Colors.black,size: 20,),
                    ),
                  ),
                ],
              ),
            ),
            gapHC(15),
            Expanded(child: Container(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: wReportList(),
              ),
            ))
          ],
        ),
      ),
    );
  }

  //===============================WIDGET

  List<Widget> wReportList(){
    List<Widget> rtnList = [];
    for(var e in reportList){
      rtnList.add(Bounce(
        onPressed: (){
          if(e["CODE"] == 3){
            Navigator.push(context, MaterialPageRoute(builder: (context) =>    CountReport(reportName: e["NAME"], reportCode: e["CODE"].toString())));

          }else if(e["CODE"] == 5){
            Navigator.push(context, MaterialPageRoute(builder: (context) =>    const PaymentReport()));

          }else if(e["CODE"] == 6){
            Navigator.push(context, MaterialPageRoute(builder: (context) =>    BalanceReport(reportName: e["NAME"], reportCode: e["CODE"].toString())));

          }else{
            Navigator.push(context, MaterialPageRoute(builder: (context) =>    ReportDetails(reportName: e["NAME"], reportCode: e["CODE"].toString(),)));
          }
        },
        duration: const Duration(milliseconds: 110),
        child: Container(
          margin: const EdgeInsets.only(bottom: 5),
          decoration: boxDecoration(Colors.white, 10),
          padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(e["ICON"],color: Colors.black,size: 20,),
                  gapWC(10),
                  tcn(e["NAME"], Colors.black , 15)
                ],
              ),
              const Icon(Icons.navigate_next_sharp,color: Colors.black,size: 20,),
            ],
          ),
        ),
      ));
    }

    return rtnList;
  }

  //===============================PAGE FN

  fnGetPageData(){
    if(mounted){
      setState(() {
        reportList = [
          {
            "CODE":1,
            "NAME":"SALES REPORT",
            "ICON":Icons.bar_chart_rounded
          },
          {
            "CODE":2,
            "NAME":"WINNING REPORT",
            "ICON":Icons.card_giftcard
          },
          {
            "CODE":3,
            "NAME":"COUNT REPORT",
            "ICON":Icons.numbers
          },
          {
            "CODE":4,
            "NAME":"DAILY REPORT",
            "ICON":Icons.calendar_month
          },
          {
            "CODE":5,
            "NAME":"PAYMENT REPORT",
            "ICON":Icons.price_change_outlined
          },
          {
            "CODE":6,
            "NAME":"BALANCE REPORT",
            "ICON":Icons.calculate
          },
        ];
      });
    }
  }

  //===============================API CALL
}
