import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:test_pkp/domain/core/model/ResourceModel.dart';
import 'package:test_pkp/domain/core/model/ResponseModel.dart';
import '../utils/api_helper.dart';
import '../utils/constant.dart';

class ResourceService {
  Future<List<ResourceModel>> getSource() async {
    var response = await ApiHelper().getApi(
      ApiConfig().post,
      header: false,
    );
    if (kDebugMode) {
      print(response.isError);
      print(response.msg);
    }
    if (!response.isError) {
      // if (kDebugMode) {
      //   print(response.result?.body);
      // }
      return resourceModelFromJson(response.result!.bodyString!);
    }
    throw response.msg;
  }

  Future<ResponseModel> createSource({required ResourceModel sources}) async {
    var response = await ApiHelper().postApi(
      ApiConfig().post,
      body: jsonEncode({
        "title" : sources.title,
        "body" : sources.body,
        "userId" : 1,
      }),
      header: false,
    );
    if (kDebugMode) {
      print(response.isError);
      print(response.msg);
    }
    if (!response.isError) {
      if (kDebugMode) {
        print(response.result?.body);
      }
    }
    return response;
  }

  Future<ResponseModel> editSource({required ResourceModel sources}) async {
    var response = await ApiHelper().postApi(
      "${ApiConfig().post}/${sources.id}",
      body: jsonEncode(sources.toJson()),
      header: false,
    );
    if (kDebugMode) {
      print(response.isError);
      print(response.msg);
    }
    if (!response.isError) {
      if (kDebugMode) {
        print(response.result?.body);
      }
    }
    return response;
  }

  Future<ResponseModel> deleteSource({required String idPost}) async {
    var response = await ApiHelper().getApi(
      "${ApiConfig().post}/$idPost",
      header: false,
    );
    if (kDebugMode) {
      print(response.isError);
      print(response.msg);
    }
    if (!response.isError) {
      if (kDebugMode) {
        print(response.result?.body);
      }
    }
    return response;
  }
}
