import 'package:ess_plus/Pages/login/body.dart';
import 'package:flutter/material.dart';

import 'Pages/ActivatePage.dart';
import 'Pages/LoginPage.dart';
import 'Pages/LoginPageWeb.dart';

Map<String, WidgetBuilder> routes = {
  routeActivation: (context) => ActivatePage(),
  routeLogin: (context) => LoginPage(),
  routeLoginWeb: (context) => LoginPageWeb(),
  routeLoginmain: (context) => LoginUI(),
};

///route name constants
const String routeActivation = "/activationPage";
const String routeLogin = "/loginPage";
const String routeLoginWeb = "/loginWebPage";
const String routeLoginmain = "/loginmain";
