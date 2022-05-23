 import 'dart:convert';

import 'package:flutter/material.dart';
 import 'package:http/http.dart'as http;
 import '../model/RecieveNitificationModel.dart';

 class NotificationHistoryBloc with ChangeNotifier {
   RecieveNotificationModel? recieveNotificationModel;

   void getNotification() async {
    var headers = {'Content-Type': 'application/json'};
     var request = http.Request('GET',
        Uri.parse('https://localhost:44311/mobileapp/token/receivedlist'));
     request.body = json.encode({
       "SchoolId": "bf32d094-3d40-44c2-9b77-0cc15a81cbc3",
       "AcademicyearId": "afa92288-ea86-474d-8a8b-4d21e8eb1f1d",
      "CreatedDate": "2022-03-03",
      "StaffGuardianStudId": "6f1b2f78-348e-40d3-987b-fc0f979a4fa7",
      "Type": "Staff"
      });
    request.headers.addAll(headers);

     http.StreamedResponse response = await request.send();

   if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
     } else {
       print(response.reasonPhrase);
     }
   }
 }
