import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:nft_proper_project/models/layer_data.dart';

class Collection {
  String name = "";
  int collectionSize = 0;

  List<LayerData> layers = [
    // LayerData("Sheep"),
    // LayerData("Cat"),
    // LayerData("Ghost"),
    // LayerData("Popcorn"),
    // LayerData("Tezo"),
    //  LayerData("Sheep"),
    // LayerData("Cat"),
    // LayerData("Ghost"),
    // LayerData("Popcorn"),
    // LayerData("Tezo"),
    //  LayerData("Sheep"),
    // LayerData("Cat"),
    // LayerData("Ghost"),
    // LayerData("Popcorn"),
    // LayerData("Tezo"),
    //  LayerData("Sheep"),
    // LayerData("Cat"),
    // LayerData("Ghost"),
    // LayerData("Popcorn"),
    // LayerData("Tezo")
  ];

  Collection(this.name);

  void addToLayer(LayerData layer) {
    layers.add(layer);
  }

  void removeFromLayer(int index) {
    try {
      layers.removeAt(index);
    } catch (e) {
      debugPrint("Error from removeFromLayer(): " + e.toString());
    }
  }
}
