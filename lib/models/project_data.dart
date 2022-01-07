import 'package:nft_proper_project/models/collection_data.dart';

class ProjectData{
  String name = "";
  String description = "";
  int totalCollectionSize = 1000;
  int uniqueCollectionSize = 1;
  List<Collection> collections = [Collection("New Collection")];

  ProjectData(this.name, this.description);

  void setName(String newName){
    name = newName;
  }
}