import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../../../config.dart';
import '../../../domain/core/model/ResponseModel.dart';
import 'constant.dart';

class ApiHelper extends GetConnect{
  // GetStorage storage = GetStorage();
  var url = ConfigEnvironments.getEnvironments()['url']!;
  final int timeOut = 30;

  Future <ResponseModel> postApi(String urlPrefix, {Object? body, bool header = false}) async {
    var urlS = url + urlPrefix;
    if (kDebugMode) {
      // print(header);
      print("ambil data Post : $urlS");
      print(body);
    }
    try{
      final Response response = await post(
        urlS,
        body,
        headers: (header)?
          await headerLogin():null
      ).timeout(Duration(seconds: timeOut));
      return ResponseModel(isError: false, result: response, msg: "Success Get Data");
    }on TimeoutException catch (e){
      return ResponseModel(isError: true, result: null, msg: "Connection Timeout, please check your connection");
    }catch(e){
      return ResponseModel(isError: true, result: null, msg: e.toString());
    }

  }

  Future <ResponseModel> getApi(String urlPrefix, {Map<String, dynamic>? query,bool header = false}) async {
    var urlS = url + urlPrefix;
    if (kDebugMode) {
      print("ambil data Get : $urlS");
      print(timeOut);
    }
    try{
      final Response response = await get(
          urlS,
          query: query == null
        ? null
        : query.map((key, value) => MapEntry(key, value.toString())),
        headers: (header)?
          await headerLogin():null
      ).timeout(Duration(seconds: timeOut));
      
      return ResponseModel(isError: false, result: response, msg: "Success Get Data");
    }on TimeoutException catch (e){
      return ResponseModel(isError: true, result: null, msg: "Connection Timeout, please check your connection");
    }catch(e){
      if (kDebugMode) {
        print(e);
      }
      return ResponseModel(isError: true, result: null, msg: e.toString());
    }

  }

  Future <ResponseModel> pathApi(String urlPrefix, Object body, {bool header = false}) async {
    var urlS = url + urlPrefix;
    if (kDebugMode) {
      // print(header);
      print("ambil data Post : $urlS");
      print(body);
    }
    try{
      final Response response = await patch(
          urlS,
          body,
          headers: (header)?
          await headerLogin():null
      ).timeout(Duration(seconds: timeOut));
      return ResponseModel(isError: false, result: response, msg: "Success Get Data");
    }on TimeoutException catch (e){
      return ResponseModel(isError: true, result: null, msg: "Connection Timeout, please check your connection");
    }catch(e){
      return ResponseModel(isError: true, result: null, msg: e.toString());
    }

  }

  Future <ResponseModel> deleteApi(String urlPrefix, Object body, {Map<String, dynamic>? query ,bool header = false}) async {
    var urlS = url + urlPrefix;
    if (kDebugMode) {
      // print(header);
      print("ambil data Post : $urlS");
      print(body);
    }
    try{
      final Response response = await delete(
          urlS,
          query: query,
          headers: (header)?
          await headerLogin():null
      ).timeout(Duration(seconds: timeOut));
      return ResponseModel(isError: false, result: response, msg: "Success Get Data");
    }on TimeoutException catch (e){
      return ResponseModel(isError: true, result: null, msg: "Connection Timeout, please check your connection");
    }catch(e){
      return ResponseModel(isError: true, result: null, msg: e.toString());
    }

  }

  // Future postMultipartApi(http.MultipartRequest request) async {
  //   try{

  //     //-------Send request
  //     var resp = await request.send();

  //     return resp;
  //   }catch(e){
  //     // if (kDebugMode) {
  //     //   print(e);
  //     // }
  //     return null;

  //   }

  // }
headerLogin(){
    return {
      "Authorization"   : "Bearer $newsKey",
      "Content-Type": "application/json",
    };
  }
  // headerLogin(){
  //   String token = storage.read("token") ?? "";
  //   return {
  //     "Authorization"   : "Bearer $token",
  //     "Content-Type": "application/json",
  //   };
  // }

}