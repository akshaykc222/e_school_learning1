import 'dart:core';

import 'package:ess_plus/Pages/notification/Student/provider/studentlist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../utils/constants.dart';
import 'components/studentlist_item.dart';

class StudentNotificationPage extends StatefulWidget {
  const StudentNotificationPage({Key? key}) : super(key: key);

  @override
  _StudentNotificationPageState createState() =>
      _StudentNotificationPageState();
}

class _StudentNotificationPageState extends State<StudentNotificationPage> {
  var scrollcontroller = ScrollController();

  final spinkit = const SpinKitRotatingCircle(
    color: Colors.white,
    size: 50.0,
  );

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      var p = Provider.of<StudentNotification>(context, listen: false);
      p.getStudenList(loadmore: false);
      p.clearAllFilters();
      p.removeCourseAll();
      p.getCourseList(loadmore: false);
      p.getDivisionList(loadmore: false);
    });
    scrollcontroller.addListener(() {
      if (scrollcontroller.position.pixels ==
          scrollcontroller.position.maxScrollExtent) {
        print("Loading");
        Provider.of<StudentNotification>(context, listen: false)
            .getStudenList(loadmore: true);
      }
    });
  }

  final courseController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    bool _isChecked = false;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Notification To Students"),
        backgroundColor: UIGuide.PRIMARY,
      ),
      body: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.only(top: 30.0),
          child: Consumer<StudentNotification>(builder: (context, snap, child) {
            return Column(children: [
              Container(
                // color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Row(children: [
                    SizedBox(
                      height: 60,
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: Consumer<StudentNotification>(
                          builder: (context, snapshot, child) {
                        return InkWell(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return Dialog(
                                    child: Consumer<StudentNotification>(
                                        builder: (context, snapshot, child) {
                                      return ListView.builder(
                                          itemCount: snapshot.courselist.length,
                                          itemBuilder: (context, index) {
                                            return ListTile(
                                              selectedTileColor:
                                                  Colors.blue.shade100,
                                              selectedColor: UIGuide.PRIMARY2,
                                              // selected: snapshot
                                              //     .isCourseSelected(snapshot
                                              //         .courselist[index]),
                                              onTap: () {
                                                courseController.text = snapshot
                                                    .courselist[index].name;
                                                snapshot.addSelectedCourse(
                                                    snapshot.courselist[index]);
                                                Navigator.of(context).pop();
                                              },
                                              title: Text(snapshot
                                                  .courselist[index].name),
                                            );
                                          });
                                    }),
                                  );
                                });
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: TextField(
                              controller: courseController,
                              decoration: InputDecoration(
                                labelText: "Course",
                                hintText: "Select Course",
                              ),
                              enabled: false,
                            ),
                          ),
                        );
                      }),
                    ),
                    // SizedBox(
                    //   height: 60,
                    //   width: MediaQuery.of(context).size.width * 0.4,
                    //   child: Consumer<StudentNotification>(
                    //       builder: (context, snapshot, child) {
                    //     return InkWell(
                    //       onTap: () {
                    //         showDialog(
                    //             context: context,
                    //             builder: (context) {
                    //               return Dialog(
                    //                 child: Consumer<StudentNotification>(
                    //                     builder: (context, snapshot, child) {
                    //                   return ListView.builder(
                    //                       itemCount:
                    //                           snapshot.divisionlist.length,
                    //                       itemBuilder: (context, index) {
                    //                         return ListTile(
                    //                           selectedTileColor:
                    //                               Colors.blue.shade100,
                    //                           selectedColor: UIGuide.PRIMARY2,
                    //                           selected: snapshot
                    //                               .isDivisonSelected(snapshot
                    //                                   .divisionlist[index]),
                    //                           onTap: () {
                    //                             snapshot.addSelectedDivision(
                    //                                 snapshot
                    //                                     .divisionlist[index]);
                    //                           },
                    //                           title: Text(snapshot
                    //                               .divisionlist[index].name),
                    //                         );
                    //                       });
                    //                 }),
                    //               );
                    //             });
                    //       },
                    //       child: Padding(
                    //         padding: const EdgeInsets.all(5.0),
                    //         child: TextField(
                    //           decoration: InputDecoration(
                    //             labelText: "Division",
                    //             hintText: "Select Division",
                    //           ),
                    //           enabled: false,
                    //         ),
                    //       ),
                    //     );
                    //   }),
                    // ),

                    // return DropdownSearch<String>.multiSelection(
                    //   label: "Course",
                    //   mode: Mode.DIALOG,
                    //   popupTitle: const Padding(
                    //     padding: EdgeInsets.all(8.0),
                    //     child: Text("Select Course"),
                    //   ),
                    //   showSearchBox: true,
                    //   onChanged: (List<String> val) {
                    //     snapshot.clearAllFilters();
                    //     snapshot.addFilterCourse(val.first);
                    //   },
                    //   //showSelectedItems: false,
                    //   items: snapshot.courselist
                    //       .map((e) => e.name)
                    //       .toSet()
                    //       .toList(),
                    // );

                    // SizedBox(
                    //   height: 60,
                    //   width: MediaQuery.of(context).size.width * 0.4,
                    //   child: Padding(
                    //     padding: const EdgeInsets.only(left: 10),
                    //     child: Consumer<StudentNotification>(
                    //         builder: (context, snapshot, child) {
                    //       return DropdownSearch<String>.multiSelection(
                    //         label: "Divison",
                    //         mode: Mode.DIALOG,
                    //         popupTitle: const Text("Select Divison"),
                    //         showSearchBox: true,
                    //         onChanged: (List<String> val) {
                    //           snapshot.addFilters(val.first);
                    //         },
                    //         showSelectedItems: true,
                    //         items: snapshot.divisionlist
                    //             .map((e) => e.name)
                    //             .toSet()
                    //             .toList(),
                    //       );
                    //     }),
                    //   ),
                    // ),
                    Expanded(
                        child: Padding(
                      padding: const EdgeInsets.only(left: 2),
                      child: RawMaterialButton(
                        onPressed: () async {
                          Provider.of<StudentNotification>(context,
                                  listen: false)
                              .clearStudentList(StudentListItem);
                          showDialog(
                              context: context,
                              builder: (context) {
                                return spinkit;
                              });
                          await Provider.of<StudentNotification>(context,
                                  listen: false)
                              .getStudenList(loadmore: false);
                          Navigator.pop(context);
                        },
                        elevation: 2.0,
                        fillColor: UIGuide.PRIMARY,
                        child: const Text(
                          "View",
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                          ),
                        ),
                        padding: const EdgeInsets.all(16.0),
                        shape: const CircleBorder(),
                      ),
                    )),
                  ]),
                ),
              ),

              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Roll.No",
                          style: TextStyle(
                              fontSize: 20,
                              color: UIGuide.PRIMARY,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "Name",
                          style: TextStyle(
                              fontSize: 20,
                              color: UIGuide.PRIMARY,
                              fontWeight: FontWeight.bold),
                        ),
                        InkWell(
                            onTap: () {
                              snap.selectAll();
                            },
                            child: SvgPicture.asset(UIGuide.notcheck)),
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.65,
                child: Consumer<StudentNotification>(
                  builder: (context, value, child) {
                    return ListView.builder(
                      controller: scrollcontroller,
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: false,
                      itemCount: value.studentlist.length == 0
                          ? 0
                          : value.studentlist.length,
                      itemBuilder: (BuildContext context, int index) {
                        return StudentListItem(model: value.studentlist[index]);
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
              //       Provider.of<StudentNotification>(context, listen: false)
              //           .submitStudent(context);
              //     },
              //     style: ElevatedButton.styleFrom(
              //         primary: UIGuide.PRIMARY,
              //         padding: const EdgeInsets.all(8),
              //         textStyle: const TextStyle(
              //             fontSize: 20, fontWeight: FontWeight.bold)),
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
                    Provider.of<StudentNotification>(context, listen: false)
                        .submitStudent(context);
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
