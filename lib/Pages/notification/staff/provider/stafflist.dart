import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../utils/constants.dart';
import '../../messagepage.dart';
import '../model/notificationmodel.dart';

class StaffNotification with ChangeNotifier {
  int pageno = 1;

  String filtersDesignation = "";
  String filterCategory = "";

  addFilterCourse(String course) {
    filterCategory = course;
    notifyListeners();
  }

  addFilters(String f) {
    filtersDesignation = f;
  }

  clearAllFilters() {
    filtersDesignation = "";

    notifyListeners();
  }

  List<StaffListModel> stafflist = [];
  List<StaffListModel> selectedList = [];
  Future<bool> getStaffList({bool? loadmore}) async {
    if (loadmore == true) {
      pageno = pageno + 1;
    }

    SharedPreferences _pref = await SharedPreferences.getInstance();
    print(_pref.getString('accesstoken'));
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${_pref.getString('accesstoken')}'
    };
    var parsedResponse = await parseJWT();
    print(headers);
    var request = http.Request(
        'GET',
        Uri.parse(
            'https://api.schooltestonline.xyz/mobileapp/staffs/stafflist?page=$pageno'));
    request.body = json.encode({
      "SchoolId": _pref.getString('schoolId'),
      "AcademicyearId": parsedResponse['AcademicYearId']
    });
    print("${parsedResponse['AcademicYearId']}");
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      Map<String, dynamic> data =
          jsonDecode(await response.stream.bytesToString());

      List<StaffListModel> templist = List<StaffListModel>.from(
          data["staffs"].map((x) => StaffListModel.fromJson(x)));
      stafflist.addAll(templist);

      notifyListeners();
    } else {
      print(response.reasonPhrase);
    }

    return true;
  }

  bool isSelected(StaffListModel model) {
    StaffListModel selected =
        stafflist.firstWhere((element) => element.staffId == model.staffId);
    return selected.selected ??= false;
  }

  void selectItem(StaffListModel model) {
    StaffListModel selected =
        stafflist.firstWhere((element) => element.staffId == model.staffId);

    if (selected.selected == null) {
      selected.selected = true;
    } else {
      selected.selected = !selected.selected!;
    }
    StaffListModel? selectedListItem = selectedList
        .firstWhereOrNull((element) => element.staffId == model.staffId);

    if (selectedListItem == null) {
      selectedList.add(model);
      print("adding to selected list");
    }

    notifyListeners();
  }

  submit(
    BuildContext context,
  ) {
    List<StaffListModel> tempList = [];
    tempList.addAll(selectedList);
    print(tempList.length);
    selectedList.clear();
    if (tempList.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Please select ...')));
    } else {
      print('v ${tempList.map((e) => e.staffId).toList().length}');
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) => MessagePage(
                    toList: tempList.map((e) => e.staffId).toList(),
                    type: "Staff",
                  )));
    }
  }
}
