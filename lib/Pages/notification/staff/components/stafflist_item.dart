import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../../utils/constants.dart';
import '../model/notificationmodel.dart';
import '../provider/stafflist.dart';

class StaffListItem extends StatelessWidget {
  final StaffListModel model;

  const StaffListItem({Key? key, required this.model}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Consumer<StaffNotification>(builder: (context, snapshot, child) {
      return ListTile(
        tileColor: model.selected == null
            ? Colors.transparent
            : model.selected != null && model.selected == true
                ? UIGuide.PRIMARY2
                : Colors.transparent,
        selected: snapshot.isSelected(model),
        onTap: () => snapshot.selectItem(model),
        title: Text(
          model.name,
          style: const TextStyle(
            fontSize: 18,
          ),
        ),
        trailing: model.selected != null && model.selected!
            ? SvgPicture.asset(UIGuide.check)
            : SvgPicture.asset(UIGuide.notcheck),
      );
    });
  }
}
