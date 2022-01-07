import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:nft_proper_project/controllers/controller.dart';
import 'package:nft_proper_project/models/collection_data.dart';

class CollectionsInput extends StatelessWidget {
  CollectionsInput({Key? key}) : super(key: key);
  final Controller c = Get.put(Controller());

  @override
  Widget build(BuildContext context) {
    return Obx(() => Column(
          children: [
            TextField(
              decoration: InputDecoration(
                  labelText: "Total Collection Size",
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  hintText: c.project.value.totalCollectionSize.toString()),
              onChanged: (e) {
                c.changeTotalCollectionSize(int.parse(e));
              },
            ),
            TextField(
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: InputDecoration(
                  labelText: "Unique Collection Size",
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  hintText: c.project.value.collections.length.toString()),
              onChanged: (e) {
                int E = int.parse(e);
                int collectionLength = c.project.value.collections.length;

                if (E > collectionLength) {
                  for (int i = 0; i < E - collectionLength; i++) {
                    c.addCollection(Collection("New Collection"));
                  }
                }

                if (E < collectionLength) {
                  for (int i = 0; i < collectionLength - E; i++) {
                    c.removeLastCollection();
                  }
                }
              },
            ),
          ],
        ));
  }
}
