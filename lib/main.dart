import 'dart:io';

import 'package:ASmartApp/routers.dart';
import 'package:ASmartApp/themes/styles.dart';
import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';

var storeStep;
var initURL;

Future<void> main() async{

  // เขียน class ข้ามการตรวจ Certificate https
  HttpOverrides.global = new MyHttpOverrides();

  WidgetsFlutterBinding.ensureInitialized();
  // SharedPreferences sharedPreferences = 
  // await SharedPreferences.getInstance();

  initURL = '/welcome';

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: appTheme(),
      initialRoute: initURL,
      routes: routes,
    );
  }
}

// เขียน class ข้ามการตรวจ Certificate https
class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext context) {
    return super.createHttpClient(context)
    ..badCertificateCallback = 
    (X509Certificate cert, String host, int port)=>true;
  }
}