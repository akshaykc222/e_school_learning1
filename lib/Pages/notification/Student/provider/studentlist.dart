import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../Constants.dart';
import '../../../../utils/constants.dart';
import '../../../home/model/RecieveNitificationModel.dart';
import '../../messagepage.dart';
import '../../staff/model/noit_reciev_model.dart';
import '../model/notificationmodel.dart';

class StudentNotification with ChangeNotifier {
  int pageno = 1;

  //studentlist

  String filtersDivision = "";
  String filterCourse = "";

  addFilterCourse(String course) {
    filterCourse = course;
    notifyListeners();
  }

  addFilters(String f) {
    filtersDivision = f;
  }

  clearAllFilters() {
    filtersDivision = "";
    filterCourse = "";

    notifyListeners();
  }

  List<StudentListModel> studentlist = [];
  Future<bool> getStudenList({bool? loadmore}) async {
    if (loadmore == true) {
      pageno = pageno + 1;
    } else {
      studentlist.clear();
      pageno = 0;
    }
    SharedPreferences _pref = await SharedPreferences.getInstance();
    // print(_pref.getString('token'));
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${_pref.getString('accesstoken')}'
    };
    print(headers);
    var parsedResponse = await parseJWT();

    print(
        'https://$baseUrl/mobileapp/students/studentlist?page=$pageno&searchDivision=$filtersDivision&searchCourse=$filterCourse');
    var request = http.Request(
        'GET',
        Uri.parse(
            'https://$baseUrl/mobileapp/students/studentlist?page=$pageno&searchDivision=$filtersDivision&searchCourse=$filterCourse'));

    request.body = json.encode({
      "SchoolId": _pref.getString('schoolId'),
      "AcademicyearId": parsedResponse['AcademicYearId']
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      Map<String, dynamic> data =
          jsonDecode(await response.stream.bytesToString());
      //print(await response.stream.bytesToString());
      print(data);

      List<StudentListModel> templist = List<StudentListModel>.from(
          data["results"].map((x) => StudentListModel.fromJson(x)));
      studentlist.addAll(templist);
      //studentlist.sort((a, b) => a.rollNo?.compareTo(b.rollNo?));

      notifyListeners();
    } else {
      print(response.reasonPhrase);
    }
    return true;
  }

//course list

  List<CourseList> courselist = [];
  Future<bool> getCourseList({bool? loadmore}) async {
    if (loadmore == true) {
      pageno = pageno + 1;
    }
    SharedPreferences _pref = await SharedPreferences.getInstance();
    print(_pref.getString('token'));
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${_pref.getString('accesstoken')}'
    };
    var request = http.Request(
        'GET', Uri.parse('${UIGuide.baseURL}/mobileapp/common/courselist'));
    request.body = json.encode({"SchoolId": _pref.getString('schoolId')});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      Map<String, dynamic> data =
          jsonDecode(await response.stream.bytesToString());
      //print(await response.stream.bytesToString());
      print(data);

      List<CourseList> templist = List<CourseList>.from(
          data["courseList"].map((x) => CourseList.fromJson(x)));
      courselist.addAll(templist);

      notifyListeners();
    } else {
      print(response.reasonPhrase);
    }
    return true;
  }

//divison list

  List<DivisionList> divisionlist = [];
  Future<bool> getDivisionList({bool? loadmore}) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    print(_pref.getString('token'));
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${_pref.getString('accesstoken')}'
    };
    var request = http.Request(
        'GET',
        Uri.parse(
            'https://api.schooltestonline.xyz/mobileapp/common/divisionlist'));
    request.body = json.encode({"SchoolId": _pref.getString('schoolId')});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      Map<String, dynamic> data =
          jsonDecode(await response.stream.bytesToString());
      //print(await response.stream.bytesToString());
      print(data);

      List<DivisionList> templist = List<DivisionList>.from(
          data["divisionList"].map((x) => DivisionList.fromJson(x)));
      divisionlist.addAll(templist);

      notifyListeners();
    } else {
      print(response.reasonPhrase);
    }
    return true;
  }

  bool isSelected(StudentListModel model) {
    StudentListModel selected = studentlist
        .firstWhere((element) => element.admissionNo == model.admissionNo);
    return selected.selected!;
  }

  void selectItem(StudentListModel model) {
    StudentListModel selected = studentlist
        .firstWhere((element) => element.admissionNo == model.admissionNo);
    if (selected.selected == null) {
      selected.selected = false;
    }
    selected.selected = !selected.selected!;
    print(selected.toJson());
    notifyListeners();
  }

  bool isselectAll = false;
  void selectAll() {
    if (studentlist.first.selected == true) {
      studentlist.forEach((element) {
        element.selected = false;
      });
      isselectAll = false;
    } else {
      studentlist.forEach((element) {
        element.selected = true;
      });
      isselectAll = true;
    }

    notifyListeners();
  }

  List<StudentListModel> selectedList = [];
  submitStudent(BuildContext context) {
    selectedList.clear();
    selectedList =
        studentlist.where((element) => element.selected == true).toList();
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => MessagePage(
                  toList: selectedList.map((e) => e.presentDetailsId).toList(),
                  type: "Student",
                )));
  }

  RecieveNotificationModel? recieveNotificationModel;
  List<NotificationReceivedModel> receivedList = [];
  bool loading = false;
  getNotifications(BuildContext context) async {
    receivedList.clear();
    loading = true;
    notifyListeners();
    Map<String, dynamic> data = await parseJWT();
    SharedPreferences _pref = await SharedPreferences.getInstance();
    print(_pref.getString('token'));
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${_pref.getString('accesstoken')}'
    };
    var request = http.Request(
        'GET', Uri.parse('${UIGuide.baseURL}/mobileapp/token/receivedlist'));
    request.body = json.encode({
      "SchoolId": data["SchoolId"],
      "AcademicyearId": data["AcademicYearId"],
      "CreatedDate": DateFormat('yyyy-MM-dd').format(DateTime.now()),
      "StaffGuardianStudId": data['role'] == "Guardian"
          ? data['PresentDetailId']
          : data["StaffId"],
      "Type": data['role'] == "Guardian" ? "Student" : "Staff"
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      loading = false;
      notifyListeners();
      var data = jsonDecode(await response.stream.bytesToString());

      receivedList = List<NotificationReceivedModel>.from(
          data["results"].map((x) => NotificationReceivedModel.fromJson(x)));
      notifyListeners();
    } else {
      loading = false;
      notifyListeners();
      print(response.reasonPhrase);
    }
  }

  getNotificationsReceived(BuildContext context) async {
    loading = true;
    notifyListeners();
    Map<String, dynamic> data = await parseJWT();
    SharedPreferences _pref = await SharedPreferences.getInstance();
    print(_pref.getString('token'));
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${_pref.getString('accesstoken')}'
    };
    var request = http.Request(
        'GET', Uri.parse('${UIGuide.baseURL}/mobileapp/token/sentlist'));
    request.body = json.encode({
      "SchoolId": data["SchoolId"],
      "AcademicyearId": data["AcademicYearId"],
      "CreatedDate": DateFormat('yyyy-MM-dd').format(DateTime.now()),
      "StaffGuardianStudId": data['role'] == "Guardian"
          ? data['PresentDetailId']
          : data["StaffId"],
      "Type": data['role'] == "Guardian" ? "Student" : "Staff"
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      loading = false;
      notifyListeners();
      var data = jsonDecode(await response.stream.bytesToString());

      receivedList = List<NotificationReceivedModel>.from(
          data["results"].map((x) => NotificationReceivedModel.fromJson(x)));
      notifyListeners();
    } else {
      loading = false;
      notifyListeners();
      print(response.reasonPhrase);
    }
  }

  sendNotification(BuildContext context, String text, List<String> to,
      {required String sentTo}) async {
    Map<String, dynamic> data = await parseJWT();
    SharedPreferences _pref = await SharedPreferences.getInstance();
    print(_pref.getString('token'));
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${_pref.getString('accesstoken')}'
    };
    var request = http.Request('POST',
        Uri.parse('${UIGuide.baseURL}/mobileapp/token/saveusernotification'));
    print(Uri.parse('${UIGuide.baseURL}/mobileapp/token/saveusernotification'));
    request.body = json.encode({
      "SchoolId": data["SchoolId"],
      "AcademicyearId": data["AcademicYearId"],
      "Title": "Notification",
      "Body": text,
      "FromStaffId": data['role'] == "Guardian"
          ? data['PresentDetailId']
          : data["StaffId"],
      "SentTo": sentTo,
      "ToId": to,
      "IsSeen": false
    });
    print({
      "SchoolId": data["SchoolId"],
      "AcademicyearId": data["AcademicYearId"],
      "Title": "Student Notification",
      "Body": text,
      "FromStaffId": data['role'] == "Guardian"
          ? data['PresentDetailId']
          : data["StaffId"],
      "SentTo": sentTo,
      "ToId": to,
      "IsSeen": false
    });

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Notification Send Successfully")));
      debugPrint(await response.stream.bytesToString());
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Something Went Wrong")));
      debugPrint(response.reasonPhrase);
    }
  }

  List<CourseList> selectedCourse = [];

  addSelectedCourse(CourseList item) {
    if (selectedCourse.contains(item)) {
      print("removing");
      selectedCourse.remove(item);
      notifyListeners();
    } else {
      print("adding");
      selectedCourse.add(item);
      notifyListeners();
    }
    clearAllFilters();
    addFilterCourse(selectedCourse.first.name);
  }

  removeCourse(CourseList item) {
    selectedCourse.remove(item);
    notifyListeners();
  }

  removeCourseAll() {
    selectedCourse.clear();
    notifyListeners();
  }

  isCourseSelected(CourseList item) {
    if (selectedCourse.contains(item)) {
      return true;
    } else {
      return false;
    }
  }

  List<DivisionList> selectedDivision = [];

  addSelectedDivision(DivisionList item) {
    if (selectedDivision.contains(item)) {
      print("removing");
      selectedDivision.remove(item);
      notifyListeners();
    } else {
      print("adding");
      selectedDivision.add(item);
      notifyListeners();
    }
  }

  removeDivision(DivisionList item) {
    selectedDivision.remove(item);
    notifyListeners();
  }

  removeDivisionAll() {
    selectedDivision.clear();
    notifyListeners();
  }

  isDivisonSelected(DivisionList item) {
    if (selectedDivision.contains(item)) {
      return true;
    } else {
      return false;
    }
  }

  clearStudentList(StudentListItem) {
    studentlist.clear();
    notifyListeners();
  }
}
