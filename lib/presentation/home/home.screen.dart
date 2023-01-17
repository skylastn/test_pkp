import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:test_pkp/domain/core/model/ResourceModel.dart';

import 'controllers/home.controller.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Get.put(HomeController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomeScreen'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        key: UniqueKey(),
        onPressed: () {
          controller.addOrEditSource(null, "create");
        },
        child: const Icon(Icons.add),
      ),
      body: Container(
        padding: const EdgeInsets.all(12),
        child: controller.obx(
          (state) => ListView.builder(
            itemCount: state?.length,
            itemBuilder: ((context, index) {
              ResourceModel? content = state?[index];
              return ListTile(
                leading: IconButton(
                  onPressed: () {
                    controller.addOrEditSource(content, "edit");
                  },
                  icon: const Icon(Icons.edit),
                ),
                trailing: IconButton(
                  onPressed: () {
                    controller.deleteResource((content?.id ?? "").toString());
                  },
                  icon: const Icon(Icons.delete),
                ),
                title: Text(
                  "${content?.title}",
                  maxLines: 1,
                ),
                subtitle: Text(
                  "${content?.body}",
                  maxLines: 2,
                ),
              );
            }),
          ),
          onLoading: const Center(
            child: CircularProgressIndicator(),
          ),
          onEmpty: const Center(
            child: Text("Data not found"),
          ),
          onError: (error) => Center(
            child: Text(error ?? ''),
          ),
        ),
      ),
    );
  }
}
