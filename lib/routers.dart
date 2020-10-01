import 'package:ASmartApp/screens/register/register_screen.dart';
import 'package:ASmartApp/screens/welcome/welcome_screen.dart';
import 'package:flutter/material.dart';

final Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
  "/welcome": (BuildContext context) => WelcomeScreen(),
  "/register": (BuildContext context) => RegisterScreen()
};
