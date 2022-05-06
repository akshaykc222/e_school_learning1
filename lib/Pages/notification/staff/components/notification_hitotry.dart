import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../Student/provider/studentlist.dart';
import '../model/noit_reciev_model.dart';

enum NotificationType { received, sent }

class NotificationHistoryStaff extends StatelessWidget {
  final NotificationType type;
  const NotificationHistoryStaff({Key? key, required this.type})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      var p = Provider.of<StudentNotification>(context, listen: false);
      switch (type) {
        case NotificationType.received:
          p.getNotificationsReceived(context);
          break;
        case NotificationType.sent:
          print('received history getting');
          p.getNotifications(context);
          break;
      }
    });
    return Scaffold(
      body: Consumer<StudentNotification>(builder: (context, snapshot, child) {
        return snapshot.loading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : SizedBox(
                child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: snapshot.receivedList.length,
                    itemBuilder: (context, index) {
                      var item = snapshot.receivedList[index];
                      return HistoryCard(model: item);
                    }),
              );
      }),
    );
  }
}

class HistoryCard extends StatelessWidget {
  final NotificationReceivedModel model;
  const HistoryCard({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    model.title,
                    style: Theme.of(context).textTheme.subtitle1?.copyWith(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    DateFormat('dd-MM-yyyy').format(model.createdDate),
                    style: Theme.of(context).textTheme.subtitle1?.copyWith(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                model.body,
                style: Theme.of(context)
                    .textTheme
                    .subtitle2
                    ?.copyWith(color: Colors.black),
              ),
            ),
          ),
          Row(
            children: [Chip(label: Text('From ${model.fromStaff}'))],
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'To',
              style: Theme.of(context)
                  .textTheme
                  .subtitle1
                  ?.copyWith(fontWeight: FontWeight.bold, color: Colors.black),
            ),
          ),
          SizedBox(
            child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: model.toGuardian.isNotEmpty
                    ? model.toGuardian.length
                    : model.toStaff.isNotEmpty
                        ? model.toStaff.length
                        : model.toStudent.isNotEmpty
                            ? model.toStudent.length
                            : 0,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4),
                itemBuilder: (context, index) {
                  String name = "";
                  if (model.toStudent.isNotEmpty) {
                    name = model.toStudent[index];
                  } else if (model.toStaff.isNotEmpty) {
                    name = model.toStaff[index];
                  } else if (model.toGuardian.isNotEmpty) {
                    name = model.toGuardian[index];
                  }
                  return Chip(
                    label: Text(name),
                    backgroundColor: Colors.green,
                  );
                }),
          )
        ],
      ),
    );
  }
}
