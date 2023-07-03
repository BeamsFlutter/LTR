

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ltr/views/components/messageBox/message_box.dart';
import 'package:ltr/views/styles/colors.dart';
import '../common/common.dart';

class PageDialog{
  Future<void> show(context,child,headName) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        Size size = MediaQuery.of(context).size;
        return AlertDialog(
            backgroundColor: Colors.transparent,
            content: Container(
                width: size.width*0.5,
                height: size.height*0.63,
                decoration: boxDecoration(Colors.white, 10),
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        th(headName,Colors.black,13),
                        IconButton(onPressed: (){
                          Navigator.pop(context);
                        }, icon: Icon(Icons.highlight_remove_sharp,color: Colors.black,size: 30,))
                      ],
                    ),
                    gapHC(5),
                    Container(
                      height: size.height*0.5,
                      child: SingleChildScrollView(
                          child: Column(
                            children: [
                              child
                            ],
                          )
                      ),
                    )
                  ],
                )

            )
        );
      },
    );
  }
  Future<void> showNote(context,child,headName) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        Size size = MediaQuery.of(context).size;
        return AlertDialog(
            backgroundColor: Colors.transparent,
            content: Container(
                width: 400,
                height: size.height*0.6,
                decoration: boxDecoration(Colors.white, 10),
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        th(headName,Colors.black,13),
                        IconButton(onPressed: (){
                          Navigator.pop(context);
                        }, icon: const Icon(Icons.highlight_remove_sharp,color: Colors.black,size: 30,))
                      ],
                    ),
                    gapHC(5),
                    Expanded(
                      child: SingleChildScrollView(
                          child: Column(
                            children: [
                              child
                            ],
                          )
                      ),
                    )
                  ],
                )

            )
        );
      },
    );
  }
  Future<void> showPhoneLookup(context,child,headName) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        Size size = MediaQuery.of(context).size;
        return AlertDialog(
            backgroundColor: Colors.transparent,
            content: Container(
                width: size.height*0.9,
                height: size.height*0.7,
                decoration: boxDecoration(Colors.white, 10),
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        th(headName,Colors.black,13),
                        IconButton(onPressed: (){
                          Navigator.pop(context);
                        }, icon: const Icon(Icons.highlight_remove_sharp,color: Colors.black,size: 30,))
                      ],
                    ),
                    gapHC(5),
                    Expanded(
                      child: SingleChildScrollView(
                          child: Column(
                            children: [
                              child
                            ],
                          )
                      ),
                    )
                  ],
                )

            )
        );
      },
    );
  }
  Future<void> showShortNote(context,child,headName) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        Size size = MediaQuery.of(context).size;
        return AlertDialog(
            backgroundColor: Colors.transparent,
            content: Container(
                width: 400,
                height: 220,
                decoration: boxDecoration(Colors.white, 10),
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        th(headName,Colors.black,13),
                        IconButton(onPressed: (){
                          Navigator.pop(context);
                        }, icon: const Icon(Icons.highlight_remove_sharp,color: Colors.black,size: 30,))
                      ],
                    ),
                    gapHC(5),
                    Expanded(
                      child: SingleChildScrollView(
                          child: Column(
                            children: [
                              child
                            ],
                          )
                      ),
                    )
                  ],
                )

            )
        );
      },
    );
  }
  Future<void> showSysytemInfo(context,child,headName) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        Size size = MediaQuery.of(context).size;
        return AlertDialog(
            backgroundColor: Colors.transparent,
            content: Container(
                width: size.width*0.35,
                height: size.height*0.5,
                decoration: boxDecoration(Colors.white, 10),
                padding: const EdgeInsets.all(20),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          th(headName,Colors.black,13),
                          IconButton(onPressed: (){
                            Navigator.pop(context);
                          }, icon: const Icon(Icons.highlight_remove_sharp,color: Colors.black,size: 30,))
                        ],
                      ),
                      gapHC(5),
                      Container(
                        height: size.height*0.4,
                        child: SingleChildScrollView(
                            child: Column(
                              children: [
                                child
                              ],
                            )
                        ),
                      )
                    ],
                  ),
                )

            )
        );
      },
    );
  }

  Future<void> deleteDialog(context,fnDelete) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        Size size = MediaQuery.of(context).size;
        return AlertDialog(
            backgroundColor: Colors.transparent,
            content: Container(
                width: 300,
                height: 200,
                decoration: boxDecoration(Colors.white, 30),
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        th("Delete",Colors.black,13),
                        IconButton(onPressed: (){
                          Navigator.pop(context);
                        }, icon: const Icon(Icons.highlight_remove_sharp,color: Colors.black,size: 30,))
                      ],
                    ),
                    gapHC(5),
                    Container(
                      height: 100,
                      width: 300,
                      child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              tcn('Do you want to delete ?',Colors.black,12),
                              gapHC(20),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  GestureDetector(
                                    onTap: (){
                                      fnDelete();
                                    },
                                    child: Container(
                                      height: 40,
                                      width: 100,
                                      margin: const EdgeInsets.only(right: 5),
                                      decoration: boxDecoration(Colors.blueGrey, 30),
                                      child: Center(
                                        child: tc('Yes', Colors.white, 15),
                                      ),
                                    ),
                                  )
                                ],
                              )
                            ],
                          )
                      ),
                    )
                  ],
                )

            )
        );
      },
    );
  }
  Future<void> cDialog(context,sub,text,fnDelete) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        Size size = MediaQuery.of(context).size;
        return AlertDialog(
            backgroundColor: Colors.transparent,
            content: Container(
                width: 300,
                height: 200,
                decoration: boxDecoration(Colors.white, 30),
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        th(sub,Colors.black,13),
                        IconButton(onPressed: (){
                          Navigator.pop(context);
                        }, icon: const Icon(Icons.highlight_remove_sharp,color: Colors.black,size: 30,))
                      ],
                    ),
                    gapHC(5),
                    Container(
                      height: 100,
                      width: 300,
                      child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              tcn(text,Colors.black,12),
                              gapHC(20),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  GestureDetector(
                                    onTap: (){
                                      fnDelete();
                                    },
                                    child: Container(
                                      height: 40,
                                      width: 100,
                                      margin: const EdgeInsets.only(right: 5),
                                      decoration: boxDecoration(Colors.blueGrey, 30),
                                      child: Center(
                                        child: tc('Yes', Colors.white, 15),
                                      ),
                                    ),
                                  )
                                ],
                              )
                            ],
                          )
                      ),
                    )
                  ],
                )

            )
        );
      },
    );
  }
  Future<void> postDialog(context,fnDelete) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        Size size = MediaQuery.of(context).size;
        return AlertDialog(
            backgroundColor: Colors.transparent,
            content: Container(
                width: 300,
                height: 200,
                decoration: boxDecoration(Colors.white, 30),
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        th("Publish",Colors.black,13),
                        IconButton(onPressed: (){
                          Navigator.pop(context);
                        }, icon: const Icon(Icons.close,color: Colors.black,size: 30,))
                      ],
                    ),
                    gapHC(5),
                    Container(
                      height: 100,
                      width: 300,
                      child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              tcn('Do you want to publish ?',Colors.black,12),
                              gapHC(20),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  GestureDetector(
                                    onTap: (){
                                      fnDelete();
                                    },
                                    child: Container(
                                      height: 40,
                                      width: 100,
                                      margin: const EdgeInsets.only(right: 5),
                                      decoration: boxDecoration(Colors.blueGrey, 30),
                                      child: Center(
                                        child: tc('Yes', Colors.white, 15),
                                      ),
                                    ),
                                  )
                                ],
                              )
                            ],
                          )
                      ),
                    )
                  ],
                )

            )
        );
      },
    );
  }
  Future<void> unPostDialog(context,fnDelete) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        Size size = MediaQuery.of(context).size;
        return AlertDialog(
            backgroundColor: Colors.transparent,
            content: Container(
                width: 300,
                height: 200,
                decoration: boxDecoration(Colors.white, 30),
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        th("Un Publish",Colors.black,13),
                        IconButton(onPressed: (){
                          Navigator.pop(context);
                        }, icon: const Icon(Icons.close,color: Colors.black,size: 30,))
                      ],
                    ),
                    gapHC(5),
                    Container(
                      height: 100,
                      width: 300,
                      child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              tcn('Do you want to un publish ?',Colors.black,12),
                              gapHC(20),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  GestureDetector(
                                    onTap: (){
                                      fnDelete();
                                    },
                                    child: Container(
                                      height: 40,
                                      width: 100,
                                      margin: const EdgeInsets.only(right: 5),
                                      decoration: boxDecoration(Colors.blueGrey, 30),
                                      child: Center(
                                        child: tc('Yes', Colors.white, 15),
                                      ),
                                    ),
                                  )
                                ],
                              )
                            ],
                          )
                      ),
                    )
                  ],
                )

            )
        );
      },
    );
  }
  Future<void> cancelDialog(context,fnCancel) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        Size size = MediaQuery.of(context).size;
        return AlertDialog(
            backgroundColor: Colors.transparent,
            content: Container(
                width: 300,
                height: 200,
                decoration: boxDecoration(Colors.white, 10),
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        th('Cancel',Colors.black,12),
                        IconButton(onPressed: (){
                          Navigator.pop(context);
                        }, icon: const Icon(Icons.highlight_remove_sharp,color: Colors.black,size: 30,))
                      ],
                    ),
                    gapHC(5),

                    Container(
                      height: 100,
                      width: 300,
                      child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              th('Do you want to cancel ?',Colors.black,12),
                              gapHC(20),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  GestureDetector(
                                    onTap: (){
                                      fnCancel();
                                    },
                                    child: Container(
                                      height: 40,
                                      width: 60,
                                      margin: EdgeInsets.only(right: 5),
                                      decoration: boxDecoration(Colors.green, 10),
                                      child: Center(
                                        child: tc('Yes', Colors.white, 15),
                                      ),
                                    ),
                                  )
                                ],
                              )
                            ],
                          )
                      ),
                    )
                  ],
                )

            )
        );
      },
    );
  }
  Future<void> mailDialog(context,fnSend) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        Size size = MediaQuery.of(context).size;
        return AlertDialog(
            backgroundColor: Colors.transparent,
            content: Container(
                width: 300,
                height: 200,
                decoration: boxDecoration(Colors.white, 30),
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        th('Email',Colors.black,12),
                        IconButton(onPressed: (){
                          Navigator.pop(context);
                        }, icon: const Icon(Icons.highlight_remove_sharp,color: Colors.black,size: 30,))
                      ],
                    ),
                    gapHC(5),

                    Container(
                      height: 100,
                      width: 300,
                      child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              tcn('Send Mail ?',Colors.black,12),
                              gapHC(20),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  GestureDetector(
                                    onTap: (){
                                      fnSend();
                                    },
                                    child: Container(
                                      height: 40,
                                      width: 80,
                                      margin: EdgeInsets.only(right: 5),
                                      decoration: boxDecoration(Colors.green, 30),
                                      child: Center(
                                        child: tcn('Yes', Colors.white, 15),
                                      ),
                                    ),
                                  )
                                ],
                              )
                            ],
                          )
                      ),
                    )
                  ],
                )

            )
        );
      },
    );
  }
  Future<void> exitDialog(context,fnEnd) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        Size size = MediaQuery.of(context).size;
        return AlertDialog(
            backgroundColor: Colors.transparent,
            content: Container(
                width: 300,
                height: 180,
                decoration: boxDecoration(Colors.white, 30),
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        th('Close',Colors.black,14),
                        IconButton(onPressed: (){
                          Navigator.pop(context);
                        }, icon: const Icon(Icons.highlight_remove_sharp,color: Colors.black,size: 30,))
                      ],
                    ),
                    gapHC(5),
                    Expanded(
                      child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              tcn('Do you want to close ?',Colors.black,10),
                              gapHC(20),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  GestureDetector(
                                    onTap: (){
                                      Navigator.pop(context);
                                    },
                                    child: Container(
                                      height: 35,
                                      width: 80,
                                      margin: const EdgeInsets.only(right: 5),
                                      decoration: boxOutlineCustom1(Colors.white, 30, subColor, 1.0),
                                      child: Center(
                                        child: tcn('No', subColor, 15),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: (){
                                      fnEnd();
                                    },
                                    child: Container(
                                      height: 35,
                                      width: 80,
                                      margin: const EdgeInsets.only(right: 5),
                                      decoration: boxDecoration(subColor, 30),
                                      child: Center(
                                        child: tc('Yes', Colors.white, 15),
                                      ),
                                    ),
                                  ),

                                ],
                              )
                            ],
                          )
                      ),
                    )
                  ],
                )

            )
        );
      },
    );
  }

  Future<void> printDialog(context,fnPrint) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        Size size = MediaQuery.of(context).size;
        return AlertDialog(
            backgroundColor: Colors.transparent,
            content: Container(
                width: 300,
                height: 200,
                decoration: boxDecoration(Colors.white, 30),
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        tc('Print',Colors.black,15),
                        IconButton(onPressed: (){
                          Navigator.pop(context);
                        }, icon: const Icon(Icons.highlight_remove_sharp,color: Colors.black,size: 30,))
                      ],
                    ),
                    gapHC(5),

                    Container(
                      height: 100,
                      width: 300,
                      child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              th('Do you want to print ?',Colors.black,12),
                              gapHC(20),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  GestureDetector(
                                    onTap: (){
                                      Navigator.pop(context);
                                    },
                                    child: Container(
                                      height: 40,
                                      width: 60,
                                      margin: EdgeInsets.only(right: 5),
                                      decoration: boxDecoration(Colors.red, 10),
                                      child: Center(
                                        child: tc('No', Colors.white, 15),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: (){
                                      fnPrint();
                                    },
                                    child: Container(
                                      height: 40,
                                      width: 60,
                                      margin: EdgeInsets.only(right: 5),
                                      decoration: boxDecoration(Colors.green, 10),
                                      child: Center(
                                        child: tc('Yes', Colors.white, 15),
                                      ),
                                    ),
                                  ),

                                ],
                              )
                            ],
                          )
                      ),
                    )
                  ],
                )

            )
        );
      },
    );
  }
  Future<void> saveDialog(context,fnSave) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        Size size = MediaQuery.of(context).size;
        return AlertDialog(
            backgroundColor: Colors.transparent,
            content: Container(
                width: 300,
                height: 200,
                decoration: boxDecoration(Colors.white, 10),
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        th('Save',Colors.black,14),
                        IconButton(onPressed: (){
                          Navigator.pop(context);
                        }, icon: const Icon(Icons.highlight_remove_sharp,color: Colors.black,size: 30,))
                      ],
                    ),
                    gapHC(5),

                    Container(
                      height: 100,
                      width: 300,
                      child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              th('Do you want to save ?',Colors.black,12),
                              gapHC(20),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  GestureDetector(
                                    onTap: (){
                                      Navigator.pop(context);
                                    },
                                    child: Container(
                                      height: 40,
                                      width: 60,
                                      margin: EdgeInsets.only(right: 5),
                                      decoration: boxDecoration(Colors.red, 10),
                                      child: Center(
                                        child: tc('No', Colors.white, 15),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: (){
                                      fnSave();
                                    },
                                    child: Container(
                                      height: 40,
                                      width: 60,
                                      margin: const EdgeInsets.only(right: 5),
                                      decoration: boxDecoration(Colors.green, 10),
                                      child: Center(
                                        child: tc('Yes', Colors.white, 15),
                                      ),
                                    ),
                                  ),

                                ],
                              )
                            ],
                          )
                      ),
                    )
                  ],
                )

            )
        );
      },
    );
  }
  Future<void> endDialog(context,fnEnd) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        Size size = MediaQuery.of(context).size;
        return AlertDialog(
            backgroundColor: Colors.transparent,
            content: Container(
                width: 300,
                height: 200,
                decoration: boxDecoration(Colors.white, 30),
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        th('End Trip',Colors.black,14),
                        IconButton(onPressed: (){
                          Navigator.pop(context);
                        }, icon: const Icon(Icons.highlight_remove_sharp,color: Colors.black,size: 30,))
                      ],
                    ),
                    gapHC(5),

                    Container(
                      height: 100,
                      width: 300,
                      child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              tcn('Do you want to proceed ?',Colors.black,10),
                              gapHC(20),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  GestureDetector(
                                    onTap: (){
                                      Navigator.pop(context);
                                    },
                                    child: Container(
                                      height: 40,
                                      width: 60,
                                      margin: EdgeInsets.only(right: 5),
                                      decoration: boxDecoration(Colors.red, 10),
                                      child: Center(
                                        child: tc('No', Colors.white, 15),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: (){
                                      fnEnd("END");
                                    },
                                    child: Container(
                                      height: 40,
                                      width: 60,
                                      margin: const EdgeInsets.only(right: 5),
                                      decoration: boxDecoration(Colors.green, 10),
                                      child: Center(
                                        child: tc('Yes', Colors.white, 15),
                                      ),
                                    ),
                                  ),

                                ],
                              )
                            ],
                          )
                      ),
                    )
                  ],
                )

            )
        );
      },
    );
  }

  Future<void> showMessage(context,msg,type,mode,icon) async {

    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
            backgroundColor: Colors.transparent,
            content: icon == "" ? MessageBox(msg: msg,type: type,mode:mode):MessageBox(msg: msg,type: type,mode:mode,icon: icon,)
        );
      },
    );
  }

  fnShow() {
    Get.dialog(
      barrierDismissible: false, // user must tap button!
      barrierColor: Colors.transparent,
       const AlertDialog (
        elevation: 0,
        backgroundColor: Colors.transparent,
        content: CircleAvatar(
          backgroundColor: subColor,
          radius: 30,
          child: CupertinoActivityIndicator(
            color: Colors.white,
            animating: true,
            radius: 20,
          ),
        ),
      ),
    );
  }
  closeAlert(){
    Get.back();
  }

  Future<void> show_(context,child,headName) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        Size size = MediaQuery.of(context).size;
        return AlertDialog(
            backgroundColor: Colors.transparent,
            content: Container(
                height: 500,
                decoration: boxDecoration(Colors.white, 10),
                padding: EdgeInsets.all(5),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(left: 15.0,right: 15.0),
                      child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              child
                            ],
                          )
                      ),
                    )
                  ],
                )

            )
        );
      },
    );
  }


}