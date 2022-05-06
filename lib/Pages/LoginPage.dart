import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Constants.dart';
import '../SizeConfig.dart';
import '../routes.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with TickerProviderStateMixin {
  late AnimationController scaleAnimationController;
  late Animation<double> scaleAnimation;

  final _formKey = GlobalKey<FormState>();
  final _userName = TextEditingController();
  final _passWord = TextEditingController();
  bool isLoading = false;

  void showLoadingDialog() {
    showGeneralDialog(
        context: context,
        barrierColor: Colors.black54,
        barrierDismissible: false,
        pageBuilder: (_, __, ___) {
          return CircularProgressIndicator();
        });
  }

  void transitionAnimation() {
    scaleAnimationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500))
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              // Navigator.push(context, FadeRouteBuilder(page: ActivatePage()));
              // Timer(
              //   Duration(
              //     milliseconds: 300,
              //   ),(){
              //   scaleAnimationController.reset();
              // }    );
            }
          });
    scaleAnimation =
        Tween<double>(begin: 0, end: 1).animate(scaleAnimationController);
  }

  @override
  void initState() {
    transitionAnimation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var sizeConfig = SizeConfig.instance(context);
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    login,
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 25,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: sizeConfig!.getProportionateScreenHeight(20),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    child: inputBoxes(_userName, false, userName),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    child: inputBoxes(_passWord, true, passWord),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          forgotPass,
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.w400),
                        )
                      ],
                    ),
                  ),
                  AnimatedBuilder(
                    animation: scaleAnimation,
                    builder: (BuildContext context, Widget? child) {
                      return InkWell(
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            setState(() {
                              isLoading = true;
                            });
                            Navigator.pushReplacementNamed(context, routeLogin);
                            scaleAnimationController.forward();
                          } else {
                            return;
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: width * 0.4,
                            height: 60,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                    image: AssetImage(buttonBackground),
                                    fit: BoxFit.fill)),
                            child: Center(
                              child: Text(
                                login,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    letterSpacing: 0.5),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  )
                ],
              ),
            ),
    );
  }
}

TextFormField inputBoxes(
    TextEditingController controller, bool password, String label) {
  return TextFormField(
    controller: controller,
    validator: (value) {
      if (value!.isEmpty) {
        return "Enter $label ";
      }
    },
    style: TextStyle(color: Colors.grey),
    decoration: InputDecoration(
        labelStyle: TextStyle(
            color: Colors.black, fontSize: 18, fontWeight: FontWeight.w400),
        labelText: label,
        hintText: label,
        prefixIcon: password
            ? Icon(Icons.lock_open_outlined)
            : Icon(Icons.person_outline_outlined),
        filled: true,
        fillColor: Colors.white,
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: Colors.grey, width: 0.5)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: Colors.grey, width: 0.5)),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: Colors.grey, width: 0.5))),
    obscureText: password,
    obscuringCharacter: "*",
  );
}
