import 'dart:convert';
import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../utils/constants.dart';

class LoginProvider with ChangeNotifier {
  Future getToken(BuildContext context) async {
    Map<String, dynamic> data = await parseJWT();
    SharedPreferences _pref = await SharedPreferences.getInstance();
    print(_pref.getString('accesstoken'));
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${_pref.getString('accesstoken')}'
    };
    print("header: ${headers}");
    String? token = await FirebaseMessaging.instance.getToken();
    print("firebase token");
    // print(token);
    var request = http.Request(
        'POST', Uri.parse('${UIGuide.baseURL}/mobileapp/token/saveusertoken'));
    request.headers.addAll(headers);
    request.body = json.encode({
      "SchoolId": data["SchoolId"],
      "AcademicyearId": data["AcademicYearId"],
      "MobileToken": token,
      "StaffId": data.containsKey('StaffId') ? data['StaffId'] : null,
      "StudentPresentDetailsId":
          data.containsKey('PresentDetailId') ? data["PresentDetailId"] : null,
      "GuardianId": data['GuardianId'],
      "Type": data['role'] == "Guardian" ? "Student" : "Staff"
    });

    http.StreamedResponse response = await request.send();
    print('${UIGuide.baseURL}/mobileapp/token/saveusertoken');
    if (response.statusCode == 200) {
      log("student Token added");
      // debugPrint(await response.stream.bytesToString());
    } else {
      log("student not added");
      debugPrint(response.reasonPhrase);
    }
  }
}
