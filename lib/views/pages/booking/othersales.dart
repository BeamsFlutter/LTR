
import 'package:flutter/material.dart';
import 'package:ltr/views/components/common/common.dart';

class OtherSales extends StatefulWidget {
  const OtherSales({Key? key}) : super(key: key);

  @override
  State<OtherSales> createState() => _OtherSalesState();
}

class _OtherSalesState extends State<OtherSales> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
            Row(),
            tcn('UPDATE SOON', Colors.black , 15)
        ],
      ),
    );
  }
}
