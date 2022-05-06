import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';

class LoginPageWeb extends StatefulWidget {
  const LoginPageWeb({Key? key}) : super(key: key);

  @override
  _LoginPageWebState createState() => _LoginPageWebState();
}

class _LoginPageWebState extends State<LoginPageWeb> {
  String baseUrl = "";
  String schoolId = "";
  Future<String> session() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return baseUrl = (prefs.getString("baseUrl"))!;
  }

  @override
  void initState() {
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: FutureBuilder(
          future: session(),
          builder: (context, snap) {
            return snap.hasData
                ? WebView(
                    initialUrl: 'https://$baseUrl.schooltestonline.xyz/login',
                    javascriptMode: JavascriptMode.unrestricted,
                    onWebViewCreated: (WebViewController webViewController) {},
                  )
                : Container(
                    child: Center(
                    child: CircularProgressIndicator(),
                  ));
          }),
    );
  }
}
