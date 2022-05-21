import 'package:ess_plus/Pages/home/body3.dart';
import 'package:ess_plus/Pages/notification/Student/body.dart';
import 'package:ess_plus/Pages/notification/staff/body.dart';
import 'package:ess_plus/utils/constants.dart';
import 'package:flutter/material.dart';
class LoginSecondPage extends StatelessWidget {
  const LoginSecondPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(UIGuide.homeback),
            fit: BoxFit.cover,
          ),
        ),

        child:Column(
          children: [


            Row(
              children: [

         Padding(
           padding: const EdgeInsets.only(top: 60,left: 20),
           child: InkWell(
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
                          _buildRow(UIGuide.notification, 'Report',StudentHomePage(),context),

                        ],
                      ),
                    ),
                  );
                },
              );
            },

            child: SizedBox(
              height: 80,
                width: 80,
                child: Image.asset(UIGuide.notification)),
        ),
         ),
              ],
            )
          ],
        ),
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
