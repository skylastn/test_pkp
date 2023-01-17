import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_pkp/domain/core/model/ResourceModel.dart';
import 'package:test_pkp/domain/core/model/ResponseModel.dart';
import 'package:test_pkp/infrastructure/dal/services/resource_service.dart';

class HomeController extends GetxController
    with StateMixin<List<ResourceModel>> {
  RxList<ResourceModel> listResource = RxList();

  @override
  void onInit() {
    super.onInit();
    getResource();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  getResource() async {
    change([], status: RxStatus.loading());
    try {
      listResource.value = await ResourceService().getSource();
      await Future.delayed(const Duration(seconds: 2));
      change(listResource, status: RxStatus.success());
    } catch (e) {
      Get.snackbar("Info", e.toString());
      change([], status: RxStatus.error(e.toString()));
    }
  }

  addOrEditSource(ResourceModel? resourceModel, String type) {
    TextEditingController title =
        TextEditingController(text: resourceModel?.title);
    TextEditingController body =
        TextEditingController(text: resourceModel?.body);
    ArtSweetAlert.show(
      context: Get.context!,
      artDialogArgs: ArtDialogArgs(
          showCancelBtn: true,
          title: type == "create" ? "Create Resource" : "Edit Resource",
          customColumns: [
            Container(
              padding: const EdgeInsets.fromLTRB(10, 2, 10, 2),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: Colors.red),
              ),
              child: TextField(
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  labelText: "Title",
                ),
                controller: title,
              ),
            ),
            const SizedBox(height: 15),
            Container(
              padding: const EdgeInsets.fromLTRB(10, 2, 10, 2),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: Colors.red),
              ),
              child: TextField(
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  labelText: "Body",
                ),
                controller: body,
              ),
            ),
            const SizedBox(height: 15),
          ],
          onConfirm: () {
            Get.back();
            if (type == "create") {
              addResource(ResourceModel(
                title: title.text,
                body: body.text,
              ));
              return;
            }
            resourceModel?.title = title.text;
            resourceModel?.body = body.text;
            editResource(resourceModel!);
          }),
    );
  }

  deleteResource(String idPost) async {
    try {
      ResponseModel result =
          await ResourceService().deleteSource(idPost: idPost);
      if (!result.isError) {
        Get.snackbar("Info", "Success Delete Resource");
        getResource();
        return;
      }
      Get.snackbar("Info", result.msg);
    } catch (e) {
      Get.snackbar("Info", e.toString());
    }
  }

  editResource(ResourceModel resourceModel) async {
    try {
      ResponseModel result =
          await ResourceService().editSource(sources: resourceModel);
      if (!result.isError) {
        Get.snackbar("Info", "Success Edit Resource");
        getResource();
        return;
      }
      Get.snackbar("Info", result.msg);
    } catch (e) {
      Get.snackbar("Info", e.toString());
    }
  }

  addResource(ResourceModel resourceModel) async {
    try {
      ResponseModel result =
          await ResourceService().createSource(sources: resourceModel);
      if (!result.isError) {
        Get.snackbar("Info", "Success Create Resource");
        getResource();
        return;
      }
      Get.snackbar("Info", result.msg);
    } catch (e) {
      Get.snackbar("Info", e.toString());
    }
  }
}
