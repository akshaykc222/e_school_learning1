import 'package:ess_plus/Pages/login/body.dart';
import 'package:ess_plus/Provider/LoginProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rect_getter/rect_getter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Constants.dart';
import '../Utils.dart';
import 'LoginPageWeb.dart';

/// created by akshay
/// date 16-07-2021
/// phone 7907017542
/// page for checking and  retrieving activation information about  school

class ActivatePage extends StatefulWidget {
  const ActivatePage({Key? key}) : super(key: key);

  @override
  _ActivatePageState createState() => _ActivatePageState();
}

class _ActivatePageState extends State<ActivatePage>
    with SingleTickerProviderStateMixin {
  _saveSession(String subDomain) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('baseUrl', subDomain);
    await prefs.setBool('activated', true);
  }

  showBottomDialogSchool() {
    showModalBottomSheet(
        context: context,
        isDismissible: false,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        builder: (_) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Wrap(
              children: [
                SizedBox(
                  height: 50,
                ),
                Consumer<LoginProvider>(
                  builder: (_, provider, child) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Welcome",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                                decorationThickness: 5),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          // Image.network(provider.imageUrl),
                          // SizedBox(
                          //   height: 10,
                          // ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              provider.schoolName,
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  overflow: TextOverflow.fade),
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              onTap: () {
                                Navigator.pop(context);
                                _saveSession(provider.subDomain);
                                _onTap();
                              },
                              child: Container(
                                height: 50,
                                decoration: BoxDecoration(
                                    color: Colors.deepOrangeAccent,
                                    borderRadius: BorderRadius.circular(15)),
                                child: Center(
                                  child: Text(
                                    'Continue',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        });
  }

  //for button tap animations
  late AnimationController sizeAnimationController;
  late Animation<double> sizeAnimation;
  bool isLoading = false;
  void sizeAnimationOnTap() {
    sizeAnimationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 400));
    // sizeAnimation=TweenSequence(items)

    sizeAnimation = TweenSequence<double>(
      <TweenSequenceItem<double>>[
        TweenSequenceItem<double>(
          tween: Tween<double>(begin: 10, end: 20)
              .chain(CurveTween(curve: Curves.ease)),
          weight: 40.0,
        ),
        TweenSequenceItem<double>(
          tween: Tween<double>(begin: 20, end: 10)
              .chain(CurveTween(curve: Curves.ease)),
          weight: 40.0,
        ),
      ],
    ).animate(sizeAnimationController);
  }

  var rectGetterKey = RectGetter.createGlobalKey(); //<--Create a key
  Rect? rect;
  final Duration animationDuration = Duration(milliseconds: 350);
  final Duration delay = Duration(milliseconds: 300);
  final secretKeyController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  void _onTap() {
    //-->function for ripple animation transition
    setState(() => rect = RectGetter.getRectFromKey(rectGetterKey)!); //
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      //<-- on the next frame...
      setState(() => rect = rect!.inflate(1.3 *
          MediaQuery.of(context).size.longestSide)); //<-- set rect to be big
      Future.delayed(animationDuration + delay,
          _goToNextPage); //<-- after delay, go to next page
    }); // <--onTap, update rect
    // Navigator.of(context).push(FadeRouteBuilder(page: LoginPage()));
  }

  Future<void> _goToNextPage() async {
    //-->function for navigation

    SharedPreferences _pref = await SharedPreferences.getInstance();
    if (_pref.getString('accesstoken') == null) {
      Navigator.of(context)
          .push(FadeRouteBuilder(page: LoginUI()))
          .then((_) => setState(() => rect = null));
    } else {
      Navigator.of(context)
          .push(FadeRouteBuilder(page: LoginPageWeb()))
          .then((_) => setState(() => rect = null));
    }
  }

  @override
  void initState() {
    //_checkSession();
    sizeAnimationOnTap();
    super.initState();
  }

  @override
  void dispose() {
    sizeAnimationController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        Scaffold(
          body: isLoading
              ? Container(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(
                            loginBackground,
                          ),
                          fit: BoxFit.fill)),
                  child: Center(
                    child: Form(
                      key: _formKey,
                      //creating a column for text box and button
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 32, vertical: 8),
                            child: Theme(
                                data: Theme.of(context).copyWith(
                                  hintColor: Colors.black,
                                  inputDecorationTheme: InputDecorationTheme(
                                      border: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.grey))),
                                ),
                                child: secretKey(secretKeyController)),
                          ),
                          RectGetter(
                            key: rectGetterKey,
                            child: InkWell(
                              onTap: () async {
                                sizeAnimationController.forward();
                                FocusScope.of(context)
                                    .requestFocus(FocusNode());
                                if (_formKey.currentState!.validate()) {
                                  _formKey.currentState!.save();
                                  setState(() {
                                    isLoading = true;
                                  });
                                  int statusCode = await Provider.of<
                                          LoginProvider>(context, listen: false)
                                      .getActivation(secretKeyController.text);
                                  if (statusCode == 200) {
                                    setState(() {
                                      isLoading = false;
                                      showBottomDialogSchool();
                                    });
                                  } else {
                                    setState(() {
                                      isLoading = false;
                                    });
                                    final snackBar = SnackBar(
                                        content:
                                            Text(' Invalid activation key.'));
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);
                                  }
                                } else {
                                  return;
                                }
                              },
                              child: AnimatedBuilder(
                                animation: sizeAnimation,
                                builder: (BuildContext context, Widget? child) {
                                  print(
                                      '${(width * 0.4) + sizeAnimation.value} size animation');
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      width: (width * 0.4 - 20) +
                                          sizeAnimation.value,
                                      height: 40 + sizeAnimation.value,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          image: DecorationImage(
                                              image:
                                                  AssetImage(activationButton),
                                              fit: BoxFit.fill)),
                                    ),
                                  );
                                },
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
        ),
        rect == null ? Container() : ripple(context, animationDuration, rect)
      ],
    );
  }
}

TextFormField secretKey(TextEditingController controller) {
  return TextFormField(
    controller: controller,
    validator: (value) {
      if (value!.isEmpty) {
        return activationError;
      }
    },
    style: TextStyle(color: Colors.black),
    decoration: InputDecoration(
        labelStyle: TextStyle(
            color: Colors.black, fontSize: 18, fontWeight: FontWeight.w400),
        labelText: schoolCode,
        hintText: schoolCode,
        prefixIcon: Icon(Icons.lock_open_outlined),
        filled: true,
        fillColor: Colors.white,
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: Colors.black)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: Colors.black)),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: Colors.black))),
    obscuringCharacter: "*",
    obscureText: true,
  );
}
