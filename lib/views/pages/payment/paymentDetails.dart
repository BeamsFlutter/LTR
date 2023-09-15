
import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:ltr/controller/global/globalValues.dart';
import 'package:ltr/services/apiController.dart';
import 'package:ltr/views/components/common/common.dart';
import 'package:ltr/views/pages/payment/payment.dart';

class PaymentDetails extends StatefulWidget {
  const PaymentDetails({Key? key}) : super(key: key);

  @override
  _PaymentDetailsState createState() => _PaymentDetailsState();
}

class _PaymentDetailsState extends State<PaymentDetails> {

  //Global
  var g =  Global();
  var apiCall =  ApiCall();
  late Future<dynamic> futureForm;


  //Page Variables
  var fReportData = [];


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
                  tcn("Payment Details", Colors.white, 20)
                ],
              ),
            ),
            gapHC(15),
            Expanded(
              child: ListView.builder(
                  padding: const EdgeInsets.all(0),
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemCount: fReportData.length,
                  itemBuilder: (context, index) {


                    var data =  fReportData[index];
                    //{TXN_TO_USER: 2SA, PAY_AMOUNT: 673.0, REC_AMOUNT: 2000.0}

                    var _toUser  =  (data["TXN_TO_USER"]??"").toString();
                    var _payAmount  = g.mfnDbl(data["PAY_AMOUNT"].toString());
                    var _recAmount  = g.mfnDbl(data["REC_AMOUNT"].toString());

                    return Container(
                      decoration: boxDecoration(Colors.white, 10),
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          tc(_toUser, Colors.black, 12)
                        ],
                      ),
                    );
                  })
            ),
            gapHC(5),
            Bounce(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) =>   const Payment()));
              },
              duration: const Duration(milliseconds: 110),
              child: Container(
                decoration: boxDecoration(g.wstrGameBColor, 30),
                margin: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                padding: const EdgeInsets.symmetric(vertical: 12,horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.add,color: g.wstrGameOTColor,size: 16,),
                    gapWC(5),
                    tcn('ADD NEW', g.wstrGameOTColor, 16)
                  ],
                ),
              ),
            )

          ],
        ),
      ),
    );
  }


  //===========================================WIDGET
  //===========================================PAGE FN
    fnGetPageData(){
      apiPaymentReport();
    }
  //===========================================API CALL

  apiPaymentReport(){
    var from  = setDate(2, DateTime.now());
    var to  = setDate(2, DateTime.now());
    var mode  ;
    futureForm = apiCall.apiPaymentReport(g.wstrCompany, from, to, g.wstrUserCd, null, "REC");
    futureForm.then((value) => apiPaymentReportRes(value));
  }
  apiPaymentReportRes(value){
    if(mounted){
      setState(() {
        fReportData = [];
        if(g.fnValCheck(value)){
          fReportData = value;
        }
      });
    }
  }

}
