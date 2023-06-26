

import 'dart:convert';



import 'package:ltr/services/appExceptions.dart';
import 'package:ltr/services/baseController.dart';
import 'package:ltr/views/components/common/common.dart';

import 'apiManager.dart';

class ApiCall  with BaseController{

  //============================================LOGIN
  Future<dynamic> apiLogin(company,usercd,password) async{

    var request = jsonEncode(<dynamic, dynamic>{
      "COMPANY":company,
      "USERCD":usercd,
      "PWD":password
    });
    dprint('api/login');
    dprint(request);
    var response = await ApiManager().post('api/login',request).catchError((error){
      if (error is BadRequestException) {
      } else {
        handleError(error);
      }
    });
    dprint(response);
    if (response == null) return;

    return response;

  }

  //============================================LOOKUP
  Future<dynamic> LookupSearch(lstrTable,lstrColumn,lstrPage,lstrPageSize,lstrFilter) async {

    var request = jsonEncode(<dynamic, dynamic>{
      "lstrTable" : lstrTable,
      "lstrSearchColumn" :lstrColumn,
      "lstrPage" : lstrPage,
      "lstrLimit": lstrPageSize,
      "lstrFilter" : lstrFilter,
    });
    dprint('api/lookupSearch');
    dprint(request);

    var response = await ApiManager().post('api/lookupSearch',request).catchError((error){
      if (error is BadRequestException) {
        var apiError = json.decode(error.message!);
        //Fluttertoast.showToast(msg: apiError["reason"].toString());
      } else {
        handleError(error);
      }
    });
    if (response == null) return;
    dprint(response);
    return response;

  }
  Future<dynamic> LookupValidate(lstrTable,lstrFilter) async {

    var request = jsonEncode(<dynamic, dynamic>{
      "lstrTable" : lstrTable,
      "lstrFilter" : lstrFilter
    });
    dprint('api/lookupValidate');
    dprint(request);
    var response = await ApiManager().post('api/lookupValidate',request).catchError((error){
      if (error is BadRequestException) {
        var apiError = json.decode(error.message!);
        //Fluttertoast.showToast(msg: apiError["reason"].toString());
      } else {
        handleError(error);
      }
    });
    if (response == null) return;
    dprint(response);
    return response;

  }
  Future<dynamic> apiLookupValidate(lstrTable,key,value) async {
    var lstrFilter =[{'Column': key, 'Operator': '=', 'Value': value, 'JoinType': 'AND'}];
    var request = jsonEncode(<dynamic, dynamic>{
      "lstrTable" : lstrTable,
      "lstrFilter" : lstrFilter
    });
    dprint('api/lookupValidate');
    dprint(request);
    var response = await ApiManager().post('api/lookupValidate',request).catchError((error){
      if (error is BadRequestException) {
        // var apiError = json.decode(error.message!);
        //Fluttertoast.showToast(msg: apiError["reason"].toString());
      } else {
        handleError(error);
      }
    });
    if (response == null) return;
    return response;

  }

  //============================================COMMON
  Future<dynamic> apiDeleteAttachment(docno,doctype,srno) async{

    var request = jsonEncode(<dynamic, dynamic>{
      'DOCNO':docno,
      'DOCTYPE':doctype,
      'SRNO':srno,
    });

    var response = await ApiManager().post('api/DeleteAttachment',request).catchError((error){
      if (error is BadRequestException) {
      } else {
        handleError(error);
      }
    });

    if (response == null) return;

    return response;

  }
  Future<dynamic> apiViewLog(docno,doctype) async{

    dprint('${'api/getlog?DOCNO='+docno}&DOCTYPE='+doctype);
    var response = await ApiManager().postLink('${'api/getlog?DOCNO='+docno}&DOCTYPE='+doctype).catchError((error){
      if (error is BadRequestException) {
      } else {
        handleError(error);
      }
    });
    dprint(response);
    if (response == null) return;

    return response;

  }
  Future<dynamic> apiGetAppSetup() async{

    var response = await ApiManager().postLink('api/get_appconfig').catchError((error){
      if (error is BadRequestException) {
      } else {
        handleError(error);
      }
    });
    dprint('api/get_appconfig');
    dprint(response);

    if (response == null) return;

    return response;

  }

  //============================================Game

  Future<dynamic> apiGetUserGames(company,user,game) async {

    var request = jsonEncode(<dynamic, dynamic>{
      "COMPANY":company,
      "USERCD":user,//OPTIONAL
      "GAME_CODE":game//OPTIONAL
    });
    dprint('api/GetUserGames');
    dprint(request);
    var response = await ApiManager().post('api/GetUserGames',request).catchError((error){
      if (error is BadRequestException) {
       dprint(error.toString());
      } else {
        handleError(error);
      }
    });
    if (response == null) return;
    dprint(response);
    return response;

  }

  //============================================User
  Future<dynamic> apiCreateUser(company,user,role,parent,pwd,weeklyCr,dailyCr,mode,games) async {

    var request = jsonEncode(<dynamic, dynamic>{
      "COMPANY":company,
      "USERCD":user,
      "ROLE_CODE":role,
      "PARENT_CODE":parent,
      "PWD":pwd,
      "WEEKLY_CR_LIMIT":weeklyCr,
      "DAILY_CR_LIMIT":dailyCr,
      "MODE":mode,//ADD,EDIT(WEEKLY_CR_LIMIT,DAILY_CR_LIMIT),PASSWORD
      "GAMES":games
    });
    dprint('api/saveuser');
    dprint(request);
    var response = await ApiManager().post('api/saveuser',request).catchError((error){
      if (error is BadRequestException) {
        dprint(error.toString());
      } else {
        handleError(error);
      }
    });
    if (response == null) return;
    dprint(response);
    return response;

  }
  Future<dynamic> apiGetChildUser(company,user,roleCode,search) async {

    var request = jsonEncode(<dynamic, dynamic>{
        "COMPANY":company,
        "USERCD":user,
        "ROLE_CODE":roleCode,
        "SEARCH":search,
    });
    dprint('api/getChildUser');
    dprint(request);
    var response = await ApiManager().post('api/getChildUser',request).catchError((error){
      if (error is BadRequestException) {
        dprint(error.toString());
      } else {
        handleError(error);
      }
    });
    if (response == null) return;
    dprint(response);
    return response;

  }


  Future<dynamic> apiUpdateUserGamePrize(company,user,data) async {

    var request = jsonEncode(<dynamic, dynamic>{
      "COMPANY":company,
      "USERCD":user,
      "DATA":data
    });
    dprint('api/saveGameWinning');
    dprint(request);
    var response = await ApiManager().post('api/saveGameWinning',request).catchError((error){
      if (error is BadRequestException) {
        dprint(error.toString());
      } else {
        handleError(error);
      }
    });
    dprint(response);
    if (response == null) return;

    return response;

  }


  Future<dynamic> apiUpdateUserSaleRate(company,user,data) async {

    var request = jsonEncode(<dynamic, dynamic>{
      "COMPANY":company,
      "USERCD":user,
      "DATA":data
    });
    dprint('api/saveGamePrice');
    dprint(request);
    var response = await ApiManager().post('api/saveGamePrice',request).catchError((error){
      if (error is BadRequestException) {
        dprint(error.toString());
      } else {
        handleError(error);
      }
    });
    if (response == null) return;
    dprint(response);
    return response;

  }



  Future<dynamic> apiGetUserDetails(company,user,mode) async {

    var request = jsonEncode(<dynamic, dynamic>{
      "COMPANY":company,
      "USERCD":user,
      "GAME_CODE":null,
      "MODE":mode,//PRICE,WINNING,COUNTLIMIT,NUMBER_COUNTLIMIT
      "TYPE":null
    });
    dprint('api/GetuserGmesettings');
    dprint(request);
    var response = await ApiManager().post('api/GetuserGmesettings',request).catchError((error){
      if (error is BadRequestException) {
        dprint(error.toString());
      } else {
        handleError(error);
      }
    });
    dprint(response);
    if (response == null) return;

    return response;

  }

  Future<dynamic> apiSaveUserGameCount(company,user,data) async {

    var request = jsonEncode(<dynamic, dynamic>{
      "COMPANY":company,
      "USERCD":user,
      "DATA":data,
    });
    dprint('api/saveGameCountLimit');
    dprint(request);
    var response = await ApiManager().post('api/saveGameCountLimit',request).catchError((error){
      if (error is BadRequestException) {
        dprint(error.toString());
      } else {
        handleError(error);
      }
    });
    dprint(response);
    if (response == null) return;

    return response;

  }

  Future<dynamic> apiSaveUserNumberCount(company,user,gameCode,type,number,count) async {

    var request = jsonEncode(<dynamic, dynamic>{
      "COMPANY":company,
      "USERCD":user,
      "GAME_CODE":gameCode,
      "TYPE":type,
      "NUMBER":number,
      "COUNT":count
    });
    dprint('api/saveNumberCountLimit');
    dprint(request);
    var response = await ApiManager().post('api/saveNumberCountLimit',request).catchError((error){
      if (error is BadRequestException) {
        dprint(error.toString());
      } else {
        handleError(error);
      }
    });
    dprint(response);
    if (response == null) return;

    return response;

  }


  Future<dynamic> apiRemoveNumberCountLimit(company,user,gameCode,type,number) async {

    var request = jsonEncode(<dynamic, dynamic>{
      "COMPANY":company,
      "USERCD":user,
      "GAME_CODE":gameCode,
      "TYPE":type,
      "NUMBER":number,
    });
    dprint('api/removeNumberCountLimit');
    dprint(request);
    var response = await ApiManager().post('api/removeNumberCountLimit',request).catchError((error){
      if (error is BadRequestException) {
        dprint(error.toString());
      } else {
        handleError(error);
      }
    });
    dprint(response);
    if (response == null) return;

    return response;

  }


  Future<dynamic> apiBlockUnblock(company,user,mode) async {

    var request = jsonEncode(<dynamic, dynamic>{
      "COMPANY":company,
      "USERCD":user,
      "REMARK":"",
      "MODE":mode//UNBLOCK
    });
    dprint('api/blockunblock');
    dprint(request);
    var response = await ApiManager().post('api/blockunblock',request).catchError((error){
      if (error is BadRequestException) {
        dprint(error.toString());
      } else {
        handleError(error);
      }
    });
    dprint(response);
    if (response == null) return;

    return response;

  }


  //===============================================GLOBAL


  Future<dynamic> apiSaveGlobalGameCount(data) async {

    var request = jsonEncode(<dynamic, dynamic>{
      "DATA":data,
    });
    dprint('api/saveGlobGameCountLimit');
    dprint(request);
    var response = await ApiManager().post('api/saveGlobGameCountLimit',request).catchError((error){
      if (error is BadRequestException) {
        dprint(error.toString());
      } else {
        handleError(error);
      }
    });
    dprint(response);
    if (response == null) return;

    return response;

  }



  Future<dynamic> apiSaveGlobalNumberCount(gameCode,type,number,count) async {

    var request = jsonEncode(<dynamic, dynamic>{
      "GAME_CODE":gameCode,
      "TYPE":type,
      "NUMBER":number,
      "COUNT":count
    });
    dprint('api/saveGlobNumberCountLimit');
    dprint(request);
    var response = await ApiManager().post('api/saveGlobNumberCountLimit',request).catchError((error){
      if (error is BadRequestException) {
        dprint(error.toString());
      } else {
        handleError(error);
      }
    });
    dprint(response);
    if (response == null) return;

    return response;

  }


  Future<dynamic> apiRemoveGlobalNumberCountLimit(gameCode,type,number) async {

    var request = jsonEncode(<dynamic, dynamic>{
      "GAME_CODE":gameCode,
      "TYPE":type,
      "NUMBER":number,
    });
    dprint('api/removeGlobNumberCountLimit');
    dprint(request);
    var response = await ApiManager().post('api/removeGlobNumberCountLimit',request).catchError((error){
      if (error is BadRequestException) {
        dprint(error.toString());
      } else {
        handleError(error);
      }
    });
    dprint(response);
    if (response == null) return;

    return response;

  }

  Future<dynamic> apiGetGlobalDetails(company,mode) async {

    var request = jsonEncode(<dynamic, dynamic>{
      "COMPANY":company,
      "GAME_CODE":null,
      "MODE":mode,//PRICE,WINNING,COUNTLIMIT,NUMBER_COUNTLIMIT
      "TYPE":null
    });
    dprint('api/GetGmesettings');
    dprint(request);
    var response = await ApiManager().post('api/GetGmesettings',request).catchError((error){
      if (error is BadRequestException) {
        dprint(error.toString());
      } else {
        handleError(error);
      }
    });
    dprint(response);
    if (response == null) return;

    return response;

  }


  Future<dynamic> apiUpdateGlobalGamePrice(data) async {

    var request = jsonEncode(<dynamic, dynamic>{
      "DATA":data
    });
    dprint('api/saveGlobGamePrice');
    dprint(request);
    var response = await ApiManager().post('api/saveGlobGamePrice',request).catchError((error){
      if (error is BadRequestException) {
        dprint(error.toString());
      } else {
        handleError(error);
      }
    });
    dprint(response);
    if (response == null) return;

    return response;

  }


  Future<dynamic> apiUpdateGlobalGamePrize(data) async {

    var request = jsonEncode(<dynamic, dynamic>{
      "DATA":data
    });
    dprint('api/saveGlobGameWinning');
    dprint(request);
    var response = await ApiManager().post('api/saveGlobGameWinning',request).catchError((error){
      if (error is BadRequestException) {
        dprint(error.toString());
      } else {
        handleError(error);
      }
    });
    dprint(response);
    if (response == null) return;

    return response;

  }


  //================================================BOOKING

  Future<dynamic> apiValidateGame(company,user,game,date) async {
    var request = jsonEncode(<dynamic, dynamic>{
      "COMPANY":company,
      "USERCD":user,
      "GAME_CODE":game,
      "DATE":date
    });
    dprint('api/ValidateGameEntry');
    dprint(request);
    var response = await ApiManager().post('api/ValidateGameEntry',request).catchError((error){
      if (error is BadRequestException) {
        dprint(error.toString());
      } else {
        handleError(error);
      }
    });
    dprint(response);
    if (response == null) return;

    return response;

  }

  Future<dynamic> apiAvailableGames(company,user) async {
    var request = jsonEncode(<dynamic, dynamic>{
      "COMPANY":company,
      "USERCD":user,
      "GAME_CODE":""
    });
    dprint('api/AvailableGames');
    dprint(request);
    var response = await ApiManager().post('api/AvailableGames',request).catchError((error){
      if (error is BadRequestException) {
        dprint(error.toString());
      } else {
        handleError(error);
      }
    });
    dprint(response);
    if (response == null) return;

    return response;

  }


  Future<dynamic> apiSaveBooking(docno,doctype,company,user,custName,custDet,device,agentCode,mode,det) async {
    var request = jsonEncode(<dynamic, dynamic>{
      "GAME_DOCNO":docno,
      "GAME_DOCTYPE":"DG",
      "USER_COMPANY":company,
      "USER_CODE":user,
      "CUSTOMER_NAME":custName,
      "CUSTOMER_DET":custDet,
      "CREATE_DEVICE":device,
      "AGENT_CODE":agentCode,
      "MODE":mode,
      "DET":det
    });
    dprint('api/saveBooking');
    dprint(request);
    var response = await ApiManager().post('api/saveBooking',request).catchError((error){
      if (error is BadRequestException) {
        dprint(error.toString());
      } else {
        handleError(error);
      }
    });
    dprint(response);
    if (response == null) return;

    return response;

  }


  Future<dynamic> apiGetBooking(mode,docno) async {
    var request = jsonEncode(<dynamic, dynamic>{
      "VIEW_TYPE":"PREVIOUS",
      "DOCNO":"00000016"
    });
    dprint('api/getBooking');
    dprint(request);
    var response = await ApiManager().post('api/getBooking',request).catchError((error){
      if (error is BadRequestException) {
        dprint(error.toString());
      } else {
        handleError(error);
      }
    });
    dprint(response);
    if (response == null) return;
    return response;
  }



  Future<dynamic> apiGetBookingList(search,company,createUser,gameCode) async {
    var request = jsonEncode(<dynamic, dynamic>{
      "DOCNO":"",
      "DOCTYPE":"",
      "GAME_DOCNO": "",
      "GAME_DOCTYPE": "",
      "USER_COMPANY": company,
      "USER_CODE": createUser,
      "AGENT_CODE": "",
      "GAME_CODE": gameCode,
      "DRAW_DATE": null,//2023-06-23
      "PAGE": 1,
      "PAGESIZE":10,
      "SEARCH":search
    });
    dprint('api/getBookingList');
    dprint(request);
    var response = await ApiManager().post('api/getBookingList',request).catchError((error){
      if (error is BadRequestException) {
        dprint(error.toString());
      } else {
        handleError(error);
      }
    });
    dprint(response);
    if (response == null) return;
    return response;
  }

}