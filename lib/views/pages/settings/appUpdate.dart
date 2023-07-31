
import 'package:flutter/material.dart';
import 'package:ltr/controller/global/globalValues.dart';
import 'package:ltr/views/components/common/common.dart';

class AppUpdate extends StatefulWidget {
  const AppUpdate({Key? key}) : super(key: key);

  @override
  _AppUpdateState createState() => _AppUpdateState();
}

class _AppUpdateState extends State<AppUpdate> {


  //Global
  var g = Global();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
            Row(),
            tcn('APP VERSION V1.0', Colors.black, 10),
            gapHC(10),
            Container(
              decoration: boxDecoration(g.wstrGameColor , 30),
              padding: EdgeInsets.symmetric(vertical: 8,horizontal: 30),
              child: Column(
                children: [
                  tcn('Update', Colors.white, 15)
                ],
              ),
            )
        ],
      ),
    );
  }
}
