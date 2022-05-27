import 'dart:ui';
import 'package:ess_plus/Pages/LoginPageWeb.dart';
import 'package:ess_plus/Pages/home/body.dart';
import 'package:ess_plus/Pages/login/body.dart';
import 'package:ess_plus/Pages/notification/Student/body.dart';
import 'package:ess_plus/Pages/notification/messagepage.dart';
import 'package:ess_plus/utils/constants.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class MyHomepage extends StatefulWidget {
  @override
  _MyHomepageState createState() => new _MyHomepageState();
}

class _MyHomepageState extends State<MyHomepage> {

  List menuList = [
    MenuItem(UIGuide.logout, 'Logout', LoginUI()),
    MenuItem(UIGuide.profile, 'Webview', LoginPageWeb()),
    MenuItem(UIGuide.notification, 'Notification', StudentNotificationPage()),
  ];
  double _page = 2;

  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    PageController pageController;
    pageController = PageController(initialPage: 2);
    pageController.addListener(
          () {
        setState(
              () {
            _page = pageController.page!;
          },
        );
      },
    );


    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            SizedBox(
              height: width * .70,
              width: width * .90,
              child: LayoutBuilder(
                builder: (context, boxConstraints) {
                  List<Widget> cards = [];

                  for (int i = 0; i <= 2; i++) {

                    double currentPageValue = i - _page;
                    bool pageLocation = currentPageValue > 0;

                    double start = 20 +
                        max(
                            (boxConstraints.maxWidth - width * .75) -
                                ((boxConstraints.maxWidth - width * .75) / 2) *
                                    -currentPageValue *
                                    (pageLocation ? 9 : 1),
                            0.0);


                    var customizableCard = Positioned.directional(

                      top: 20 + 30 * max(-currentPageValue, 0.0),
                      bottom: 20 + 30 * max(-currentPageValue, 0.0),

                      start: start,
                      textDirection: TextDirection.ltr,


                        child: Container(
                            height: width * .67,
                            width: width * .67,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                image: new DecorationImage(
                                  image: new AssetImage(menuList[i].image,),

                                  opacity:1.0,


                                ),


                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black.withOpacity(.15),
                                      blurRadius: 10)
                                ])),
                      );

                    cards.add(customizableCard);
                  }
                  return Stack(children: cards);
                },
              ),
            ),
            Positioned.fill(

                child: PageView.builder(
                  physics: BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  itemCount: 3,
                  controller: pageController,
                  itemBuilder: (context, index) {
                    return SizedBox();
                  },
                ),
              ),

          ],
        ),
      ),
    );
  }

}
class MenuItem {
  final Widget? page;
  final String image;
  final String title;

  MenuItem(this.image, this.title, this.page);
}
