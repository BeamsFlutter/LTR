
import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:ltr/controller/global/globalValues.dart';
import 'package:ltr/services/apiController.dart';
import 'package:ltr/views/components/alertDialog/alertDialog.dart';
import 'package:ltr/views/components/common/common.dart';
import 'package:ltr/views/components/enum.dart';
import 'package:ltr/views/components/inputfield/commonTextField.dart';
import 'package:ltr/views/pages/user/usersearch.dart';
import 'package:ltr/views/styles/colors.dart';

class Payment extends StatefulWidget {
  const Payment({Key? key}) : super(key: key);

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {


  //Global
  var g =  Global();
  var apiCall =  ApiCall();
  late Future<dynamic> futureForm;

  //Page Variables
  var frPayMode  = "REC";
  var frParentMode  = "REC";
  var frOutStanding  = 0.00;
  var fSelectedUserCode = "";
  var fSelectedUserMode = "";

  var wstrPageMode = "ADD";

  //Controller
  var txtAmount = TextEditingController();
  var txtRemarks = TextEditingController();

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
                  tcn("Payment & Receipt", Colors.white, 20)
                ],
              ),
            ),
            gapHC(15),
            Expanded(child: Container(
              padding: const EdgeInsets.all(10),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: boxBaseDecoration(greyLight, 30),
                      child:Row(
                        children: [
                          wPayCard("REC","CASH IN"),
                          gapWC(5),
                          wPayCard("PAY","CASH OUT"),
                        ],
                      ),
                    ),
                    gapHC(5),
                    const Divider(),
                    tcn(' > Select Transaction User', Colors.black, 13),
                    const Divider(),
                    gapHC(5),
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
                    gapHC(5),
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
                            decoration: boxDecoration(Colors.white, 5),
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


                      ],
                    ),
                    gapHC(2),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                      decoration: boxDecoration(Colors.white, 5),
                      padding: const EdgeInsets.all(5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          tcn("OUTSTANDING", Colors.black, 15),
                          tc(frOutStanding.toStringAsFixed(2), Colors.black, 15)
                        ],
                      ),
                    ),
                    gapHC(5),
                    const Divider(),
                    tcn(' > Payment Details', Colors.black, 13),
                    const Divider(),
                    CustomTextField(
                      keybordType: TextInputType.number,
                      controller: txtAmount,
                      editable: true,
                      hintText: "Amount",
                      textFormFieldType: TextFormFieldType.weeklyCreditLimit,
                    ),
                    gapHC(5),
                    Container(
                      height: 150,
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      decoration: boxOutlineCustom1(Colors.white, 5, Colors.grey, 1.0),
                      child: TextFormField(
                        controller: txtRemarks,
                        maxLines: 5,
                        decoration: const InputDecoration(
                          hintText: 'Remarks',
                          counterText: "",
                          border: InputBorder.none,
                        ),
                        onChanged: (val){

                        },
                      ),
                    ),
                  ],
                ),
              ),
            )),
            gapHC(5),
            Row(
              children: [
                gapWC(10),
                wstrPageMode == "ADD"?
                Expanded(child: GestureDetector(
                  onTap: (){
                    apiPaymentSave();
                  },
                  child: Container(
                    decoration: boxDecoration(g.wstrGameBColor, 30),
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.task_alt,color: Colors.white,size: 15,),
                        gapWC(5),
                        tcn('Save', Colors.white, 15)
                      ],
                    ),
                  ),
                )):Expanded(child: Bounce(
                  onPressed: (){

                  },
                  duration: const Duration(milliseconds: 110),
                  child: Container(
                    decoration: boxDecoration(g.wstrGameBColor, 30),
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.edit,color: Colors.white,size: 15,),
                        gapWC(5),
                        tcn('Update', Colors.white, 15)
                      ],
                    ),
                  ),
                )),
                gapWC(10),
                Bounce(
                  onPressed: (){
                    Navigator.pop(context);
                  },
                  duration: const Duration(milliseconds: 110),
                  child: Container(
                    decoration: boxBaseDecoration(greyLight, 30),
                    padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 15),
                    child: Row(
                      children: [
                        const Icon(Icons.close,color: Colors.black,size: 15,),
                        gapWC(5),
                        tcn('Cancel', Colors.black, 15)
                      ],
                    ),
                  ),
                ),
                gapWC(10),
              ],
            )
          ],
        ),
      ),
    );
  }
  //=======================================================WIDGET

    Widget wPayCard(mode,text){
      return Flexible(
        child: Bounce(
          onPressed: (){
            if(mounted){
              setState(() {
                frPayMode = mode;
              });
            }
          },
          duration:const Duration(milliseconds: 110),
          child: Container(
            padding: const EdgeInsets.all(5),
            decoration:frPayMode == mode? boxDecoration(Colors.white, 30): boxBaseDecoration(greyLight, 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                mode == "REC"?
                const Icon(Icons.arrow_upward_rounded,color: Colors.green,size: 15,):
                const Icon(Icons.arrow_downward_sharp,color: Colors.red,size: 15,),
                gapWC(5),
                tcn( text,mode == "REC"? Colors.green:Colors.red, 15)
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
          decoration: boxBaseDecoration(greyLight, 0),
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
              tcn(mode,fSelectedUserMode == mode? Colors.black: Colors.grey, 15)
            ],
          ),
        ),
      ));
    }

  //=======================================================PAGE FN


  fnGetPageData(){
    fnSetRoleWise();
  }

  fnSearchCallBack(rolecode,usercd){
    if(mounted){
      setState(() {
        if(fSelectedUserCode != usercd){
        }
        fSelectedUserCode = usercd;
      });
      apiCheckOutstanding();
      // if(rolecode == "Agent"){
      //   apiGetDetails();
      // }
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

  //=======================================================API CALL

  apiCheckOutstanding(){
    futureForm =  ApiCall().apiPayoutStandingReport(g.wstrCompany, fSelectedUserCode);
    futureForm.then((value) => apiCheckOutstandingRes(value));
  }
  apiCheckOutstandingRes(value){
    if(mounted){
      dprint(value);
      if(g.fnValCheck(value)){
        setState(() {
         try{
           frOutStanding = g.mfnDbl(value["OUTSTANDING"][0]["OUTSTANDING"]);
         }catch(e){
           dprint(e);
         }
        });
      }
      //{OUTSTANDING: [{TOT_AMT: 2673.0, PAID_AMT: 0.0, REC_AMT: 0.0, TOT_PAYMENT: 0.0, OUTSTANDING: 2673.0, TXN_USER: ADM2, TXN_TO_USER: 2SA}]}
    }
  }

  apiPaymentSave(){

    if(fSelectedUserCode.toString().isEmpty){
      errorMsg(context, "Select To User");
      return;
    }

    if(g.mfnDbl(txtAmount.text) <= 0 ){
      errorMsg(context, "Enter valid amount");
      return;
    }

    futureForm = apiCall.apiSavePayment(g.wstrCompany, wstrPageMode, "", "", g.wstrUserCd, fSelectedUserCode, g.mfnDbl(txtAmount.text), txtRemarks.text, frPayMode);
    futureForm.then((value) => apiPaymentSaveRes(value));

  }

  apiPaymentSaveRes(value){
    if(mounted){
      if(g.fnValCheck(value)){
        //[{STATUS: 1, MSG: ADDED}]
        var sts = (value[0]["STATUS"]??"").toString();
        var msg = (value[0]["MSG"]??"").toString();
        if(sts == "1"){
          Navigator.pop(context);
          successMsg(context, "Success");
        }else{
          errorMsg(context, msg.toString());
        }
      }else{
        errorMsg(context, "Please try again");
      }
    }
  }


}
