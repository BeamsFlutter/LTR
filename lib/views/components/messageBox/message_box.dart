

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:ltr/views/components/common/common.dart';
import 'package:ltr/views/styles/colors.dart';

class MessageBox extends StatefulWidget {
  final String msg;
  final String type;
  final String mode;
  final IconData ? icon;
  const MessageBox({Key? key, required this.msg, required this.type, required this.mode, this.icon}) : super(key: key);

  @override
  State<MessageBox> createState() => _MessageBoxState();
}

class _MessageBoxState extends State<MessageBox> {

  @override
  void initState() {
    // TODO: implement initState
    fnTimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 300,
        height: 200,
        decoration: boxDecoration(Colors.white, 30),

        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(5),
              decoration: boxBaseDecorationC(widget.mode == "S"? Colors.greenAccent:widget.mode == "E"? Colors.redAccent: widget.mode == "W"? Colors.amber : widget.mode == "I"? bgColorDark : widget.mode == "C"? bgColorDark :subColor, 30,30,0,0),
             height: 35,
             child: Column(
               children: [
                 Row(),
                 widget.type != "CLOSE"?
                 Row(
                   mainAxisAlignment: MainAxisAlignment.end,
                   children:  [
                     GestureDetector(
                       onTap: (){
                         Navigator.pop(context);
                       },
                       child: const Icon(Icons.cancel_outlined,size: 20,color: Colors.white,),
                     ),
                     gapWC(10),
                   ],
                 ):gapHC(5),
               ],
             ),
            ),
            gapHC(5),
            Expanded(child: Padding(
              padding: const EdgeInsets.all(5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(),
                  Container(
                    padding: const EdgeInsets.all(5),
                    decoration: boxDecoration(
                        widget.mode == "S"? Colors.greenAccent:widget.mode == "E"? Colors.redAccent: widget.mode == "W"? Colors.amber : widget.mode == "I"? bgColorDark : widget.mode == "C"? bgColorDark :subColor, 50),
                    child:  Icon(widget.mode == "S"? Icons.done_all_rounded:widget.mode == "E"? Icons.error: widget.mode == "W"? Icons.warning_amber_outlined : widget.mode == "I"? Icons.info_outline : widget.mode == "C"? widget.icon :Icons.message,color:widget.mode == "W"?  Colors.black: Colors.white,),
                  ),
                  gapHC(10),
                  tcn(widget.msg.toString(), Colors.black, 15)
                ],
              ),
            ))
          ],
        )

    );
  }
  //========================================PAGEFN

  fnTimer(){
    var duration = const Duration(seconds: 2);
    if(widget.type == "CLOSE"){
      return Timer(duration, route);
    }

  }
  route() async{
    if(mounted){
      Navigator.pop(context);
    }
  }
}
