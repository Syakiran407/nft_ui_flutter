import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:nft_proper_project/controllers/controller.dart';

class RaritySettings extends StatelessWidget {
  RaritySettings({Key? key}) : super(key: key);
  final Controller c = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() => Text(c.project.value.name.toString()));
  }
}