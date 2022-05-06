// import 'dart:convert';

// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:student_login/screens/forgotpassword/body.dart';
// import 'package:student_login/screens/home/body1.dart';
// import 'package:student_login/screens/login/model/loginmodel.dart';
// import 'package:student_login/screens/notification/body.dart';
// import 'package:student_login/utils/constants.dart';
// import 'package:http/http.dart' as http; 

// class LoginUI extends StatefulWidget {
//   @override
//   _LoginUIState createState() => _LoginUIState();
// }

// class _LoginUIState extends State<LoginUI>
//     with SingleTickerProviderStateMixin {
//      final formkey= GlobalKey<FormState>();
//      final username=TextEditingController();
//      final password= TextEditingController();


//   late AnimationController _controller;
//   late Animation<double> _animation;



// void checkLogin(String username,password) async
// {
  
// var headers = { 
//   'Content-Type': 'application/json'
// };
// var request = http.Request('POST', Uri.parse('https://api.schooltestonline.xyz/login?id=16f71c18-5144-42d1-bc55-edba05a6e22f'));
// request.body = json.encode({
//   "email":username,
//   "password": password
// });
// request.headers.addAll(headers);

// http.StreamedResponse response = await request.send();

// if (response.statusCode == 200) {
//   var data=jsonDecode(await response.stream.bytesToString());
//  // SharedPreferences prefs = await SharedPreferences.getInstance();
// LoginModel res=LoginModel.fromJson(data);
//  SharedPreferences prefs = await SharedPreferences.getInstance();
//  prefs.setString("accesstoken",res.accessToken);
//  Navigator.push(context, MaterialPageRoute(builder: (context)=> LoginUI()));
// }
// else {
//   ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Invalid Username or Password")));
//   print(response.reasonPhrase);
// } 
// }
  

//   @override
//   void initState() {
//     super.initState();

//     _controller = AnimationController(
//       vsync: this,
//       duration: Duration(seconds: 2),
//     );

//     _animation = Tween<double>(begin: .7, end: 1).animate(
//       CurvedAnimation(
//         parent: _controller,
//         curve: Curves.ease,
//       ),
//     )..addListener(
//         () {
//           setState(() {});
//         },
//       )..addStatusListener(
//         (status) {
//           if (status == AnimationStatus.completed) {
//             _controller.reverse();
//           } else if (status == AnimationStatus.dismissed) {
//             _controller.forward();
//           }
//         },
//       );

//     _controller.forward();
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     double _width = MediaQuery.of(context).size.width;
//     double _height = MediaQuery.of(context).size.height;
//     return Scaffold(
//       //backgroundColor: Color(0xff292C31),
//       backgroundColor: UIGuide.offwhite,
//       body: ScrollConfiguration(
//         behavior: MyBehavior(),
//         child: SingleChildScrollView(
//           child: SizedBox(
//             height: _height,
//             child: Column(
//               children: [
//                 const Expanded(child: SizedBox()),
//                 Expanded(
//                   flex: 4,
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       const SizedBox(),
//                       const Text(
//                         'SIGN IN',
//                         style: TextStyle(
//                           fontSize: 25,
//                           fontWeight: FontWeight.w600,
//                           //color: Color(0xffA9DED8),
//                           color: UIGuide.PRIMARY,
//                         ),
//                       ),
//                       //SizedBox(),
//                       component1(Icons.account_circle_outlined, 'User name...',
//                           false, false,),
                     
//                       component1(
//                           Icons.lock_outline, 'Password...', true, false,),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           RichText(
//                             text: TextSpan(
//                               text: 'Forgot password!',
                              
//                               style: const TextStyle(
//                                 fontSize: 15,
//                                 //color: Color(0xffA9DED8),
//                                 color: UIGuide.PRIMARY
//                               ),
//                               recognizer: TapGestureRecognizer()
//                                 ..onTap = () {
//                                   HapticFeedback.lightImpact();
//                                   Navigator.push(context, MaterialPageRoute(builder: (context)=>ForgotPassword()));
//                                 },
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//                 Expanded(
//                   flex: 3,
//                   child: Stack(
//                     children: [
//                       Center(
//                         child: Container(
//                           margin: EdgeInsets.only(bottom: _width * .07),
//                           height: _width * .5,
//                           width: _width * .5,
//                           decoration: const BoxDecoration(
//                             shape: BoxShape.circle,
//                             gradient: LinearGradient(
//                               colors: [
//                                 Colors.transparent,
//                                 Colors.transparent,
//                                 Color(0xff09090A),
//                               ],
//                               begin: Alignment.topCenter,
//                               end: Alignment.bottomCenter,
//                             ),
//                           ),
//                         ),
//                       ),
//                       Center(
//                         child: Transform.scale(
//                           scale: _animation.value,
//                           child: InkWell(
//                             splashColor: Colors.transparent,
//                             highlightColor: Colors.transparent,
//                             onTap: () {
//                               HapticFeedback.lightImpact();
//                               Navigator.push(context, MaterialPageRoute(builder: (context)=>StudentHomePage()));
//                             },
//                             child: Container(
//                               height: _width * .2,
//                               width: _width * .2,
//                               alignment: Alignment.center,
//                               decoration: const BoxDecoration(
//                                 //color: Color(0xffA9DED8),
//                                 color: UIGuide.PRIMARY,
//                                 shape: BoxShape.circle,
//                               ),
//                               child: const Text(
//                                 'SIGN-IN',
//                                 style: TextStyle(
//                                   color: Colors.black,
//                                   fontWeight: FontWeight.w600,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
              
//                Container(
//                  padding: EdgeInsets.only(bottom: 20),
//                  height: 80,
//                 child: Image.asset(UIGuide.ourlogo),
//                )
//              ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget component1(
//       IconData icon, String hintText, bool isPassword, bool isEmail ) {
//     double _width = MediaQuery.of(context).size.width;
//     return Container(
//       height: _width / 8,
//       width: _width / 1.22,
//       alignment: Alignment.center,
//       padding: EdgeInsets.only(right: _width / 30),
//       decoration: BoxDecoration(
//         color: const Color(0xff212428),
//         borderRadius: BorderRadius.circular(15),
//       ),
//         child: TextFormField(
//         style: TextStyle(color: Colors.white.withOpacity(.9)),
//         obscureText: isPassword,
//         keyboardType: isEmail ? TextInputType.emailAddress : TextInputType.text,
//         decoration: InputDecoration(
//         prefixIcon: Icon(
//           icon,
//           color: Colors.white.withOpacity(.7),  
//           ),
//           border: InputBorder.none,
//           hintMaxLines: 1,
//           hintText: hintText,
          
//           hintStyle: TextStyle(
//             fontSize: 15,
//             color: Colors.white.withOpacity(.5),
//           ),
//         ),
//       ),
//     );
//   }
// }


// class MyBehavior extends ScrollBehavior {
//   @override
//   Widget buildViewportChrome(
//       BuildContext context, Widget child, AxisDirection axisDirection) {
//     return child;
//   }
// }

