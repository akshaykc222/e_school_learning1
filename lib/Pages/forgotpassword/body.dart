import 'package:flutter/material.dart';
import 'package:slider_button/slider_button.dart';

import '../../utils/constants.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            padding: const EdgeInsets.only(top: 100, left: 20, right: 20),
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Forgot Password",
                    style: TextStyle(
                        fontSize: 25,
                        color: UIGuide.PRIMARY,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextField(
                    decoration: InputDecoration(
                        labelText: 'Username',
                        hintText: 'Enter your UserName',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        )),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SliderButton(
                    vibrationFlag: true,
                    dismissible: false,
                    action: () {
                      ///Do something here OnSlide
                    },

                    ///Put label over here
                    label: const Text(
                      "Slide to proceed",
                      style: TextStyle(
                          color: Color(0xff4a4a4a),
                          fontWeight: FontWeight.w500,
                          fontSize: 17),
                    ),

                    ///Change All the color and size from here.
                    width: 230,
                    height: 70,
                    radius: 20,
                    buttonColor: Colors.blue,
                    backgroundColor: Colors.grey,
                    highlightedColor: Colors.white,
                    baseColor: Colors.red,
                  ),
                ),
              ],
            )));
  }
}
