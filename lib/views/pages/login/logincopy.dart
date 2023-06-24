

import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:get/get.dart';
import 'package:ltr/controller/global/globalValues.dart';
import 'package:ltr/services/apiController.dart';
import 'package:ltr/views/components/common/common.dart';
import 'package:ltr/views/pages/home/homepage.dart';
import 'package:ltr/views/styles/colors.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {


  //Global
  var g = Global();
  var apiCall = ApiCall();
  late Future<dynamic> futureForm;
  final loginFormKey = GlobalKey<FormState>();

  //Page Variable
  var passWordView = true;
  var lstrErrorMsg = "";
  var loginsts = true;
  var blRemember =  false;

  //Controller
  var txtUserName  = TextEditingController();
  var fnUserName =  FocusNode();
  var txtPassword  = TextEditingController();
  var fnPassword =  FocusNode();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: MediaQuery.of(context).padding,
        padding: EdgeInsets.all(30),
        decoration: boxBaseDecoration(Colors.white, 0),
        child: Form(
          key: loginFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              gapHC(60),
              tc('Calculator', Colors.black, 25.0),
              gapHC(5),
              
              TextFormField(
              controller: txtPassword,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
              decoration: InputDecoration(
                focusColor: Colors.white,
                prefixIcon: const Icon(
                  Icons.person_outline_rounded,
                  color: bgColorDark,
                  size: 18,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                  const BorderSide(color: bgColorDark, width: 1.0),
                  borderRadius: BorderRadius.circular(30.0),
                ),
                fillColor: Colors.grey,
                hintText: "Username",
                hintStyle: const TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                ),
                labelText: 'Username',
                labelStyle: const TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                ),
              ),
            ),
              Container(
                height: 40,
                padding: const EdgeInsets.symmetric(horizontal: 15),
                decoration: boxOutlineCustom1(Colors.white, 10, Colors.grey, 0.5),
                child: TextFormField(
                  controller: txtUserName,
                  focusNode: fnUserName,
                  decoration: const InputDecoration(
                    hintText: 'Username',
                    border: InputBorder.none,
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Please fill';
                    }
                    return null;

                  },
                ),
              ),
              gapHC(10),
              tcn('Password', Colors.black, 10.0),
              gapHC(5),
              Container(
                height: 40,
                padding: const EdgeInsets.symmetric(horizontal: 15),
                decoration: boxOutlineCustom1(Colors.white, 10, Colors.grey, 0.5),
                child: TextFormField(
                  controller: txtPassword,
                  obscureText: passWordView,
                  keyboardType: TextInputType.visiblePassword,
                  decoration:  InputDecoration(
                      hintText: 'Password',
                      border: InputBorder.none,
                      suffixIcon: InkWell(
                        onTap: (){
                          setState(() {
                            passWordView =  passWordView? false:true;
                          });
                        },
                        child: passWordView? const Icon(Icons.lock, color: Colors.grey,):const Icon(Icons.lock_open, color: Colors.grey,),
                      )
                  ),

                ),
              ),
              gapHC(20),
              Bounce(
                duration: const  Duration(milliseconds: 110),
                onPressed: (){
                  fnLogin();
                },
                child: Container(
                  decoration: boxDecoration(bgColorDark, 30),
                  padding: const EdgeInsets.all(10),
                  child: Column(

                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          tcn('Log In', Colors.white, 15),
                          gapWC(5),
                          const Icon(Icons.arrow_forward_sharp,color: Colors.white,size: 15,)
                        ],
                      ),

                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //==================================WIDGET

  //==================================PAGE FN

    fnLogin(){
      //Get.to(HomePage());
      if (loginFormKey.currentState!.validate()) {
         apiLogin();
      }
    }

  //==================================API CALL


    apiLogin(){
      futureForm =  apiCall.apiLogin(g.wstrCompany, txtUserName.text, txtPassword.text);
      futureForm.then((value) => apiLoginRes(value));
    }
    apiLoginRes(value){

    }

}
