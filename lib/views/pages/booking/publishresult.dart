
import 'package:flutter/material.dart';
import 'package:ltr/controller/global/globalValues.dart';
import 'package:ltr/services/apiController.dart';
import 'package:ltr/views/components/common/common.dart';

class PublishResult extends StatefulWidget {
  const PublishResult({Key? key}) : super(key: key);

  @override
  State<PublishResult> createState() => _PublishResultState();
}

class _PublishResultState extends State<PublishResult> {

  //Global
  var g = Global();
  var apiCall =  ApiCall();
  
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
                  tcn("Publish Result", Colors.white, 20)
                ],
              ),
            ),
            gapHC(5),
            Container(
              margin: const EdgeInsets.all(5),
              padding: const EdgeInsets.all(5),
              decoration: boxDecoration(Colors.white, 10),
              child: Column(
                children: [
                  Row(

                  ),
                ],
              ),
            )
          ],
        ),
      )
    );
  }
}
