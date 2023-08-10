
import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:ltr/controller/global/globalValues.dart';
import 'package:ltr/services/apiController.dart';
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
  var apiCall  = ApiCall();
  late Future<dynamic> futureForm;

  //Page Variable
  var blEdit = false;
  var fBlockList  = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fnGetPageData();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
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
                    wBlockCard("Block Sales","SALE"),
                    gapHC(10),
                    wBlockCard("Block Report","REPORT"),
                    gapHC(10),
                    wBlockCard("Block App","APP"),
                    gapHC(10),
                    wBlockCard("Block Download","DOWNLOAD"),
                    gapHC(10),
                    wBlockCard("Block Result","RESULT"),

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
    Widget wBlockCard(text,mode){
        var blockList =  fBlockList.where((element) => element["MODE"] == mode).toList();
        var blockSts =  "N";
        if(blockList.isNotEmpty){
          blockSts = (blockList[0]["BLOCK_YN"]??"");
        }
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
                          tcn(blockSts == "Y"?"BLOCKED":"OPEN",blockSts == "Y"?Colors.red: Colors.green , 10),
                        ],
                      ),
                    ],
                  ),
                  Bounce(
                    onPressed: (){
                      if(blEdit){
                        apiBlockUnBlock(mode,blockSts == "Y"?"DELETE":"ADD");
                      }
                    },
                    duration: const Duration(milliseconds: 110),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 20),
                      decoration: blockSts == "Y"? boxDecoration(blEdit?Colors.blueAccent:Colors.blue.withOpacity(0.5),30): boxDecoration(blEdit?Colors.redAccent:Colors.redAccent.withOpacity(0.5), 30),
                      child: Center(
                        child: tcn( blockSts == "Y"?'UNBLOCK':"BLOCK", Colors.white , 15),
                      ),
                    ),
                  )
                ],
              ),

            ],
          ),
        );
    }
  //================================PAGE FN

  fnGetPageData(){
    if(mounted){
      apiCheckAppBlock(null);
    }
  }

  //================================API CALL

  apiBlockUnBlock(mode,blockMode){
    futureForm = apiCall.apiSaveAppBlock(null,mode,"",g.wstrUserCd,g.wstrCompany,"",blockMode);
    futureForm.then((value) => apiBlockUnBlockRes(value));
  }
  apiBlockUnBlockRes(value){
    if(mounted){
      if(g.fnValCheck(value)){
        // [{STATUS: 0, MSG: USER NOT FOUND}]
        var sts  =  value["STATUS"];
        var msg  =  value["MSG"];
        if(sts == "1"){
          successMsg(context, "Success!!");
          apiCheckAppBlock(null);
          blEdit =  false;
        }else{
          errorMsg(context, msg.toString());
        }
      }
    }
  }


  apiCheckAppBlock(mode){
    futureForm = apiCall.apiCheckAppBlock(g.wstrCompany, mode);
    futureForm.then((value) => apiCheckAppBlockRes(value));
  }
  apiCheckAppBlockRes(value){
    if(mounted){
      setState(() {
        dprint(value);
        fBlockList =  [];
        if(g.fnValCheck(value)){
          fBlockList = value??[];
        }
      });
    }
  }

}
