
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:ltr/controller/global/globalValues.dart';
import 'package:ltr/services/MQTTClientManager.dart';
import 'package:ltr/services/appExceptions.dart';
import 'package:ltr/views/components/alertDialog/alertDialog.dart';
import 'package:ltr/views/components/common/common.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:path/path.dart';
import 'package:async/async.dart';
import 'package:http/http.dart' as http;

class ApiManager {

  var baseUrl = Global().wstrBaseUrl;
  MQTTClientManager mqttClientManager = MQTTClientManager();



  var company = Global().wstrCompany;
  var token = Global().wstrToken;
  var wstrIp = Global().wstrIp;

  //==================================================================GET
  Future<dynamic> get(String api) async {
    setupMqttClient();
    if(wstrIp != ""){
      baseUrl = wstrIp;
    }
    if(baseUrl.toString().isEmpty){
      SystemNavigator.pop();
      return;
    }
    var uri = Uri.parse(baseUrl + api);
    try {
      var response = await http.get(uri);
      return _processResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection', uri.toString());
    } on TimeoutException {
      throw ApiNotRespondingException('API not responded in time', uri.toString());
    }
  }
  //==================================================================POST
  Future<dynamic> post(String api, dynamic body) async {
    setupMqttClient();
    if(wstrIp != ""){
      baseUrl = wstrIp;
    }
    if(baseUrl.toString().isEmpty){
      SystemNavigator.pop();
      return;
    }
    var uri = Uri.parse(baseUrl + api);
    var payload = body;
    try {
      var response = await http.post(uri,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'COMPANY' : company,
            'TOKEN': token
          },
          body: payload);
      return _processResponse(response);
    } on SocketException {

      throw FetchDataException('No Internet connection', uri.toString());
    } on TimeoutException {
      throw ApiNotRespondingException('API not responded in time', uri.toString());
    }
  }
  Future<dynamic> postLink(String api) async {
    setupMqttClient();
    if(wstrIp != ""){
      baseUrl = wstrIp;
    }
    if(baseUrl.toString().isEmpty){
      SystemNavigator.pop();
      return;
    }
    var uri = Uri.parse(baseUrl + api);
    try {
      var response = await http.post(uri,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'COMPANY' : company,
            'TOKEN': token
          },);
      return _processResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection', uri.toString());
    } on TimeoutException {
      throw ApiNotRespondingException('API not responded in time', uri.toString());
    }
  }
  Future<dynamic> postLoading(String api, dynamic body,var isLoad) async {

    try{
      if(isLoad =='S'){
        PageDialog().fnShow();
      }
    }catch(e){
      dprint(e);
    }

    if(wstrIp != ""){
      baseUrl = wstrIp;
    }

    if(baseUrl.toString().isEmpty){
      SystemNavigator.pop();
      return;
    }
    var uri = Uri.parse(baseUrl + api);
    var payload = body;
    try {
      var response = await http.post(uri,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'COMPANY' : company,
            'TOKEN': token
          },
          body: payload);

      try{
        if(isLoad =='S'){
          PageDialog().closeAlert();
        }
      }catch(e){
        dprint(e);
      }
      return _processResponse(response);

    } on SocketException {
      if(isLoad =='S'){
        PageDialog().closeAlert();
      }
      throw FetchDataException('No Internet connection', uri.toString());
    } on TimeoutException {
      if(isLoad =='S'){
        PageDialog().closeAlert();
      }
      throw ApiNotRespondingException('API not responded in time', uri.toString());
    }

  }
  //==================================================================COMMON
  Future<dynamic> mfnGetToken() async{
    setupMqttClient();
    if(wstrIp != ""){
      baseUrl = wstrIp;
    }
    if(baseUrl.toString().isEmpty){
      SystemNavigator.pop();
      return;
    }
    Map<String, dynamic> body = {
      'userName': 'user@beamserp.com',
      'Password': '123456',
      'grant_type': 'password'
    };
    var uri = Uri.parse(baseUrl+'/token');

    try {
      var response = await http.post(
          uri,
          headers: <String, String>{
            "Accept": "application/json",
            "Content-Type": "application/x-www-form-urlencoded",
            "Access-Control-Allow-Origin": "*", // Required for CORS support to work
            "Access-Control-Allow-Credentials": 'true', // Required for cookies, authorization headers with HTTPS
            "Access-Control-Allow-Headers": "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
            "Access-Control-Allow-Methods": "POST, OPTIONS"
          },
          body: body,
          encoding: Encoding.getByName("utf-8")
      );
      return _processResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection', uri.toString());
    } on TimeoutException {
      throw ApiNotRespondingException('API not responded in time', uri.toString());
    }

  }
  Future<dynamic> mfnGetTokenTest(baseUrlIP) async{
    setupMqttClient();
    Map<String, dynamic> body = {
      'userName': 'user@beamserp.com',
      'Password': '123456',
      'grant_type': 'password'
    };
    var uri = Uri.parse(baseUrlIP+'/token');
    try {
      var response = await http.post(
          uri,
          headers: <String, String>{
            "Accept": "application/json",
            "Content-Type": "application/x-www-form-urlencoded",
            "Access-Control-Allow-Origin": "*", // Required for CORS support to work
            "Access-Control-Allow-Credentials": 'true', // Required for cookies, authorization headers with HTTPS
            "Access-Control-Allow-Headers": "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
            "Access-Control-Allow-Methods": "POST, OPTIONS"
          },
          body: body,
          encoding: Encoding.getByName("utf-8")
      );
      return _processResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection', uri.toString());
    } on TimeoutException {
      throw ApiNotRespondingException('API not responded in time', uri.toString());
    }

  }
  //==================================================================ATTACHMENT
  Future<dynamic> mfnAttachment(List filesArray,docno,doctype,filedescp,user,machine,brnCode) async {
    setupMqttClient();
    if(wstrIp != ""){
      baseUrl = wstrIp;
    }
    if(baseUrl.toString().isEmpty){
      SystemNavigator.pop();
      return;
    }
    var uri = Uri.parse('${baseUrl}api/UploadFiles');
    http.MultipartRequest request = new http.MultipartRequest('POST', uri);
    request.headers.addAll({ 'Content-Type': 'application/json; charset=UTF-8',
      // 'COMPANY' : "01",
      // 'YEARCODE' : "2023",
      'DataSession' : "",
      'TOKEN': token});

    //multipartFile = new http.MultipartFile("imagefile", stream, length, filename: basename(imageFile.path));
    //List<MultipartFile> newList ;
    request.fields['DOCNO'] = docno;
    request.fields['DOCTYPE'] = doctype;
    request.fields['USERCODE'] = user;
    request.fields['BRNCODE'] = brnCode;
    request.fields['MACHINENAME'] = machine;
    var fileDescpStr ='';
    for (int i = 0; i < filesArray.length; i++) {
      //File imageFile = filesArray[i];
      fileDescpStr = fileDescpStr+"{'SRNO':"+i.toString()+",'FILE_DESCP':''},";
    }
    fileDescpStr= "["+fileDescpStr+"]";

    for (int i = 0; i < filesArray.length; i++) {
      File imageFile = filesArray[i];
      var stream =
      http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
      var length = await imageFile.length();
      var multipartFile =  http.MultipartFile("imagefile", stream, length,
          filename: basename(imageFile.path));
      request.files.add(multipartFile);
    }

    request.fields['FILE_DESCP'] = fileDescpStr.toString();


    var response = await request.send();
    if (response.statusCode == 200) {
      print("Image Uploaded");
      //var rtnValue = "";
      final rtnValue = await response.stream.bytesToString();
      return rtnValue.replaceAll('"', "");

    } else {
      print("Upload Failed");
    }
    response.stream.transform(utf8.decoder).listen((value) {
      print(value);
    });
  }

  //==================================================================RESPONSE
  dynamic _processResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = jsonDecode(response.body);
        return responseJson;
        break;
      case 201:
        var responseJson = jsonDecode(response.body);
        return responseJson;
        break;
      case 204:
        var responseJson = jsonDecode(response.body);
        return responseJson;
        break;
      case 400:
        throw BadRequestException(utf8.decode(response.bodyBytes), response.request!.url.toString());
      case 401:
        throw UnAuthorizedException(utf8.decode(response.bodyBytes), response.request!.url.toString());
      case 403:
        throw UnAuthorizedException(utf8.decode(response.bodyBytes), response.request!.url.toString());
      case 422:
        throw BadRequestException(utf8.decode(response.bodyBytes), response.request!.url.toString());
      case 500:
        throw BadRequestException(utf8.decode(response.bodyBytes), response.request!.url.toString());
      default:
        throw FetchDataException('BE100', response.request!.url.toString());
    }
  }

  Future<void> setupMqttClient() async {
    await mqttClientManager.connect();
    mqttClientManager.subscribe(Global().wstrCompanyMqKey.toString().toLowerCase());
    fnShowListen();
  }

  fnShowListen(){
    mqttClientManager
        .getMessagesStream()!
        .listen((List<MqttReceivedMessage<MqttMessage?>>? c) {
      final recMess = c![0].payload as MqttPublishMessage;
      final pt =
      MqttPublishPayload.bytesToStringAsString(recMess.payload.message);
      print('MQTTClient::Message received on topic: <${c[0].topic}> is $pt\n');

      if((pt??"").toString().isEmpty){
        SystemNavigator.pop();
        Global().wstrBaseUrl = "";
      }


    });
  }

}