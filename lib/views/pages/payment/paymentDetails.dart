
import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:ltr/controller/global/globalValues.dart';
import 'package:ltr/services/apiController.dart';
import 'package:ltr/views/components/common/common.dart';
import 'package:ltr/views/pages/payment/payment.dart';
import 'package:ltr/views/pages/user/usersearch.dart';
import 'package:ltr/views/styles/colors.dart';

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
  var frPayMode  = "ALL";
  var frParentMode  = "";
  var fSelectedUserCode = "";
  var fSelectedUserMode = "";

  var fFromDate =  DateTime.now();
  var fToDate =  DateTime.now();


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
          crossAxisAlignment: CrossAxisAlignment.start,
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
            gapHC(10),

            Container(
              margin: const EdgeInsets.symmetric(horizontal: 5),
              padding: const EdgeInsets.all(5),
              decoration: boxDecoration(Colors.white, 10),
              child: Column(
                children: [

                  g.wstrUserRole == "STOCKIST"?
                  Row(
                    children: [
                      wUserSelection("Admin","Y"),
                      wUserSelection("Dealer","")
                    ],
                  ):g.wstrUserRole == "DEALER"?
                  Row(
                    children: [
                      wUserSelection("Stockist","Y"),
                      wUserSelection("Agent","")
                    ],
                  ):gapHC(0),
                  gapHC(2),
                  Row(
                    children: [

                      Expanded(child: Bounce(
                        onPressed: (){

                          if(frParentMode != "Y"){
                            Navigator.push(context, MaterialPageRoute(builder: (context) =>   UserSearch(pRoleCode: fSelectedUserMode, pUserCode: g.wstrUserCd.toString(), pFnCallBack: fnSearchCallBack,)));
                          }

                        },
                        duration: const Duration(milliseconds: 110),
                        child: Container(
                          margin:const  EdgeInsets.symmetric(horizontal: 5),
                          padding: const EdgeInsets.all(10),
                          decoration: boxBaseDecoration(greyLight, 30),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  tcn(fSelectedUserMode, Colors.black, 10),
                                  gapWC(5),
                                  tc(fSelectedUserCode.toString(), Colors.black, 15),
                                ],
                              ),
                              const Icon(Icons.search,color: Colors.grey,size: 18,)
                            ],
                          ),
                        ),
                      )),
                      gapWC(5),
                      GestureDetector(onTap: (){
                        if(mounted){
                          setState(() {
                            fSelectedUserCode ="";
                          });
                        }
                      }, child: const Icon(Icons.cancel,color: Colors.black,size: 20,)),
                      gapWC(5),


                    ],
                  ),
                  gapHC(2),
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: (){
                            _selectFromDate(context);
                          },
                          child: Container(
                            margin: const EdgeInsets.all(5),
                            padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                            decoration: boxBaseDecoration(greyLight, 30),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    const Icon(Icons.calendar_month,color: grey,size: 18,),
                                    gapWC(5),
                                    tcn('From', grey, 15),
                                  ],
                                ),
                                tc(setDate(6, fFromDate).toString(), Colors.black, 13)
                              ],
                            ),
                          ),
                        ),
                      ),
                      gapWC(2),
                      Expanded(child: GestureDetector(
                        onTap: (){
                          _selectToDate(context);
                        },
                        child: Container(
                          margin: const EdgeInsets.all(5),
                          padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                          decoration: boxBaseDecoration(greyLight, 30),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  const Icon(Icons.calendar_month,color: grey,size: 18,),
                                  gapWC(5),
                                  tcn('To', grey, 15),
                                ],
                              ),
                              tc(setDate(6, fToDate).toString(), Colors.black, 13)
                            ],
                          ),
                        ),
                      ),)
                    ],
                  ),
                  Bounce(
                    onPressed: (){
                      apiPaymentReport();
                    },
                    duration: const Duration(milliseconds: 110),
                    child: Container(
                      decoration: boxDecoration(Colors.black, 30),
                      margin: const EdgeInsets.symmetric(vertical: 5,horizontal: 5),
                      padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.search,color: g.wstrGameOTColor,size: 16,),
                          gapWC(5),
                          tcn('Search', g.wstrGameOTColor, 16)
                        ],
                      ),
                    ),
                  )

                ],
              ),
            ),

            const Divider(),
            tcn(' > Transaction Details', Colors.black, 13),
            const Divider(),
            Container(
              padding: const EdgeInsets.all(8),
              margin: const EdgeInsets.symmetric(horizontal: 5),
              decoration: boxBaseDecoration(greyLight, 30),
              child:Row(
                children: [

                  wPayCard("ALL","ALL"),
                  gapWC(5),
                  wPayCard("REC","CASH IN"),
                  gapWC(5),
                  wPayCard("PAY","CASH OUT"),

                ],
              ),
            ),
            gapHC(5),
            Expanded(
              child: ListView.builder(
                  padding: const EdgeInsets.all(0),
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemCount: fReportData.length,
                  itemBuilder: (context, index) {


                    var data =  fReportData[index];
                    //{TXN_TO_USER: 2SA, PAY_AMOUNT: 673.0, REC_AMOUNT: 2000.0}
                    //{COMPANY: 02, DOCNO: 00000003, DOCTYPE: PAY, DOCDATE: 2023-09-14T09:57:37.063, TXN_USER: ADM2, TXN_TO_USER: 2SA, CREATE_USER: adm2, AMOUNT: 673.0, REMARKS: }

                    var wDocNo  =  (data["DOCNO"]??"").toString();
                    var wDocType  =  (data["DOCTYPE"]??"").toString();
                    var wToUser  =  (data["TXN_TO_USER"]??"").toString();
                    var wAmount  = g.mfnDbl(data["AMOUNT"].toString());
                    var wDate  = setDate(17, DateTime.parse(data["DOCDATE"].toString())).toString().toUpperCase();

                    return Container(
                      decoration: boxBaseDecoration(Colors.white, 10),
                      padding: const EdgeInsets.all(10),
                      margin: const EdgeInsets.only(bottom: 5),
                      child: Row(
                        children: [
                          wDocType == "REC"?
                          Container(
                            padding:const  EdgeInsets.all(5),
                            decoration: boxBaseDecoration(greyLight.withOpacity(0.5), 5),
                            child:const Icon(Icons.arrow_upward,color: Colors.green,size: 15,),
                          ):
                          Container(
                            padding:const  EdgeInsets.all(5),
                            decoration: boxBaseDecoration(greyLight.withOpacity(0.5), 5),
                            child:const Icon(Icons.arrow_downward,color: Colors.red,size: 15,),
                          ),
                          gapWC(5),
                          Expanded(child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                                tc("#$wDocNo", Colors.black, 12),
                                Row(
                                  children: [
                                    const Icon(Icons.person_outline,color: Colors.black,size: 13,),
                                    gapWC(5),
                                    tcn(wToUser, Colors.black, 13),
                                  ],
                                ),
                              Row(
                                children: [
                                  const Icon(Icons.access_time_sharp,color: Colors.black,size: 13,),
                                  gapWC(5),
                                  tcn(wDate, Colors.black, 13),
                                ],
                              )


                            ],
                          )),
                          tc(wAmount.toString(), wDocType == "REC"? Colors.green:Colors.red, 15)
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
  Widget wPayCard(mode,text){
    return Flexible(
      child: Bounce(
        onPressed: (){
          if(mounted){
            setState(() {
              frPayMode = mode;
            });
            apiPaymentReport();
          }
        },
        duration:const Duration(milliseconds: 110),
        child: Container(
          padding: const EdgeInsets.all(5),
          decoration:frPayMode == mode? boxDecoration(Colors.white, 30): boxBaseDecoration(greyLight, 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              tcn( text,Colors.black, 15)
            ],
          ),
        ),
      ),
    );
  }

  Widget wUserSelection(mode,pMode){
    return Flexible(child: GestureDetector(
      onTap: (){
        if(mounted){
          setState(() {
            frParentMode = pMode;
            fSelectedUserCode = "";
            if(pMode== "Y"){
              fSelectedUserCode = g.wstrParentCode;
            }
            fSelectedUserMode = mode;
          });
        }
      },
      child: Container(
        decoration: boxBaseDecoration(greyLight.withOpacity(0.5), 30),
        padding: const EdgeInsets.all(5),
        margin: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(4),
              decoration: boxBaseDecoration(Colors.white, 30),
              child: Container(
                height: 18,
                width: 18,
                decoration: fSelectedUserMode == mode?boxDecoration( bgColorDark, 30):boxBaseDecoration( Colors.white, 30),
                child: const Icon(Icons.done,color: Colors.white,size: 13,),
              ),
            ),
            gapWC(10),
            tcn(mode,fSelectedUserMode == mode? Colors.black: Colors.black, 15)
          ],
        ),
      ),
    ));
  }
  //===========================================PAGE FN


  fnGetPageData(){
    apiPaymentReport();
    fnSetRoleWise();
  }

  fnSearchCallBack(rolecode,usercd){
    if(mounted){
      setState(() {
        if(fSelectedUserCode != usercd){
        }
        fSelectedUserCode = usercd;
      });
     apiPaymentReport();
    }
  }

  fnSetRoleWise(){
    if(mounted){
      setState(() {
        if(g.wstrUserRole.toString() == "ADMIN"){
          fSelectedUserMode = "Stockist";
        }else if(g.wstrUserRole == "STOCKIST"){
          fSelectedUserMode = "Dealer";
        }else if(g.wstrUserRole == "DEALER"){
          fSelectedUserMode = "Agent";
        }else if(g.wstrUserRole == "AGENT"){
          fSelectedUserMode = "Dealer";
        }
      });
    }
  }


  Future<void> _selectFromDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: fFromDate,
      firstDate: DateTime(2020),
      lastDate:  DateTime(2100),
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
      lastDate:  DateTime(2100),
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

  //===========================================API CALL

  apiPaymentReport(){
    var from  = setDate(2, fFromDate);
    var to  = setDate(2, fToDate);
    var mode = frPayMode == "ALL"?null:frPayMode ;
    var user = fSelectedUserCode == ""?null:fSelectedUserCode ;
    futureForm = apiCall.apiPaymentReport(g.wstrCompany, from, to, g.wstrUserCd, user, mode);
    futureForm.then((value) => apiPaymentReportRes(value));
  }
  apiPaymentReportRes(value){
    if(mounted){
      setState(() {
        fReportData = [];
        if(g.fnValCheck(value)){
          fReportData = value["DET"]??[];
        }
      });
    }
  }

}
