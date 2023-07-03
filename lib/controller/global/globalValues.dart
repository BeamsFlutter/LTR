

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ltr/views/components/common/common.dart';

class Global {

  static final Global _instance = Global._internal();

  // passes the instantiation to the _instance object
  factory Global() => _instance;

  //initialize variables in here
  Global._internal() {
    _wstrToken = '';
    _wstrCompany = '';
    _wstrUserCd = '';
    _wstrUserName = '';
    _wstrIp = '';
    _wstrVersionName = '';
    _wstrLoginDate = "";
    _wstrLoginYn = "";
    _wstrBaseUrl = "";
    _wstrHeadFont = 15.0;
    _wstrSubFont = 12.0;
    _wstrIconSize = 18.0;
    _wstrSubIconSize = 15.0;
    _wstrCompanyName = '';
    _wstrUserRole = '';
    _wstrUserRoleDescp = '';
    _wstrSelectedGame = "";
    _wstrSelectedGameName = "";
    _wstrGameColor = Colors.white;
    _wstrGameBColor = Colors.white;
    _wstrGameTColor = Colors.white;
    _wstrGameOTColor = Colors.white;
    _wstrSysTime  =  DateTime.now();
    _wstrCurrTime  =  DateTime.now();
    _wstrSGameDocNo = "";
    _wstrSGameDoctype = "";
    _wstrSGameStart = "";
    _wstrSGameEnd = "";
    _wstrDeviceName ='';
    _wstrDeivceId ='';
    _wstrSGameLink = "";
    _wstrSGameEdit = "";
  }
  var _wstrToken  = '';
  var _wstrCompany = '';
  var _wstrCompanyName = '';


  var _wstrUserCd = '';
  var _wstrUserName = '';
  var _wstrUserRole = '';
  var _wstrUserRoleDescp = '';

  var _wstrIp = '';
  var _wstrDeviceIP;
  var _wstrVersionName = '';
  var _wstrSysTime  =  DateTime.now();
  var _wstrCurrTime  =  DateTime.now();
  var _wstrDeviceName ='';
  var _wstrDeivceId ='';

  var _wstrLoginDate = "";
  var _wstrLoginYn = "";
  var _wstrBaseUrl = "";


  //FONT_SIZE
  var _wstrHeadFont = 15.0;
  var _wstrSubFont = 12.0;
  var _wstrIconSize = 18.0;
  var _wstrSubIconSize = 13.0;


  //Game Selection
  var _wstrSelectedGame = "";
  var _wstrSelectedGameName = "";
  var _wstrSGameDocNo = "";
  var _wstrSGameDoctype = "";
  var _wstrSGameStart = "";
  var _wstrSGameEnd = "";
  var _wstrSGameEdit = "";
  var _wstrSGameLink = "";

  var _wstrGameColor = Colors.white;
  var _wstrGameBColor = Colors.white;
  var _wstrGameTColor = Colors.white;
  var _wstrGameOTColor = Colors.white;

  get wstrSGameEdit => _wstrSGameEdit;

  set wstrSGameEdit(value) {
    _wstrSGameEdit = value;
  }

  get wstrSGameLink => _wstrSGameLink;

  set wstrSGameLink(value) {
    _wstrSGameLink = value;
  }

  get wstrSysTime => _wstrSysTime;

  set wstrSysTime(value) {
    _wstrSysTime = value;
  }

  get wstrGameBColor => _wstrGameBColor;

  set wstrGameBColor(value) {
    _wstrGameBColor = value;
  }

  get wstrGameColor => _wstrGameColor;

  set wstrGameColor(value) {
    _wstrGameColor = value;
  }

  get wstrSelectedGameName => _wstrSelectedGameName;

  set wstrSelectedGameName(value) {
    _wstrSelectedGameName = value;
  }

  get wstrSelectedGame => _wstrSelectedGame;

  get wstrLoginYn => _wstrLoginYn;

  set wstrLoginYn(value) {
    _wstrLoginYn = value;
  }

  set wstrSelectedGame(value) {
    _wstrSelectedGame = value;
  }

  get wstrUserRole => _wstrUserRole;

  set wstrUserRole(value) {
    _wstrUserRole = value;
  }

  get wstrCompanyName => _wstrCompanyName;

  set wstrCompanyName(value) {
    _wstrCompanyName = value;
  }

  get wstrSubIconSize => _wstrSubIconSize;

  set wstrSubIconSize(value) {
    _wstrSubIconSize = value;
  }

  get wstrHeadFont => _wstrHeadFont;

  set wstrHeadFont(value) {
    _wstrHeadFont = value;
  }

  get wstrBaseUrl => _wstrBaseUrl;

  set wstrBaseUrl(value) {
    _wstrBaseUrl = value;
  }

  get wstrLoginDate => _wstrLoginDate;

  set wstrLoginDate(value) {
    _wstrLoginDate = value;
  }



  get wstrVersionName => _wstrVersionName;

  set wstrVersionName(value) {
    _wstrVersionName = value;
  }


  get wstrDeviceIP => _wstrDeviceIP;

  set wstrDeviceIP(value) {
    _wstrDeviceIP = value;
  }

  get wstrIp => _wstrIp;

  set wstrIp(value) {
    _wstrIp = value;
  }

  get wstrToken => _wstrToken;

  set wstrToken(value) {
    _wstrToken = value;
  }

  set wstrUserName(value) {
    _wstrUserName = value;
  }

  set wstrUserCd(value) {
    _wstrUserCd = value;
  }



  set wstrCompany(value) {
    _wstrCompany = value;
  }

  get wstrCompany => _wstrCompany;



  get wstrUserCd => _wstrUserCd;

  get wstrUserName => _wstrUserName;




  get wstrSubFont => _wstrSubFont;

  set wstrSubFont(value) {
    _wstrSubFont = value;
  }

  get wstrIconSize => _wstrIconSize;

  set wstrIconSize(value) {
    _wstrIconSize = value;
  }

  get wstrSGameDocNo => _wstrSGameDocNo;

  set wstrSGameDocNo(value) {
    _wstrSGameDocNo = value;
  }

  get wstrCurrTime => _wstrCurrTime;

  set wstrCurrTime(value) {
    _wstrCurrTime = value;
  } //===============================================================global fn========================


  bool fnValCheck(value){
    try{
      if(value == null){
        return false;
      }else{
        if(value.length > 0){
          return true;
        }else{
          return false;
        }
      }
    }catch(e){
      dprint(e);
      return false;
    }
  }
  fnGrep(array,code,value){
    if(array == null){

    }else{
      if(array.length > 0){

      }else{
      }
    }
  }
  mfnDbl(dbl){
    var lstrDbl = 0.0;

    try {
      lstrDbl =  double.parse((dbl??'0.0').toString());
    }
    catch(e){
      lstrDbl= 0.00;
    }
    return lstrDbl;
  }
  mfnInt(dbl){
    var lstrInt = 0;
    try {
      lstrInt =  int.parse((dbl??'0.0').toString());
    }
    catch(e){
      lstrInt= 0;
    }
    return lstrInt;
  }
  mfnJson(arr){
    var tempArray;
    if(fnValCheck(arr)){
      String tempString = jsonEncode(arr);
      tempArray  =  jsonDecode(tempString);
    }
    return tempArray;
  }
  mfnCurr(amount){
    var lstrDbl = 0.0;

    try {
      lstrDbl =  double.parse((amount??'0.0').toString());
    }
    catch(e){
      lstrDbl= 0.00;
    }
    var amt = NumberFormat.simpleCurrency(name:"").format(lstrDbl);
    return amt;

  }

  get wstrUserRoleDescp => _wstrUserRoleDescp;

  set wstrUserRoleDescp(value) {
    _wstrUserRoleDescp = value;
  }

  mfnTxt(txt){
    return (txt??"").toString();
  }

  get wstrGameTColor => _wstrGameTColor;

  set wstrGameTColor(value) {
    _wstrGameTColor = value;
  }

  get wstrGameOTColor => _wstrGameOTColor;

  set wstrGameOTColor(value) {
    _wstrGameOTColor = value;
  }

  get wstrSGameDoctype => _wstrSGameDoctype;

  set wstrSGameDoctype(value) {
    _wstrSGameDoctype = value;
  }

  get wstrSGameStart => _wstrSGameStart;

  set wstrSGameStart(value) {
    _wstrSGameStart = value;
  }

  get wstrSGameEnd => _wstrSGameEnd;

  set wstrSGameEnd(value) {
    _wstrSGameEnd = value;
  }

  get wstrDeivceId => _wstrDeivceId;

  set wstrDeivceId(value) {
    _wstrDeivceId = value;
  }

  get wstrDeviceName => _wstrDeviceName;

  set wstrDeviceName(value) {
    _wstrDeviceName = value;
  }
}