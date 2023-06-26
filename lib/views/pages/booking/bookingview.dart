

import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:ltr/controller/global/globalValues.dart';
import 'package:ltr/services/apiController.dart';
import 'package:ltr/views/components/common/common.dart';
import 'package:ltr/views/styles/colors.dart';

class BookingView extends StatefulWidget {
  const BookingView({Key? key}) : super(key: key);

  @override
  State<BookingView> createState() => _BookingViewState();
}

class _BookingViewState extends State<BookingView> {

  //Global
  var g = Global();
  var apiCall =  ApiCall();
  late Future<dynamic> futureForm;


  //Page Variables
  var fBookingList  = [];

  //Controller
  var txtSearch  = TextEditingController();
  var pnSearch  = FocusNode();


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

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
        decoration: boxBaseDecoration(Colors.white, 0),
        child: Column(
          children: [
            Row(),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 13,horizontal: 10),
              decoration: boxBaseDecoration(g.wstrGameBColor, 0),
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
                  tcn("Bill Details", Colors.white, 20)
                ],
              ),
            ),
            gapHC(10),
            Container(
              height: 40.0,
              margin: const EdgeInsets.symmetric(horizontal: 10),
              padding:  const EdgeInsets.symmetric(horizontal: 10),
              decoration: boxBaseDecoration(greyLight , 30),
              child: TextFormField(
                controller: txtSearch,
                focusNode: pnSearch,
                decoration:  const InputDecoration(
                    hintText: 'Search',
                    hintStyle: TextStyle(fontSize: 15.0),
                    border: InputBorder.none,
                    suffixIcon: Icon(Icons.search,color: Colors.grey,size: 20.0,)
                ),
                onChanged: (value){
                  apiGetBooking();
                },
              ),
            ),
            gapHC(10),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: wUserList(),
                ),
              ),
            )

          ],
        ),
      )
    );
  }

  //=================================WIDGET

  List<Widget> wUserList(){
    List<Widget> rtnList = [];
    var srno = 1;
    for(var e in fBookingList){
      var docno =   (e["DOCNO"]??"").toString();
      var name =   (e["CUSTOMER_NAME"]??"").toString();
      var DOCDATE =   (e["DOCDATE"]??"").toString();
      var GAME_CODE =   (e["GAME_CODE"]??"").toString();
      var AGENT_CODE =   (e["AGENT_CODE"]??"").toString();
      var NET_AMT =   (e["NET_AMT"]??"").toString();
      var crDate  ="";
      try{
        crDate =  setDate(7, DateTime.parse(DOCDATE)).toString();
      }catch(e){
        dprint(e);
      }

      rtnList.add(Bounce(
        onPressed: (){

        },
        duration: const Duration(milliseconds: 110),
        child: Container(
          padding: EdgeInsets.all(10),
          decoration:  boxBaseDecoration( (srno%2 == 0)? Colors.white: Colors.blueGrey.withOpacity(0.2), 0),
          child: Row(
            children: [
              Expanded(child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(),
                  tc("$docno ($GAME_CODE)", Colors.black, 12),
                  Row(
                    children: [
                      const Icon(Icons.person_outline,color: Colors.black,size: 12,),
                      gapWC(5),
                      tcn("Customer : ${name.toString().toUpperCase()}", Colors.black, 12)
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(Icons.access_time,color: Colors.black,size: 12,),
                      gapWC(5),
                      tcn(crDate.toString().toUpperCase(), Colors.black, 12)
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(Icons.verified_user_outlined,color: Colors.black,size: 12,),
                      gapWC(5),
                      tcn("Agent : ${AGENT_CODE.toString().toUpperCase()}", Colors.black, 12)
                    ],
                  ),
                ],
              ),),
              tc(NET_AMT, Colors.red, 20)
            ],
          ),
        )
      ));
      srno = srno+1;
    }
    return rtnList;
  }

  //=================================PAGE FN

    fnGetPageData(){
      if(mounted){
        apiGetBooking();
      }
    }

  //=================================API CALL

  apiGetBooking(){
    futureForm = apiCall.apiGetBookingList(txtSearch.text, g.wstrCompany, g.wstrUserCd, g.wstrSelectedGame);
    futureForm.then((value) => apiGetBookingRes(value));
  }

  apiGetBookingRes(value){
    if(mounted){
      setState(() {
        fBookingList = [];
        if(g.fnValCheck(value)){
          fBookingList = value;
        }
      });
    }
  }

  
}
