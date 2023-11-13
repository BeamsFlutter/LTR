

import 'package:flutter/material.dart';
import 'package:ltr/controller/global/globalValues.dart';
import 'package:ltr/services/apiController.dart';
import 'package:ltr/views/components/common/common.dart';


class ExtendBooking extends StatefulWidget {
  const ExtendBooking({Key? key}) : super(key: key);

  @override
  State<ExtendBooking> createState() => _ExtendBookingState();
}

class _ExtendBookingState extends State<ExtendBooking> {


  //Global
  var g = Global();
  var apiCall  = ApiCall();
  late Future<dynamic> futureForm;


  //Page Vraible
  var frGameList = [];

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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
              decoration: boxDecorationC(g.wstrGameColor, 0,0,0,0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      tcn(("Extend Booking").toString(), Colors.white, 20),
                    ],
                  ),
                ],
              ),
            ),
            gapHC(5),
            const Divider(),
            tcn(' > Select Extend Game', Colors.black, 13),
            const Divider(),
          ],
        ),
      ),
    );
  }
  //===============================WIDGET

  //===============================PAGE FN

  fnGetPageData(){
    apiGetGameList();
  }

  //===============================API CALL
  apiGetGameList(){
    //api for get user wise game list
    futureForm = apiCall.apiGetUserGames(g.wstrCompany, g.wstrUserCd, "");
    futureForm.then((value) => apiGetGameListRes(value));
  }
  apiGetGameListRes(value){
    if(mounted){
      setState(() {
        frGameList = [];
        if(g.fnValCheck(value)){
          frGameList = value;
        }
      });
    }
  }
}
