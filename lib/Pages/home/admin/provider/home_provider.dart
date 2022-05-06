import 'package:ess_plus/Pages/LoginPageWeb.dart';
import 'package:flutter/material.dart';

import '../../../../utils/constants.dart';
import '../../../notification/Student/body.dart';
import '../../../notification/staff/body.dart';
import '../../../notification/staff/components/notification_report_staff.dart';
import '../../body.dart';

class HomeProvider with ChangeNotifier {
  bool expand = false;
  setExpanded() {
    expand = !expand;
    notifyListeners();
  }

  MenuItem? selectedMenumodel;
  setselectedMenumodel(MenuItem model) {
    selectedMenumodel = model;
    expand = true;
    notifyListeners();
  }

  List<SubMenu> subMenulist = [
    SubMenu(
        groupName: "Notification",
        subMenu: "To Students",
        icon: const Icon(Icons.arrow_right),
        page: const StudentNotificationPage()),
    SubMenu(
      groupName: "Notification",
      subMenu: "To Staff",
      icon: const Icon(Icons.arrow_right),
      page: const StaffNotificationPage(),
    ),
    SubMenu(
        groupName: "Notification",
        subMenu: "Report",
        icon: const Icon(Icons.arrow_right),
        page: NotificationReportStaff(
          loginType: LoginType.staff,
        )),
    SubMenu(
        groupName: "Webview",
        subMenu: "Go to Webview",
        icon: const Icon(Icons.arrow_right),
        page: LoginPageWeb()),
  ];
}
