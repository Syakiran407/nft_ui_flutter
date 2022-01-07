import 'package:get/get.dart';
import 'package:nft_proper_project/models/collection_data.dart';
import 'package:nft_proper_project/models/project_data.dart';

class Controller extends GetxController {
  var project = ProjectData("", "").obs;
  var dummy = <String>[].obs;

  updateDummy(int index, String value) {
    if (index < dummy.length) {
      for (int i = 0; i < dummy.length - 1; i++) {
        dummy.add("");
      }
      dummy.add(value);
    }
  }

  changeProjectName(String projectName) {
    project.update((val) {
      val?.name = projectName;
    });
  }

  changeProjectDescription(String projectDescription) {
    project.update((val) {
      val?.description = projectDescription;
    });
  }

  addCollection(Collection newCollection) {
    project.update((val) {
      val?.collections.add(newCollection);
    });
  }

  removeCollection(int index) {
    project.update((val) {
      val?.collections.removeAt(index);
    });
  }

  removeLastCollection() {
    project.update((val) {
      val?.collections.removeLast();
    });
  }

  changeTotalCollectionSize(int newSize) {
    project.update((val) {
      val?.totalCollectionSize = newSize;
    });
  }
}
