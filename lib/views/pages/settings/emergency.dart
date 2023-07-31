
import 'package:flutter/material.dart';
import 'package:ltr/controller/global/globalValues.dart';
import 'package:ltr/views/components/common/common.dart';
import 'package:ltr/views/styles/colors.dart';

class EmergencySettings extends StatefulWidget {
  const EmergencySettings({Key? key}) : super(key: key);

  @override
  State<EmergencySettings> createState() => _EmergencyState();
}

class _EmergencyState extends State<EmergencySettings> {

  //Global
  var g = Global();

  //Page Variable
  var blEdit = false;


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
                  tcn("Emergency", Colors.white, 20)
                ],
              ),
            ),
            gapHC(10),
            GestureDetector(
              onTap: (){
                if(mounted){
                  setState(() {
                    blEdit = !blEdit;
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
                        decoration: blEdit?boxDecoration( bgColorDark, 30):boxOutlineCustom1(Colors.white, 30, Colors.black, 1.0),
                        child: const Icon(Icons.done,color: Colors.white,size: 13,),
                      ),
                    ),
                    gapWC(10),
                    tcn('Editable',blEdit? Colors.black: Colors.black, 15)
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                decoration: boxDecoration(Colors.white, 10),
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    wBlockCard("Block Sales"),
                    gapHC(10),
                    wBlockCard("Block Report"),
                    gapHC(10),
                    wBlockCard("Block App"),
                    gapHC(10),
                    wBlockCard("Block Download"),
                    gapHC(10),
                    wBlockCard("Block Result"),

                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  //================================WIDGET
    Widget wBlockCard(text){
        return Container(
          padding: EdgeInsets.all(10),
          decoration: boxBaseDecoration(greyLight, 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.block,color: blEdit? Colors.red:Colors.grey,size: 15,),
                      gapWC(10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          tc(text,blEdit?  Colors.black:Colors.grey, 15),
                          tc("OPEN", Colors.green , 10),
                        ],
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 20),
                    decoration: boxDecoration(blEdit?Colors.redAccent:Colors.redAccent.withOpacity(0.5), 30),
                    child: Center(
                      child: tcn('BLOCK', Colors.white , 15),
                    ),
                  )
                ],
              ),

            ],
          ),
        );
    }
  //================================PAGE FN
  //================================API CALL
}
