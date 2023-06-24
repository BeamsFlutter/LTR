

import 'package:flutter/material.dart';
import 'package:ltr/views/components/common/common.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: boxBaseDecoration(Colors.black, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(),
            const Icon(Icons.add_location_alt_outlined ,color: Colors.white,size: 50,)
          ],
        ),
      ),
    );
  }
}
