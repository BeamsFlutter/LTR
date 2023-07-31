

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
        // var apiError = json.decode(error.message!);
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
        //var apiError = json.decode(error.message!);
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
  Future<dynamic> apiCreateUser(company,user,role,parent,pwd,weeklyCr,dailyCr,mode,sharePer,canView,dAgent,games,menu) async {

    var request = jsonEncode(<dynamic, dynamic>{
      "COMPANY":company,
      "USERCD":user,
      "ROLE_CODE":role,
      "PARENT_CODE":parent,
      "PWD":pwd,
      "WEEKLY_CR_LIMIT":weeklyCr,
      "DAILY_CR_LIMIT":dailyCr,
      "CANVIEW_COM":canView,//Y OR N
      "DEF_AGENT":dAgent,
      "SHARE_PER":sharePer,//
      "MODE":mode,//ADD,EDIT(WEEKLY_CR_LIMIT,DAILY_CR_LIMIT),PASSWORD
      "GAMES":games,
      "MENU":menu,
    });
    dprint('api/saveuser');
    dprint(request);
    var response = await ApiManager().postLoading('api/saveuser',request,"S").catchError((error){
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
  Future<dynamic> apiGetChildUser(company,user,roleCode,search,mode) async {

    var request = jsonEncode(<dynamic, dynamic>{
        "COMPANY":company,
        "USERCD":user,
        "ROLE_CODE":roleCode,
        "SEARCH":search,
        "MODE":mode,
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
    var response = await ApiManager().postLoading('api/saveGameWinning',request,"S").catchError((error){
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
    var response = await ApiManager().postLoading('api/saveGamePrice',request,"S").catchError((error){
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



  Future<dynamic> apiGetUserDetails(company,user,mode,game) async {

    var request = jsonEncode(<dynamic, dynamic>{
      "COMPANY":company,
      "USERCD":user,
      "GAME_CODE":game,
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
    var response = await ApiManager().postLoading('api/saveGameCountLimit',request,"S").catchError((error){
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

  Future<dynamic> apiSaveUserNumberCount(company,user,data) async {

    var request = jsonEncode(<dynamic, dynamic>{
      "COMPANY":company,
      "USERCD":user,
      "DATA":data
    });
    dprint('api/saveNumberCountLimit');
    dprint(request);
    var response = await ApiManager().postLoading('api/saveNumberCountLimit',request,"S").catchError((error){
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
    var response = await ApiManager().postLoading('api/removeNumberCountLimit',request,"S").catchError((error){
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
    var response = await ApiManager().postLoading('api/blockunblock',request,"S").catchError((error){
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
    var response = await ApiManager().postLoading('api/saveGlobGameCountLimit',request,"S").catchError((error){
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



  Future<dynamic> apiSaveGlobalNumberCount(data) async {

    var request = jsonEncode(<dynamic, dynamic>{
      // "GAME_CODE":gameCode,
      // "TYPE":type,
      // "NUMBER":number,
      // "COUNT":count,
      "DATA":data
    });
    dprint('api/saveGlobNumberCountLimit');
    dprint(request);
    var response = await ApiManager().postLoading('api/saveGlobNumberCountLimit',request,"S").catchError((error){
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
    var response = await ApiManager().postLoading('api/removeGlobNumberCountLimit',request,"S").catchError((error){
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

  Future<dynamic> apiGetGlobalDetails(company,mode,game) async {

    var request = jsonEncode(<dynamic, dynamic>{
      "COMPANY":company,
      "GAME_CODE":game,
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
    var response = await ApiManager().postLoading('api/saveGlobGamePrice',request,"S").catchError((error){
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
    var response = await ApiManager().postLoading('api/saveGlobGameWinning',request,"S").catchError((error){
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


  Future<dynamic> apiSaveBooking(docno,gameDocno,doctype,company,user,custName,custDet,device,agentCode,mode,det) async {
    var request = jsonEncode(<dynamic, dynamic>{
      "DOCNO":docno,
      "GAME_DOCNO":gameDocno,
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
    var response = await ApiManager().postLoading('api/saveBooking',request,"S").catchError((error){
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

  Future<dynamic> apiDeleteBooking(docno) async {
    var request = jsonEncode(<dynamic, dynamic>{
      "DOCNO":docno,
      "MODE":"DELETE",
    });
    dprint('api/saveBooking');
    dprint(request);
    var response = await ApiManager().postLoading('api/saveBooking',request,"S").catchError((error){
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
      "VIEW_TYPE":mode,
      "DOCNO":docno
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


  //====================================================RESULT

  Future<dynamic> apiGetGame(game,date) async {
    var request = jsonEncode(<dynamic, dynamic>{
      "GAME_CODE":game,
      "DATE":date
    });
    dprint('api/getGame');
    dprint(request);
    var response = await ApiManager().post('api/getGame',request).catchError((error){
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


  Future<dynamic> apiGetResultData(game,date) async {
    var request = jsonEncode(<dynamic, dynamic>{
      "GAME_CODE":game,
      "DATE":date,
    });
    dprint('api/getDateResult');
    dprint(request);
    var response = await ApiManager().post('api/getDateResult',request).catchError((error){
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
  Future<dynamic> apiGetLiveResult(game,date) async {
    var request = jsonEncode(<dynamic, dynamic>{
      "GAME_CODE":game,
      "DATE":date,
      "PUB_STATUS":"1"//OPTIONAL
    });
    dprint('api/getDateResult');
    dprint(request);
    var response = await ApiManager().post('api/getDateResult',request).catchError((error){
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


  Future<dynamic> apiSaveResult(gameDocno,pubDate,pubSts,createUser,mode,det) async {
    var request = jsonEncode(<dynamic, dynamic>{
      "GAME_DOCNO": gameDocno,
      "GAME_DOCTYPE": "DG",
      "REF1": "",
      "REF2": "",
      "REF3": "",
      "PUB_DATE": pubDate,
      "PUB_STATUS": pubSts,
      "CREATE_USER": createUser,
      "MODE": mode,//EDIT,DELETE,
      "DET": det
    });
    dprint('api/saveResult');
    dprint(request);
    var response = await ApiManager().post('api/saveResult',request).catchError((error){
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

  //==========================================SETTINGS

  Future<dynamic> apiUpdateGameMast(game,start,end,editMinutes) async {
    var request = jsonEncode(<dynamic, dynamic>{
      "CODE":game,
      "START_TIME":start,//"12:58:00.0000000",(null MEANS NO CHANGE)
      "END_TIME":end,//"12:58:00.0000000",(null MEANS NO CHANGE)
      "GLOBAL_STATUS":null,//0,1,OR null (null MEANS NO CHANGE)
      "EDIT_MINUT":editMinutes// null (null MEANS NO CHANGE)
    });
    dprint('api/updateGameMast');
    dprint(request);
    var response = await ApiManager().postLoading('api/updateGameMast',request,"S").catchError((error){
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
  Future<dynamic> apiGetGameMast(game) async {
    var request = jsonEncode(<dynamic, dynamic>{
      "CODE":game
    });
    dprint('api/getGameMast');
    dprint(request);
    var response = await ApiManager().post('api/getGameMast',request).catchError((error){
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

  Future<dynamic> apiGetLockedUsers(company) async {
    var request = jsonEncode(<dynamic, dynamic>{
      "COMPANY":company
    });
    dprint('api/getLockedUser');
    dprint(request);
    var response = await ApiManager().post('api/getLockedUser',request).catchError((error){
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

  Future<dynamic> apiUnLockUser(company,user) async {
    var request = jsonEncode(<dynamic, dynamic>{
      "COMPANY":company,
      "USERCD":user//null FOR ALL
    });
    dprint('api/unLockUser');
    dprint(request);
    var response = await ApiManager().post('api/unLockUser',request).catchError((error){
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

  Future<dynamic> apiCountReport(company,date,game,stockist,dealer,agent,type,number,typeList) async {
    var request = jsonEncode(<dynamic, dynamic>{
      "COMPANY":company,
      "DATE": date,
      "GAME_CODE": game,//null
      "STOCKIST_CODE":stockist,
      "DEALER_CODE":dealer,
      "AGENT_CODE":agent,
      "TYPE":type,
      "NUMBER":number,
      "TYPE_LIST":typeList
    });
    dprint('api/countReport');
    dprint(request);
    var response = await ApiManager().post('api/countReport',request).catchError((error){
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

  Future<dynamic> apiWinningReport(company,date,toDate,game,stockist,dealer,agent,type,number,mode,childPrice,typeList,rank) async {
    var request = jsonEncode(<dynamic, dynamic>{
      "COMPANY":company,
      "DATE_FROM": date,
      "DATE_TO": toDate,
      "GAME_CODE": game,//null
      "STOCKIST_CODE":stockist,
      "DEALER_CODE":dealer,
      "AGENT_CODE":agent,
      "TYPE":type,
      "NUMBER":number,
      "RANK":rank,
      "MODE":mode,//RAK or DET
      "CHILD_PRICE":childPrice,
      "TYPE_LIST":typeList
    });
    dprint('api/winningReport');
    dprint(request);
    var response = await ApiManager().postLoading('api/winningReport',request,"S").catchError((error){
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


  Future<dynamic> apiSalesReport(company,date,toDate,game,admCode,stockist,dealer,agent,type,number,docno,childPrice,typeList) async {
    var request = jsonEncode(<dynamic, dynamic>{
      "COMPANY":company,
      "DATE_FROM": date,
      "DATE_TO": toDate,
      "GAME_CODE": game,//null
      "ADMIN_CODE":admCode,
      "STOCKIST_CODE":stockist,
      "DEALER_CODE":dealer,
      "AGENT_CODE":agent,
      "TYPE":type,
      "NUMBER":number,
      "RANK":null,
      "BOOKING_DOCNO":docno,
      "CHILD_PRICE":childPrice,
      "TYPE_LIST":typeList
    });
    dprint('api/salesReport');
    dprint(request);
    var response = await ApiManager().postLoading('api/salesReport',request,"S").catchError((error){
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


  Future<dynamic> apiCountSummaryReport(company,date,toDate,game,admCode,stockist,dealer,agent,type,number,childPrize) async {
    var request = jsonEncode(<dynamic, dynamic>{
      "COMPANY":company,
      "DATE_FROM": date,
      "DATE_TO": toDate,
      "GAME_CODE": game,//null
      "STOCKIST_CODE":stockist,
      "DEALER_CODE":dealer,
      "AGENT_CODE":agent,
      "TYPE":type,
      "NUMBER":number,
      "RANK":null,
      "CHILD_PRICE":childPrize
    });
    dprint('api/countSummaryReport');
    dprint(request);
    var response = await ApiManager().postLoading('api/countSummaryReport',request,"S").catchError((error){
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


  Future<dynamic> apiDailyReport(company,date,toDate,game,user,childRate,mode) async {
    var request = jsonEncode(<dynamic, dynamic>{
      "COMPANY":company,
      "DATE_FROM": date,
      "DATE_TO": toDate,
      "GAME_CODE": game,//null
      "USER_FILTER":user,
      "CHILD_PRICE":childRate,//0 OR 1
      "MODE":mode//MODES :USER,GAME,DATE
    });
    dprint('api/dailyReport');
    dprint(request);
    var response = await ApiManager().postLoading('api/dailyReport',request,"S").catchError((error){
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

  Future<dynamic> apiBalanceReport(company,dateTo) async {
    var request = jsonEncode(<dynamic, dynamic>{
      "COMPANY": company ,
      "DATE_TO":dateTo
    });
    dprint('api/balanceReport');
    dprint(request);
    var response = await ApiManager().postLoading('api/balanceReport',request,"S").catchError((error){
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

  Future<dynamic> apiGetLog(docno,doctype) async {
    var request = jsonEncode(<dynamic, dynamic>{
      "DOCNO": docno,
      "DOCTYPE": doctype
    });
    dprint('api/getLog');
    dprint(request);
    var response = await ApiManager().postLoading('api/getLog',request,"S").catchError((error){
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

  Future<dynamic> apiPermissionMenu() async {
    var request = jsonEncode(<dynamic, dynamic>{

    });
    dprint('api/getMenuMast');
    dprint(request);
    var response = await ApiManager().postLoading('api/getMenuMast',request,"S").catchError((error){
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