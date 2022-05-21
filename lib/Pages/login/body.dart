import 'dart:convert';

import 'package:ess_plus/Pages/LoginPageWeb.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Provider/LoginProvider.dart';
import '../../utils/constants.dart';
import '../home/body.dart';
import 'model/loginmodel.dart';

class LoginUI extends StatefulWidget {
  @override
  _LoginUIState createState() => _LoginUIState();
}

class _LoginUIState extends State<LoginUI> with SingleTickerProviderStateMixin {
  final formkey = GlobalKey<FormState>();
  final username = TextEditingController();
  final password = TextEditingController();
  bool _passwordVisible = true;

  late AnimationController _controller;
  late Animation<double> _animation;

  void checkLogin(String username, password) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request(
        'POST',
        Uri.parse(
            '${UIGuide.baseURL}/login?id=${_pref.getString('schoolId')}'));
    request.body = json.encode({"email": username, "password": password});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var data = jsonDecode(await response.stream.bytesToString());
      // SharedPreferences prefs = await SharedPreferences.getInstance();
      LoginModel res = LoginModel.fromJson(data);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString("accesstoken", res.accessToken);
      print(res.accessToken);
      Provider.of<LoginProvider>(context, listen: false).getToken(context);
      var parsedResponse = await parseJWT();
      if (parsedResponse['role'] == "SystemAdmin") {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => AdminHomePage()));
      } else {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const LoginPageWeb()));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Invalid Username or Password")));
    }
  }

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _animation = Tween<double>(begin: .7, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.ease,
      ),
    )
      ..addListener(
        () {
          setState(() {});
        },
      )
      ..addStatusListener(
        (status) {
          if (status == AnimationStatus.completed) {
            _controller.reverse();
          } else if (status == AnimationStatus.dismissed) {
            _controller.forward();
          }
        },
      );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _inputField2(
    TextEditingController controller,
  ) {
    double _width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Container(
          height: _width / 4,
          width: _width / 1.22,
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: TextFormField(
              validator: (val) {
                if (val!.isEmpty) {
                  return "Please enter any value";
                } else if (val.length <= 8) {
                  return "enter correct password";
                }
              },
              //obscureText: true,

              controller: controller,
              obscureText: _passwordVisible,
              decoration: InputDecoration(
                  suffixIcon: IconButton(
                    icon: Icon(
                      // Based on passwordVisible state choose the icon
                      _passwordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Colors.black54,
                    ),
                    onPressed: () {
                      // Update the state i.e. toogle the state of passwordVisible variable
                      setState(() {
                        _passwordVisible = !_passwordVisible;
                      });
                    },
                  ),
                  labelText: 'Password',
                  labelStyle: TextStyle(
                    color: UIGuide.PRIMARY,
                  ),
                  hintText: 'enter your password',
                  isCollapsed: false,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: UIGuide.PRIMARY2),
                    borderRadius: BorderRadius.circular(15.0),
                  )),
            ),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {

    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    return Scaffold(
      //backgroundColor: Color(0xff292C31),
      backgroundColor: UIGuide.offwhite,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const SizedBox(
                height: 150,
              ),
              const Text(
                'SIGN IN',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w800,
                  //color: Color(0xffA9DED8),
                  color: UIGuide.PRIMARY,
                ),
              ),
              //SizedBox(),
              _inputField1(username),
              _inputField2(password),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     RichText(
              //       text: TextSpan(
              //         text: 'Forgot password!',
              //         style: const TextStyle(
              //             fontSize: 15,
              //             //color: Color(0xffA9DED8),
              //             color: UIGuide.PRIMARY),
              //         recognizer: TapGestureRecognizer()
              //           ..onTap = () {
              //             HapticFeedback.lightImpact();
              //             // Navigator.push(
              //             //     context,
              //             //     MaterialPageRoute(
              //             //         builder: (context) =>
              //             //             ForgotPassword()));
              //           },
              //       ),
              //     ),
              //   ],
              // ),
            ],
          ),


          //old signin
          // ----
          // SizedBox(
          //     width: MediaQuery.of(context).size.width * 0.7,
          //     height: 55,
          //     child: ElevatedButton(
          //         style: ElevatedButton.styleFrom(
          //           primary: UIGuide.PRIMARY,
          //         ),
          //         onPressed: () {
          //           checkLogin(username.text.trim(), password.text.trim());
          //         },
          //         child: Text(
          //           'SIGN-IN',
          //           style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          //         ))),
          // SizedBox(
          //   height: MediaQuery.of(context).size.height * 0.1,
          // ),

Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 200),
                    child: Stack(
                      children: [
                        Center(
                          child: Container(
                            margin: EdgeInsets.only(bottom: _width * .07),
                            height: _width * .5,
                            width: _width * .5,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(
                                colors: [
                                  Colors.transparent,
                                  Colors.transparent,
                                  Color(0xff610815),
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ),
                            ),
                          ),
                        ),
                        Center(
                          child: Transform.scale(
                            scale: _animation.value,
                            child: InkWell(
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () {
                                HapticFeedback.lightImpact();
                                checkLogin(username.text, password.text);
                              },
                              child: Container(
                                height: _width * .2,
                                width: _width * .2,
                                alignment: Alignment.center,
                                decoration: const BoxDecoration(
                                  //color: Color(0xffA9DED8),
                                  color: UIGuide.PRIMARY,
                                  shape: BoxShape.circle,
                                ),
                                child: const Text(
                                  'SIGN-IN',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

          Container(
            padding: EdgeInsets.only(bottom: 20),
            height: 80,
            child: Image.asset(UIGuide.ourlogo),
          )
        ],
      ),
    );
  }

  Widget _inputField1(TextEditingController controller) {
    double _width = MediaQuery.of(context).size.width;

    return Center(
      child: Container(
        width: _width / 1.22,
        child: Column(
          children: [
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(8),
              child: TextFormField(
                validator: (val) {
                  if (val!.isEmpty) {
                    return "Please enter any value";
                  } else if (!RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                      .hasMatch(val)) {
                    return "please enter a valid email";
                  }
                },
                controller: controller,
                decoration: InputDecoration(
                    labelText: 'Username',
                    labelStyle: TextStyle(
                      color: UIGuide.PRIMARY,
                    ),
                    hintText: 'enter your name',
                    isCollapsed: false,
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: UIGuide.PRIMARY),
                      borderRadius: BorderRadius.circular(15.0),
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
