
import 'package:flutter/material.dart';
import 'package:ltr/views/components/common/common.dart';

class PublishResult extends StatefulWidget {
  const PublishResult({Key? key}) : super(key: key);

  @override
  State<PublishResult> createState() => _PublishResultState();
}

class _PublishResultState extends State<PublishResult> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: boxBaseDecoration(Colors.white, 0),
        child: Column(
          children: [
            Row(),
          ],
        ),
      )
    );
  }
}
