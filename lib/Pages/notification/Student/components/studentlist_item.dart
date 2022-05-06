import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../../utils/constants.dart';
import '../model/notificationmodel.dart';
import '../provider/studentlist.dart';

class StudentListItem extends StatelessWidget {
  final StudentListModel model;

  const StudentListItem({Key? key, required this.model}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Consumer<StudentNotification>(builder: (context, snapshot, child) {
      return Padding(
        padding: const EdgeInsets.only(left: 5, right: 5),
        child: ListTile(
          tileColor: model.selected == null || !model.selected!
              ? Colors.transparent
              : Colors.blueAccent.shade100,
          //selected: snapshot.isSelected(model),
          onTap: () => snapshot.selectItem(model),
          leading: Text(model.rollNo == null ? '0' : model.rollNo.toString()),
          title: Text(model.name),
          subtitle: Text(model.admissionNo ?? ""),
          trailing: model.selected == null || !model.selected!
              ? SvgPicture.asset(UIGuide.notcheck)
              : SvgPicture.asset(UIGuide.check),
        ),
      );
    });
  }
}
