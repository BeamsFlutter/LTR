


import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:ltr/controller/global/globalValues.dart';
import 'package:ltr/services/apiController.dart';
import 'package:ltr/views/components/common/common.dart';
import 'package:ltr/views/pages/report/salesReport.dart';
import 'package:ltr/views/pages/report/winningreport.dart';
import 'package:ltr/views/pages/user/usersearch.dart';
import 'package:ltr/views/styles/colors.dart';

class BalanceReport extends StatefulWidget {
  final String reportName;
  final String reportCode;
  const BalanceReport({Key? key, required this.reportName, required this.reportCode}) : super(key: key);

  @override
  State<BalanceReport> createState() => _BalanceReportState();
}

class _BalanceReportState extends State<BalanceReport> {

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

  var fTodaySale =0.0;
  var fTodayPrize =0.0;
  var fTodayTotal =0.0;

  var fOpeningBalance = 0.0;
  var fTodayPayment = 0.0;
  var fBalance = 0.0;

  var reportDate = [];

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
                      decoration: boxBaseDecoration(Colors.white,10),
                      padding: const EdgeInsets.all(5),
                      child: const Icon(Icons.arrow_back,color: Colors.black,size: 20,),
                    ),
                  ),
                  gapWC(5),
                  tcn("${widget.reportName} (${g.wstrSelectedGame})", Colors.white, 18)
                ],
              ),
            ),
            Expanded(child: Container(
              padding: const EdgeInsets.all(5),
              child: Column(
                children:[
                  Row(
                    children: [
                      Expanded(child: GestureDetector(
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
                              const Icon(Icons.calendar_month,color: grey,size: 18,),
                              tcn(setDate(6, fFromDate).toString(), Colors.black, 15)
                            ],
                          ),
                        ),
                      ),),
                      Expanded(child: Bounce(
                        onPressed: (){
                          fnShowReport();
                        },
                        duration: const Duration(milliseconds: 110),
                        child: Container(
                          decoration: boxDecoration(g.wstrGameBColor, 30),
                          margin: const EdgeInsets.symmetric(vertical: 0,horizontal: 10),
                          padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.task_alt,color: Colors.white,size: 16,),
                              gapWC(5),
                              tcn('Show Report', Colors.white, 16)
                            ],
                          ),
                        ),
                      ),)
                    ],
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Container(
                        margin: const EdgeInsets.all(8),
                        padding: const EdgeInsets.all(10),
                        decoration: boxDecoration(Colors.white, 10),
                        child: Column(
                          children: [
                            Row(),
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: boxOutlineCustom1(Colors.white, 10, Colors.black, 0.3),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      tcn('SALE :', Colors.black, 15),
                                      tcn(fTodaySale.toStringAsFixed(2), Colors.black, 15),
                                    ],
                                  ),
                                  gapHC(5),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      tcn('PRIZE+DC :', Colors.black, 15),
                                      tcn(fTodayPrize.toStringAsFixed(2), Colors.black, 15),
                                    ],
                                  ),
                                  gapHC(5),
                                  const Divider(
                                    color: Colors.black,
                                    height: 0.5,
                                  ),
                                  gapHC(5),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      tc('TODAY BILL :', Colors.black, 15),
                                      tc(fTodayTotal.toStringAsFixed(2), Colors.black, 15),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            gapHC(10),
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: boxOutlineCustom1(Colors.white, 10, Colors.black, 0.3),
                              child: Column(
                                children: [
                                  wRowCard("OPENING BALANCE",fOpeningBalance),
                                  wRowCard("TOTAL PAYMENT",fTodayPayment),
                                ],
                              ),
                            ),
                            gapHC(10),
                            Container(
                              padding: EdgeInsets.all(5),
                              decoration: boxBaseDecoration(g.wstrGameColor.withOpacity(0.1), 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  tc('BALANCE   ${fBalance.toStringAsFixed(2)}', Colors.black, 15)
                                ],
                              ),
                            )
                          ],
                        ),
                       ),
                      ],
                    ))
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

  Widget wRowCard(txt,amt){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        tcn(txt, Colors.black, 15),
        tcn(amt.toStringAsFixed(2), Colors.black, 15),
      ],
    );
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




  }

  fnGetVal(mode){

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
      lastDate: DateTime(2100),
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
    apiGetReport();
  }

//===============================API CALL

  apiGetReport(){
    futureForm = apiCall.apiBalanceReport(g.wstrCompany, setDate(2, fFromDate));
    futureForm.then((value) => apiGetReportRes(value));
  }
  apiGetReportRes(value){
    if(mounted){
      setState(() {
        reportDate = [];
        if(g.fnValCheck(value)){
          reportDate.add(value??{});

          var dayList = (reportDate[0]["DAY"])??[];
          var opening = (reportDate[0]["OPENING"])??[];


          fTodaySale = g.mfnDbl(dayList[0]["SALES"]);
          fTodayPrize = g.mfnDbl(dayList[0]["WIN"]);
          fTodayTotal = fTodaySale+fTodayPrize;

          fOpeningBalance = g.mfnDbl(opening[0]["OPENING"].toString());
          fTodayPayment = fTodayTotal;

          fBalance = fOpeningBalance + fTodayPayment;

        }else{
          errorMsg(context, "No Result Found!!");
        }
      });
    }
  }


}

