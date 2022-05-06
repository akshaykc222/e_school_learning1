import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../notification/Student/provider/studentlist.dart';

class StudentMessgaePage extends StatelessWidget {
  const StudentMessgaePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<StudentNotification>(builder: (context, snapshot, child) {
        return snapshot.recieveNotificationModel == null
            ? const Center(
                child: Text('No new notifications'),
              )
            : ListView.builder(
                itemCount: snapshot.recieveNotificationModel!.results.length,
                itemBuilder: (BuildContext context, int index) {
                  var data = snapshot.recieveNotificationModel?.results[index];
                  return ListTile(
                      // title: Text(data.),
                      );
                });
      }),
    );
  }
}
