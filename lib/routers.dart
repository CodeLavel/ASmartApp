import 'package:ASmartApp/screens/onboarding/onboarding_screen.dart';
import 'package:ASmartApp/screens/register/register_screen.dart';
import 'package:ASmartApp/screens/welcome/welcome_screen.dart';
import 'package:ASmartApp/screens/consent/consent_screen.dart';
import 'package:ASmartApp/screens/pincode/pincode_screen.dart';
import 'package:flutter/material.dart';

final Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
  "/onboarding": (BuildContext context) => OnboardingScreen(),
  "/welcome": (BuildContext context) => WelcomeScreen(),
  "/register": (BuildContext context) => RegisterScreen(),
  "/consent": (BuildContext context) => ConsentScreen(),
  "/pincode": (BuildContext context) => PinCodeScreen(),
};
