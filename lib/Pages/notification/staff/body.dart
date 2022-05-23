import 'dart:core';

import 'package:ess_plus/Pages/notification/staff/provider/stafflist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../utils/constants.dart';
import 'components/stafflist_item.dart';

class StaffNotificationPage extends StatefulWidget {
  const StaffNotificationPage({Key? key}) : super(key: key);

  @override
  _StaffNotificationPageState createState() => _StaffNotificationPageState();
}

class _StaffNotificationPageState extends State<StaffNotificationPage> {
  var scrollcontroller = ScrollController();

  final spinkit = const SpinKitRotatingCircle(
    color: Colors.white,
    size: 50.0,
  );

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      var pv=Provider.of<StaffNotification>(context, listen: false);
          pv.getStaffList(loadmore: false);
          pv.clearAllFilters();
          pv.selectedList.clear();
    });
    scrollcontroller.addListener(() {
      if (scrollcontroller.position.pixels ==
          scrollcontroller.position.maxScrollExtent) {
        print("Loading");
        Provider.of<StaffNotification>(context, listen: false)
            .getStaffList(loadmore: true);
      }
    });
  }

  final staffController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    bool _isChecked = false;

    return Scaffold(
      appBar: AppBar(
        title: Text("Notification To Staffs"),
        backgroundColor: UIGuide.PRIMARY,
      ),
      body: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Consumer<StaffNotification>(builder: (context, snap, child) {
            return Column(children: [
              Container(
                // color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Row(children: [
                    // Expanded(
                    //   child: Padding(
                    //     padding: const EdgeInsets.only(right: 8.0),
                    //     child: Consumer<StaffNotification>(
                    //         builder: (context, snapshot, child) {
                    //       return DropdownSearch<String>.multiSelection(
                    //         label: "Category",
                    //         mode: Mode.DIALOG,
                    //         popupTitle: const Padding(
                    //           padding: EdgeInsets.all(8.0),
                    //           child: Text("Select Category "),
                    //         ),
                    //         showSearchBox: true,
                    //         showSelectedItems: true,
                    //         items: snapshot.stafflist
                    //             .map((e) => e.staffRole ?? "")
                    //             .toSet()
                    //             .toList(),
                    //       );
                    //     }),
                    //   ),
                    // ),

                    // Expanded(
                    //     child: Padding(
                    //   padding: const EdgeInsets.only(left: 2),
                    //   child: RawMaterialButton(
                    //     onPressed: () async {
                    //       Provider.of<StaffNotification>(context, listen: false)
                    //           .clearSaffList(StaffListItem);
                    //       showDialog(
                    //           context: context,
                    //           builder: (context) {
                    //             return spinkit;
                    //           });
                    //       await Provider.of<StaffNotification>(context,
                    //               listen: false)
                    //           .getStaffList();
                    //       Navigator.pop(context);
                    //     },
                    //     elevation: 2.0,
                    //     fillColor: UIGuide.PRIMARY,
                    //     child: const Text(
                    //       "View",
                    //       style: TextStyle(
                    //         fontSize: 20,
                    //         color: Colors.white,
                    //       ),
                    //     ),
                    //     padding: EdgeInsets.all(20.0),
                    //     shape: CircleBorder(),
                    //   ),
                    // )),
                  ]),
                ),
              ),

              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Name",
                          style: TextStyle(
                              fontSize: 22,
                              color: UIGuide.PRIMARY,
                              fontWeight: FontWeight.bold),
                        ),
                        Consumer<StaffNotification>(
                          builder: (context, snap, child) {
                            return InkWell(
                              onTap: () {
                                snap.selectAllStaff();
                              },
                              child: snap.isSelectAllStaff
                                  ? SvgPicture.asset(UIGuide.check)
                                  : SvgPicture.asset(UIGuide.notcheck),
                            );
                          },
                        ),
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.75,
                child: Consumer<StaffNotification>(
                  builder: (context, value, child) {
                    return ListView.builder(
                      controller: scrollcontroller,
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: false,
                      itemCount: value.stafflist.isEmpty
                          ? 0
                          : value.stafflist.length + 1,
                      itemBuilder: (BuildContext context, int index) {
                        return value.stafflist.length == index
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            : StaffListItem(model: value.stafflist[index]);
                      },
                    );
                  },
                ),
              ),
              // SizedBox(
              //   width: 300,
              //   height: 50,
              //   child: ElevatedButton(
              //     child: const Text('Proceed'),
              //     onPressed: () {
              //       Provider.of<StaffNotification>(context, listen: false)
              //           .submit(context);
              //     },
              //     style: ElevatedButton.styleFrom(
              //         primary: UIGuide.PRIMARY,
              //         padding: EdgeInsets.all(8),
              //         textStyle:
              //             TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              //   ),
              // ),
            ]);
          }),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: new Row(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 90, bottom: 10),
              child: SizedBox(
                width: 200,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: UIGuide.PRIMARY,
                    elevation: 20.0,
                  ),

                  child: const Text(
                    'PROCEED',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w700),
                  ),
                  onPressed: () {
                    Provider.of<StaffNotification>(context, listen: false)
                        .submit(context);
                  },
                  // style: ElevatedButton.styleFrom(
                  //     primary: Colors.white,
                  //     padding: const EdgeInsets.all(8),
                  //     textStyle: const TextStyle(
                  //         fontSize: 20, fontWeight: FontWeight.bold)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
