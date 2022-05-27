import 'package:ess_plus/Pages/LoginPageWeb.dart';
import 'package:ess_plus/Pages/home/body3.dart';
import 'package:ess_plus/Pages/home/provider/notification_provider.dart';
import 'package:ess_plus/Pages/notification/Student/body.dart';
import 'package:ess_plus/Pages/notification/staff/body.dart';
import 'package:ess_plus/Pages/notification/staff/components/notification_report_staff.dart';
import 'package:ess_plus/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../routes.dart';
class LoginSecondPage extends StatefulWidget {
  const LoginSecondPage({Key? key}) : super(key: key);

  @override
  State<LoginSecondPage> createState() => _LoginSecondPageState();
}

class _LoginSecondPageState extends State<LoginSecondPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(

          // decoration: BoxDecoration(
          //   image: DecorationImage(
          //    image: AssetImage(UIGuide.homeback),
          //    fit: BoxFit.cover,
          //   ),
          // ),

        child:Column(
          children: [

            SizedBox(
              height: 250,
                child: Padding(
                  padding: const EdgeInsets.only(top:50.0),
                  child: Image.asset(UIGuide.school),
                )),


            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [

         InkWell(
          onTap: () {
            showDialog(
              context: context,
              builder: (context) {
                return Dialog(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
                  elevation: 16,
                  child: Container(
                    child: ListView(

                      shrinkWrap: true,
                      children: <Widget>[
                        SizedBox(height: 20),
                        Center(child: Text('Notification',style: TextStyle(
                          fontSize: 25.0,
                          color: UIGuide.PRIMARY,
                          fontWeight: FontWeight.w800,
                        ),)),
                        SizedBox(height: 20),
                        _buildRow(UIGuide.notification, 'Student',StudentNotificationPage(),context),
                        _buildRow(UIGuide.notification, 'Staff',StaffNotificationPage(),context),
                        _buildRow(UIGuide.notification, 'Report',NotificationReportStaff(
                          loginType: LoginType.staff,
                        ),context),

                      ],
                    ),
                  ),
                );
              },
            );
          },

          child: AvatarGlow(
            glowColor: UIGuide.PRIMARY2,
            endRadius: 90.0,
            duration: Duration(milliseconds: 2000),
            repeat: true,
            showTwoGlows: true,
            repeatPauseDuration: Duration(milliseconds: 100),
            child: Material(
              elevation: 8.0,
              shape: CircleBorder(),
              child: CircleAvatar(
                backgroundColor:Colors.grey[100] ,
                child: Image.asset(UIGuide.notification,height: 60,),
                radius: 40.0,
              ),
            ),
        ),
         ),

              ],
            ),

            Padding(
              padding: const EdgeInsets.only(top:25.0),
              child: Center(child: InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPageWeb()));
                  },
                  child: Image.asset(UIGuide.essplogo,height: 130,))),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children:[ Padding(
                padding: const EdgeInsets.only(top:60,right:20.0),
                child: InkWell(
                    onTap: () async {
                      SharedPreferences _pref = await SharedPreferences.getInstance();
                      _pref.remove('accesstoken');
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          routeLoginmain, (Route<dynamic> route) => false);
                    },
                    child: Image.asset(UIGuide.logout,height: 80,)),
              ),
      ],
            ),

          ],


        ),
      ),
       bottomNavigationBar: BottomAppBar(
         color: Colors.transparent,
         child: Image.asset(UIGuide.ourlogo,height: 70,),
         elevation: 0,
       ),
    );
  }

  Widget _buildRow(String imageAsset, String name,Widget page,context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Column(
        children: <Widget>[
          SizedBox(height: 15),
          Container(height: 2, color: UIGuide.PRIMARY2),
          SizedBox(height: 16),
          InkWell(
            onTap:(){
              Navigator.push(context,MaterialPageRoute(builder: (context)=>page));
            },
            child: Row(
              children: <Widget>[
              //  CircleAvatar(backgroundImage: AssetImage(imageAsset)),

                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.circular(100.0)),
                  elevation: 5,
                  child: Container(
                    width: 60,
                    height: 60,
                    padding: const EdgeInsets.all(10.0),
                    child: Image.asset(imageAsset
                      ,
                      // width: 10,
                      //   height: 10,
                      //color: UIGuide.PRIMARY,
                    ),
                  ),
                ),
                SizedBox(width: 15,height: 40,

                ),
                Text(name),

                Spacer(),


              ],
            ),
          ),
        ],
      ),
    );
  }
}
