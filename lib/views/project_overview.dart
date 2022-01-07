import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nft_proper_project/controllers/controller.dart';

class ProjectOverview extends StatelessWidget {
  ProjectOverview({Key? key}) : super(key: key);
  final Controller c = Get.find();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 60),
      child: Obx(
        () => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.25 * 0.75,
                child: TextField(
                  decoration: InputDecoration(
                    labelText: "Project Name",
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    hintText: c.project.value.name == ""
                        ? "Enter Your Project Name Here"
                        : c.project.value.name,
                  ),
                  onChanged: (e) => c.changeProjectName(e),
                ),
              ),
            ),
            Expanded(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.45 * 0.75,
                child: TextField(
                  decoration: InputDecoration(
                    labelText: "Project Description",
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    hintText: c.project.value.description == ""
                        ? "Enter Your Project Description Here"
                        : c.project.value.description,
                  ),
                  onChanged: (e) => c.changeProjectDescription(e),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
