

import 'package:flutter/material.dart';
import 'package:ltr/controller/global/globalValues.dart';
import 'package:ltr/views/components/common/common.dart';
import 'package:ltr/views/styles/colors.dart';

class ReportDetails extends StatefulWidget {
  final String reportName;
  const ReportDetails({Key? key, required this.reportName}) : super(key: key);

  @override
  State<ReportDetails> createState() => _ReportsState();
}

class _ReportsState extends State<ReportDetails> {

  //Global
  var g = Global();

  //Page Variable
  var reportList = [];

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
                      //decoration: boxBaseDecoration(greyLight,10),
                      padding: const EdgeInsets.all(5),
                      child: const Icon(Icons.arrow_back_ios_rounded,color: Colors.white,size: 20,),
                    ),
                  ),
                  gapWC(5),
                  tcn(widget.reportName, Colors.white, 20)
                ],
              ),
            ),
            gapHC(15),
            Expanded(child: Container(
              padding: const EdgeInsets.all(10),
              child: Column(
                children:[],
              ),
            ))
          ],
        ),
      ),
    );
  }

  //===============================WIDGET



  //===============================PAGE FN

  fnGetPageData(){

  }

//===============================API CALL
}
