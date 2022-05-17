import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

import '../../utils/constants.dart';
import '../notification/staff/components/notification_hitotry.dart';

class StudentHomePage extends StatefulWidget {
  @override
  State<StudentHomePage> createState() => _StudentHomePageState();
}

class _StudentHomePageState extends State<StudentHomePage> {
  final ScrollController _scrollController = ScrollController();

  _scrollToBottom() {
    _scrollController.animateTo(_scrollController.position.maxScrollExtent,
        duration: const Duration(seconds: 30), curve: Curves.linear);
  }

  List menuList = [
    _MenuItem(
      UIGuide.notification,
      'Notification',
      const NotificationHistoryStaff(
        type: NotificationType.received,
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance!.addPostFrameCallback((_) => _scrollToBottom());
    String val = '''
1.School Annual day will be hold on 10-01-2022.

2.Last date for CBSE online registration is postponed to 05-01-2022.
3.Cbse Model exams will bes starts on 11-02-2022.
''';
    return Scaffold(
      body: Stack(children: [
        const HeaderWidget(),
        Positioned(
            top: MediaQuery.of(context).size.width / 5,
            left: MediaQuery.of(context).size.width / 6,
            child: Image.asset(
              UIGuide.board,
              fit: BoxFit.fill,
              height: MediaQuery.of(context).size.height / 3.2,
              width: MediaQuery.of(context).size.width / 1.5,
            )),
        Positioned(
          top: MediaQuery.of(context).size.height / 7.5,
          left: MediaQuery.of(context).size.width / 4.8,
          right: MediaQuery.of(context).size.width / 6,
          child: SingleChildScrollView(
            controller: _scrollController,
            child: SizedBox(
              width: MediaQuery.of(context).size.width / 3,
              height: MediaQuery.of(context).size.height / 4,
              child: Padding(
                  padding: const EdgeInsets.only(left: 4.0, right: 6.0),
                  child: AnimatedTextKit(
                    animatedTexts: [
                      TypewriterAnimatedText(
                        val,
                        textStyle: const TextStyle(
                          color: Colors.white,
                          overflow: TextOverflow.ellipsis,
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                        ),
                        speed: const Duration(milliseconds: 200),
                      ),
                    ],

                    totalRepeatCount: 4,
                    //pause: const Duration(milliseconds: 100),
                    displayFullTextOnTap: true,
                    stopPauseOnTap: true,
                  )),
            ),
          ),
        ),
        DraggableScrollableSheet(
          initialChildSize: .65,
          minChildSize: .65,
          maxChildSize: .8,
          builder: (BuildContext context, ScrollController scrollController) {
            return Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(0.0, 1.0), //(x,y)
                    blurRadius: 6.0,
                  ),
                ],
              ),
              child: GridView.builder(
                controller: scrollController,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4),
                itemBuilder: (context, position) {
                  return InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => menuList[position].page));
                      },
                      child: Center(
                        child: Column(
                          children: [
                            Center(
                              child: InkWell(
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(100.0)),
                                  elevation: 5,
                                  child: Container(
                                    padding: const EdgeInsets.all(10),
                                    width: 60,
                                    height: 60,
                                    child: Image.asset(
                                      menuList[position].image,
                                      // width: 10,
                                      // height: 10,

                                      //color: UIGuide.PRIMARY,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              alignment: Alignment.bottomCenter,
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Text(
                                  menuList[position].title,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(color: UIGuide.PRIMARY
                                      //fontWeight: FontWeight.bold
                                      ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ));
                },
                itemCount: menuList.length,
              ),
            );
          },
        ),
      ]),
    );
  }
}

class _MenuItem {
  final String image;
  final String title;
  final Widget page;

  _MenuItem(this.image, this.title, this.page);
}

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 50),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: const [
          Text(
            "Student",
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: UIGuide.PRIMARY),
          ),
          CircleAvatar(
              radius: 25,
              backgroundColor: UIGuide.PRIMARY2,
              backgroundImage: AssetImage(UIGuide.student)),
          InkWell(child: Icon(Icons.arrow_drop_down)),
        ],
      ),
    );
  }
}
