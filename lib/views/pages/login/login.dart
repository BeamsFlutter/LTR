

import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:get/get.dart';
import 'package:ltr/controller/global/globalValues.dart';
import 'package:ltr/services/apiController.dart';
import 'package:ltr/views/components/common/common.dart';
import 'package:ltr/views/pages/home/homepage.dart';
import 'package:ltr/views/styles/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

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

  var deviceName = "";
  var deviceId = "";
  var deviceIp = "";
  var deviceMode = "";


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initPlatformState(context);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: MediaQuery.of(context).padding,
        padding: const EdgeInsets.all(30),
        decoration: boxBaseDecoration(Colors.white, 0),
        child: Form(
          key: loginFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              gapHC(60),
              Row(
                children: [
                  GestureDetector(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Icon(Icons.navigate_before_rounded,size: 35,),
                  ),
                  gapWC(10),
                  tc('Login', Colors.black, 25.0),
                ],
              ),
              gapHC(5),
              tc(lstrErrorMsg, Colors.red, 12),
              gapHC(5),

              TextFormField(
                controller: txtUserName,
                style: const TextStyle(
                  fontSize: 15,
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
                    borderRadius: BorderRadius.circular(30.0),
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
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter username';
                  }
                  return null;
                },

              ),
              gapHC(15),
              TextFormField(
                controller: txtPassword,
                style: const TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
                obscureText: true,
                decoration: InputDecoration(
                  focusColor: Colors.white,
                  prefixIcon: const Icon(
                    Icons.key,
                    color: bgColorDark,
                    size: 18,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                    const BorderSide(color: bgColorDark, width: 1.0),
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  fillColor: Colors.grey,
                  hintText: "Password",
                  hintStyle: const TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                  labelText: 'Password',
                  labelStyle: const TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter password';
                  }
                  return null;
                },
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
   fnLoginDone(data) async{
     final SharedPreferences prefs = await _prefs;
    try{
      var now = DateTime.now();
      var lstrLoginDate = setDate(9,now);

      g.wstrToken =  g.mfnTxt(data["TOKEN"]);
      g.wstrLoginDate = lstrLoginDate;
      g.wstrUserCd = g.mfnTxt(data["USERCD"]);
      g.wstrUserName = g.mfnTxt(data["USER_DESCP"]);
      g.wstrUserRole = g.mfnTxt(data["ROLE_CODE"]);
      g.wstrUserRoleDescp = g.mfnTxt(data["ROLE_DESCP"]);
      g.wstrSysTime =  DateTime.parse(data["SYS_DATE"]);
      g.wstrCurrTime =  DateTime.now();

      g.wstrThemeUrl = g.mfnTxt(data["THEME"]);
      prefs.setString('wstrThemeUrl', g.mfnTxt(data["THEME"]));

      dprint(g.wstrSysTime.toString());

      fnGoHome();

    }catch(e){
      errorMsg(context, "Login Failed!");
      dprint(e);
    }

  }
  fnGoHome(){

    Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context) =>  const HomePage()
    ));
  }

  //==================================API CALL


    apiLogin(){
      futureForm =  apiCall.apiLogin(g.wstrCompany, txtUserName.text, txtPassword.text);
      futureForm.then((value) => apiLoginRes(value));
    }
    apiLoginRes(value){
      if(g.fnValCheck(value)){
        var sts  =  value[0]["STATUS"];
        var msg  =  value[0]["MSG"]??"";
        if(sts == "1"){
          var data =  value[0];
          if(g.fnValCheck(data)){
            fnLoginDone(data);
          }
        }

        if(mounted){
          setState((){
            lstrErrorMsg = msg;
          });
        }

      }else{
        if(mounted){
          setState((){
            lstrErrorMsg = "Please try again";
          });
        }
      }
    }


  //========================================SYSTEM INFO
  Future<void> initPlatformState(context) async {

    var deviceData = <String, dynamic>{};
    try {
      if (kIsWeb) {
        _readWebBrowserInfo(await deviceInfoPlugin.webBrowserInfo);

      } else {
        if (Platform.isAndroid) {
          _readAndroidBuildData(await deviceInfoPlugin.androidInfo);
        } else if (Platform.isIOS) {
          _readIosDeviceInfo(await deviceInfoPlugin.iosInfo);
        } else if (Platform.isLinux) {
          _readLinuxDeviceInfo(await deviceInfoPlugin.linuxInfo);
        } else if (Platform.isMacOS) {
          _readMacOsDeviceInfo(await deviceInfoPlugin.macOsInfo);
        } else if (Platform.isWindows) {
          _readWindowsDeviceInfo(await deviceInfoPlugin.windowsInfo);
        }
      }
    } on PlatformException {
      deviceData = <String, dynamic>{
        'Error:': 'Failed to get platform version.'
      };
    }

    g.wstrDeviceName = deviceName;
    g.wstrDeivceId =   deviceId;
    g.wstrDeviceIP =   deviceIp;


  }
  _readAndroidBuildData(AndroidDeviceInfo build) {

    deviceMode = '';
    deviceId = build.id??'';
    deviceName =  build.model??'';

  }
  _readIosDeviceInfo(IosDeviceInfo data) {

    deviceMode = '';
    deviceId = data.name??'';
    deviceName =  data.systemName??'';

  }
  _readLinuxDeviceInfo(LinuxDeviceInfo data) {

  }
  _readWebBrowserInfo(WebBrowserInfo data)  {
    deviceMode = 'W';
    deviceId = describeEnum(data.browserName);
    deviceName =  describeEnum(data.browserName);
  }
  _readMacOsDeviceInfo(MacOsDeviceInfo data) {
    deviceMode = '';
    deviceId = data.systemGUID??'';
    deviceName =  data.computerName;
  }
  _readWindowsDeviceInfo(WindowsDeviceInfo data) {
    deviceMode = '';
    deviceId = data.computerName;
    deviceName =  data.computerName;
  }


}
