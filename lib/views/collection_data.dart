import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:get/get.dart';
import 'package:nft_proper_project/controllers/controller.dart';
import 'package:nft_proper_project/models/collection_data.dart';
import 'package:nft_proper_project/models/dropped_file.dart';
import 'package:nft_proper_project/models/layer_data.dart';

class CollectionsData extends StatelessWidget {
  CollectionsData({Key? key}) : super(key: key);
  final Controller c = Get.put(Controller());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Expanded(
          child: Padding(
            padding: EdgeInsets.all(18),
            child: Column(
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: c.project.value.collections.length,
                  itemBuilder: (BuildContext context, int index) {
                    return collectionDetail(index);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget collectionDetail(int collectionID) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                    hintText: c.project.value.collections[collectionID].name),
              ),
            ),
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                    hintText: c
                        .project.value.collections[collectionID].collectionSize
                        .toString()),
              ),
            ),
          ],
        ),

        //ToDo
        Row(
          children: [
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: Text("Layers:"),
            ),
            Flexible(flex: 8, child: reodarableList(collectionID)),
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: IconButton(
                  onPressed: () {
                    c.project.update((val) {
                      val?.collections[collectionID]
                          .addToLayer(LayerData("New Collection"));
                    });
                    print('collectionID: ${collectionID}');
                    populate();
                  },
                  icon: const Icon(Icons.add_circle_outline_rounded)),
            )
          ],
        ),
        Dropzone(),

        //layerInfo()
      ],
    );
  }

  //TextEditingController _controller = TextEditingController();

  List<List<TextEditingController>> _controllers = [];

  void populate() {
    _controllers = List.generate(
        c.project.value.collections.length,
        (index) => List.generate(
            c.project.value.collections[index].layers.length,
            (e) => TextEditingController()));
  }

  Widget reodarableList(int collectionID) {
    List<Widget> theChildren = [
      for (int i = 0;
          i < c.project.value.collections[collectionID].layers.length;
          i++)
        ReorderableDragStartListener(
          key: Key("RDSL " + i.toString()),
          index: i,
          child: Builder(builder: (context) {
            return GestureDetector(
              onDoubleTap: () {
                Widget okButton = FlatButton(
                  child: Text("OK"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                );
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text(
                            '${c.project.value.collections[collectionID].layers[i].name}'),
                        content: Text("Dummy"),
                      );
                    }).then((val) {
                  _controllers[collectionID][i].clear();
                });
              },
              onTap: () {},
              child: DecoratedBox(
                decoration: BoxDecoration(border: Border.all()),
                child: Padding(
                    padding: const EdgeInsets.all(9.0),
                    child: Focus(
                      onFocusChange: (hasFocus) {
                        if (!hasFocus) {
                          _controllers[collectionID][i].clear();
                        }
                      },
                      child: TextField(
                        controller: _controllers[collectionID][i],
                        onChanged: (e) {
                          c.project.update((val) {
                            val!.collections[collectionID].layers[i].name = e;
                          });
                        },
                        enabled: true,
                        decoration: InputDecoration(
                            hintText:
                                '$i) ${c.project.value.collections[collectionID].layers[i].name}'),
                      ),
                    )),
              ),
            );
          }),
        ),
    ];

    final ScrollController scrollS = ScrollController();

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Scrollbar(
            hoverThickness: 5,
            thickness: 5,
            controller: scrollS,
            showTrackOnHover: true,
            isAlwaysShown: false,
            child: SizedBox(
              height: 80.0,
              width: context.width,
              child: ScrollConfiguration(
                behavior: MyCustomScrollBehavior(),
                child: ReorderableListView(
                  padding: EdgeInsets.all(18.0),
                  scrollController: scrollS,
                  itemExtent: context.width / 5,
                  //physics: AlwaysScrollableScrollPhysics(),
                  buildDefaultDragHandles: false,
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  children: theChildren,
                  onReorder: (int oldIndex, int newIndex) {
                    if (oldIndex < newIndex) {
                      newIndex -= 1;
                    }

                    c.project.update((val) {
                      var item = val?.collections[collectionID].layers
                          .removeAt(oldIndex);
                      val?.collections[collectionID].layers
                          .insert(newIndex, item!);
                    });
                  },
                ),
              ),
            ));
      },
    );
  }

  // Widget layerInfo() {
  //   return LayoutBuilder(
  //     builder: (BuildContext context, BoxConstraints constraints) {
  //       return Center(
  //         child: OutlinedButton(
  //           onPressed: () {
  //             Navigator.of(context).restorablePush(_dialogBuilder());
  //           },
  //           child: const Text('Open Window'),
  //         ),
  //       );
  //     },
  //   );
  // }

  static Route<Object?> _dialogBuilder(
      BuildContext context, Object? arguments) {
    return DialogRoute<void>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        content: Container(
          color: Colors.yellow,
          child: Column(
            children: [Text("Hello World"), Text("Dropzone")],
          ),
        ),
      ),
    );
  }
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        // etc.
      };
}

class Dropzone extends StatefulWidget {
  const Dropzone({Key? key}) : super(key: key);

  @override
  _DropzoneState createState() => _DropzoneState();
}

class _DropzoneState extends State<Dropzone> {
  DroppedFile? file;
  List<DroppedFile> files = [];
  
  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //DroppedFileWidget(file: files),
            DroppedFileWidgets(file: this.files,),
            const SizedBox(height: 16,),
            Container(
              height: 300,
              child: DropzoneWidget(
                onDroppedFile: (file) => setState(() => this.files.add(file)),
              ),
            ),
          ],
        ),
      );
  }
}

class DropzoneWidget extends StatefulWidget {
  final ValueChanged<DroppedFile> onDroppedFile;

  const DropzoneWidget({Key? key, required this.onDroppedFile})
      : super(key: key);

  @override
  _DropzoneWidgetState createState() => _DropzoneWidgetState();
}

class _DropzoneWidgetState extends State<DropzoneWidget> {
  late DropzoneViewController controller;

  @override
  Widget build(BuildContext context) {
    final colorButton = Colors
        .red.shade300; //Change the choose file button highlight to green

    return Container(
      color: Colors.red[50], //Create a green container
      child: Stack(
        children: [
          DropzoneView(
              onCreated: (controller) => this.controller = controller,
              onDrop: acceptFile),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.cloud_upload,
                  size: 80,
                  color: Colors.black87,
                ),
                Text(
                  "Drag and drop your files here",
                  style: TextStyle(color: Colors.black87, fontSize: 24),
                ),
                SizedBox(height: 16),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                      padding:
                          EdgeInsets.symmetric(horizontal: 64, vertical: 16),
                      primary: colorButton,
                      shape: RoundedRectangleBorder()),
                  icon: Icon(Icons.search, size: 32),
                  label: Text("Choose Files",
                      style: TextStyle(color: Colors.white, fontSize: 32)),
                  onPressed: () async {
                    final events = await controller.pickFiles();

                    if (events.isEmpty) return;

                    acceptFile(events.first);
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Future acceptFile(dynamic event) async {
    final name = event.name;
    final mime = await controller.getFileMIME(event);
    final bytes = await controller.getFileSize(event);
    final url = await controller.createFileUrl(event);
    final rarity = await controller.getFileSize(event);

    print('Name: $name');
    print('Mime: $mime');
    print('Bytes: $bytes');
    print('URL: $url');
    print('Rarity: $rarity');

    final droppedFile = DroppedFile(
        //Create model from data class in model folder
        url: url,
        name: name,
        mime: mime,
        bytes: bytes,
        rarity: rarity.toDouble());

    widget.onDroppedFile(droppedFile);
  }
}

class DroppedFileWidgets extends StatefulWidget {
  List<DroppedFile>? file = [];

  DroppedFileWidgets({Key? key, required this.file}) : super(key: key);

  @override
  _DroppedFileWidgetsState createState() => _DroppedFileWidgetsState();
}

class _DroppedFileWidgetsState extends State<DroppedFileWidgets> {
  @override
  Widget build(BuildContext context) {
    return Row(
        children: widget.file!
            // ignore: unnecessary_new
            .map((e) => new Image.network(
                  e.url,
                  width: 120,
                  height: 120,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, _) =>
                      buildEmptyFile('No Preview'),
                ))
            .toList());
  }

  Widget buildImage() {
    return buildEmptyFile('No File');
  }

  Widget buildEmptyFile(String text) {
    return Container(
      width: 120,
      height: 120,
      color: Colors.blue.shade300,
      child: Center(
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  Widget buildFileDetails(DroppedFile file) {
    final style = TextStyle(fontSize: 20);

    return Container(
      margin: EdgeInsets.only(left: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(file.name, style: style.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(
            height: 8,
          ),
          Text(file.mime, style: style),
          const SizedBox(
            height: 8,
          ),
          Text(file.size, style: style),
          const SizedBox(
            height: 8,
          )
        ],
      ),
    );
  }
}

class DroppedFileWidget extends StatelessWidget {
  final DroppedFile? file;

  const DroppedFileWidget({Key? key, required this.file}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        buildImage(),
         if (file != null) buildFileDetails(file!),
      ],
    );
  }

  Widget buildImage() {
    if (file == null) return buildEmptyFile('No File');

    return Image.network(
      file!.url,
      width: 120,
      height: 120,
      fit: BoxFit.cover,
      errorBuilder: (context, error, _) => buildEmptyFile('No Preview'),
    );
  }

  Widget buildEmptyFile(String text) {
    return Container(
      width: 120,
      height: 120,
      color: Colors.blue.shade300,
      child: Center(
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  Widget buildFileDetails(DroppedFile file){
    final style = TextStyle(fontSize: 20);

    return Container(
      margin: EdgeInsets.only(left: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(file.name, style: style.copyWith(fontWeight: FontWeight.bold)), 
          const SizedBox(height: 8,),
           Text(file.mime, style: style), 
          const SizedBox(height: 8,),
           Text(file.size, style: style), 
          const SizedBox(height: 8,)
        ],
      ),
    );
  }
}


