import 'package:nft_proper_project/models/dropped_file.dart';

class LayerData {
  String name = "";
  List<DroppedFile> images = [];

  LayerData(this.name);

  void addImage(DroppedFile input){
    images.add(input);
  }

  void removeImage(int index){
    images.removeAt(index);
  }
}