import 'package:ess_plus/Pages/LoginPageWeb.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../routes.dart';
import '../../utils/constants.dart';
import '../login/body.dart';
import 'admin/provider/home_provider.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({Key? key}) : super(key: key);

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  List menuList = [
    MenuItem(UIGuide.notification, 'Notification', LoginUI()),
    MenuItem(UIGuide.profile, 'Webview', LoginPageWeb()),
  ];

  Future<void> getToken() async {
    String? token = await FirebaseMessaging.instance.getToken();
    print(token);
  }

  @override
  void initState() {
    getToken();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: const [
            HeaderWidget(),
          ],
        ),
      ),
      body: Stack(children: [
        Container(
          padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 8),
          height: MediaQuery.of(context).size.height / 4,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(UIGuide.school),
              fit: BoxFit.cover,
            ),
          ),
          child: AnimationLimiter(
            child: GridView.count(
              crossAxisCount: 4,
              children: <Widget>[
                // MyCard(
                //   title: "Student",
                //   text1: "Strength: 900",
                //   text2: "Absent: 3",
                //   text3: "Present: 897",
                // ),
                // MyCard(
                //   title: "Staff",
                //   text1: "Strength: 16",
                //   text2: "Absent: 0",
                //   text3: "Present: 16",
                // ),
                // MyCard(
                //   title: "Fees",
                //   text1: "Direct: 0.00",
                //   text2: "Bank: 0.00",
                //   text3: "Gateway: 0.00",
                // ),
                // MyCard(
                //   title: "Bus Fees",
                //   text1: "Direct: 0.00",
                //   text2: "Bank: 0.00",
                //   text3: "Gateway: 0.00",
                // ),
              ],
            ),
          ),
        ),
        DraggableScrollableSheet(
          initialChildSize: .7,
          minChildSize: .7,
          maxChildSize: .95,
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
              child: Stack(
                children: [
                  GridView.builder(
                    controller: scrollController,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4, childAspectRatio: 60 / 80),
                    itemBuilder: (context, position) {
                      return InkWell(
                          splashColor: Colors.grey,
                          onTap: () {
                            Provider.of<HomeProvider>(context, listen: false)
                                .setselectedMenumodel(menuList[position]);
                          },
                          child: Center(
                            child: Column(
                              children: [
                                Center(
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(100.0)),
                                    elevation: 5,
                                    child: Container(
                                      width: 60,
                                      height: 60,
                                      padding: const EdgeInsets.all(10.0),
                                      child: Image.asset(
                                        menuList[position].image,
                                        // width: 10,
                                        //   height: 10,
                                        //color: UIGuide.PRIMARY,
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
                                      style:
                                          const TextStyle(color: UIGuide.PRIMARY
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
                  Consumer<HomeProvider>(builder: (context, snap, child) {
                    return Visibility(
                      visible: snap.expand,
                      child: Positioned(
                        right: 0,
                        left: 0,
                        top: 0,
                        bottom: 0,
                        child: Container(
                          color: Colors.transparent,
                          height: 500,
                          width: 100,
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Expanded(
                                child: Opacity(
                                  opacity: 0.5,
                                  child: InkWell(
                                    onTap: () {
                                      Provider.of<HomeProvider>(context,
                                              listen: false)
                                          .setExpanded();
                                    },
                                    child: Container(
                                      child: Center(
                                        child: Container(
                                          width: 50,
                                          height: 50,
                                          decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.white,
                                          ),
                                          child: InkWell(
                                              onTap: () {
                                                Provider.of<HomeProvider>(
                                                        context,
                                                        listen: false)
                                                    .setExpanded();
                                              },
                                              child: const Icon(Icons.close)),
                                        ),
                                      ),
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.7,
                                      decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(30)),
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.7,
                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(30)),
                                    color: Colors.white,
                                  ),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          snap.selectedMenumodel == null
                                              ? ""
                                              : snap.selectedMenumodel!.title,
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: UIGuide.PRIMARY,
                                          ),
                                        ),
                                      ),
                                      Consumer<HomeProvider>(
                                          builder: (context, snapshot, child) {
                                        return Expanded(
                                          child: ListView(
                                              children: snapshot.subMenulist
                                                  .map((element) => element
                                                              .groupName ==
                                                          snap.selectedMenumodel!
                                                              .title
                                                      ? ListTile(
                                                          leading: element.icon,
                                                          title: Text(
                                                              element.subMenu!),
                                                          onTap: () {
                                                            Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder: (context) =>
                                                                        element
                                                                            .page));
                                                          },
                                                        )
                                                      : Container())
                                                  .toList()),
                                        );
                                      }),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  })
                ],
              ),
            );
          },
        ),
      ]),
    );
  }
}

class MenuItem {
  final Widget? page;
  final String image;
  final String title;

  MenuItem(this.image, this.title, this.page);
}

//header
class HeaderWidget extends StatelessWidget {
  const HeaderWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: InkWell(
        onTap: () async {
          SharedPreferences _pref = await SharedPreferences.getInstance();
          _pref.clear();
          Navigator.of(context).pushNamedAndRemoveUntil(
              routeLoginmain, (Route<dynamic> route) => false);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: const [
            Text(
              "Log out",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: UIGuide.PRIMARY),
            ),
            Icon(Icons.logout),
          ],
        ),
      ),
    );
  }
}

//card
class MyCard extends StatelessWidget {
  MyCard({
    this.title,
    this.text1,
    this.text2,
    this.text3,
  });

  final String? title;
  final String? text1;
  final String? text2;
  final String? text3;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 2),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              title!,
              style: const TextStyle(
                  color: UIGuide.PRIMARY,
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 3,
            ),
            Text(
              text1!,
              style: const TextStyle(fontSize: 12),
            ),
            Text(
              text2!,
              style: const TextStyle(fontSize: 12),
            ),
            Text(
              text3!,
              style: const TextStyle(fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}

class SubMenu {
  Widget page;

  final String groupName;
  final String? subMenu;
  final Widget? icon;

  SubMenu(
      {required this.groupName, this.subMenu, this.icon, required this.page});
}
