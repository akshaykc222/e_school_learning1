import 'package:flutter/material.dart';

import '../../../../utils/constants.dart';
import 'notification_hitotry.dart';

class NotificationReportStaff extends StatelessWidget {
  final LoginType loginType;
  const NotificationReportStaff({Key? key, required this.loginType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: loginType == LoginType.staff ? 2 : 1,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: UIGuide.PRIMARY,
          title: const Text('Notification Report'),
          bottom: loginType == LoginType.staff
              ? const TabBar(tabs: [
                  Tab(
                    text: 'Received',
                  ),
                  Tab(
                    text: 'Sent',
                  ),
                ])
              : const TabBar(tabs: [
                  Tab(
                    text: 'Received',
                  ),
                ]),
        ),
        body: const TabBarView(children: [
          NotificationHistoryStaff(
            type: NotificationType.received,
          ),
          NotificationHistoryStaff(
            type: NotificationType.sent,
          ),
        ]),
      ),
    );
  }
}
