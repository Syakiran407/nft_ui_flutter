import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:nft_proper_project/controllers/controller.dart';
import 'package:nft_proper_project/views/export.dart';

void main() {
  runApp(NFTGenerator());
}

class NFTGenerator extends StatelessWidget {
  NFTGenerator({Key? key}) : super(key: key);
  final Controller c = Get.put(Controller());

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      home: Scaffold(
        body: Body(),
      ),
    );
  }
}

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StaggeredGridView.countBuilder(
      crossAxisCount: 4,
      itemCount: 4,
      mainAxisSpacing: 4,
      crossAxisSpacing: 4,
      shrinkWrap: true,
      staggeredTileBuilder: (int index) =>
          StaggeredTile.count(index.isEven ? 3 : 1, index < 2 ? 0.5 : 1.5),
      itemBuilder: (BuildContext context, int index) {
        switch (index) {
          case 0:
          return ProjectOverview();     
          case 1:
          return CollectionsInput(); 
          case 2:
          return Container(
            
            child:CollectionsData());
          case 3:
          return RaritySettings();    
          default:
          return const Text("Widget unavailable");
        }
      },
    );
  }
}
