

import 'package:flutter/material.dart';
import 'package:ltr/controller/global/globalValues.dart';
import 'package:ltr/views/components/common/common.dart';
import 'package:ltr/views/styles/colors.dart';

class Results extends StatefulWidget {
  const Results({Key? key}) : super(key: key);

  @override
  State<Results> createState() => _ResultsState();
}

class _ResultsState extends State<Results> {
  
  //Global
  var g =  Global();
  
  //Page Variable 
  var today = "";
  
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    today = setDate(15, DateTime.now());
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                      tcn("Results", Colors.white, 20)
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 5),
                    decoration: boxDecoration(Colors.white, 30),
                    child: Row(
                      children: [
                          tcn('Share', grey, 15),
                          gapWC(5),
                          const Icon(Icons.share_outlined,color: grey,size: 15,)
                      ],
                    ),
                  )
                ],
              ),
            ),
            gapHC(10),
            Row(
              children: [
                gapWC(10),
                tcn('Last published date $today', grey, 10),
              ],
            ),
            Container(
              margin: EdgeInsets.all(5),
              padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
              decoration: boxDecoration(Colors.white, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.calendar_month,color: grey,size: 18,),
                      gapWC(5),
                      tcn('Date', grey, 18),
                    ],
                  ),
                  tcn(today.toString(), Colors.black, 15)
                ],
              ),
            ),
            Expanded(
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Column(children: [
                    wResultCard("1","255",Colors.amber.withOpacity(0.5)),
                    wResultCard("2","625",Colors.red.withOpacity(0.5)),
                    wResultCard("3","344",Colors.green.withOpacity(0.5)),
                    wResultCard("4","546",Colors.orange.withOpacity(0.5)),
                    wResultCard("5","567",Colors.blue.withOpacity(0.5)),
                  ],),
                )
            ),
            Container(
              margin: EdgeInsets.all(10),
              padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
              decoration: boxDecoration(Colors.redAccent, 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  tcn('Live Result', Colors.white, 18),
                  gapWC(5),
                  const Icon(Icons.live_tv_outlined,color: Colors.white,size: 18,)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  //=================================================WIDGET
    Widget wResultCard(pos,num,color){
      return Container(
        decoration: boxBaseDecoration(color , 5),
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            tcn(pos, Colors.black, 15),
            gapWC(10),
            tcn(':', Colors.black, 15),
            gapWC(10),
            tc(num, Colors.black, 15)
          ],
        ),
      );
    }
  //=================================================PAGE FN
  //=================================================API CALL
}
