import 'package:flutter/material.dart';
import 'package:otp_screen/otp_screen.dart';
import 'package:flutter/services.dart';

class PinCodeScreen extends StatefulWidget {
  PinCodeScreen({Key key}) : super(key: key);

  @override
  _PinCodeScreenState createState() => _PinCodeScreenState();
}

class _PinCodeScreenState extends State<PinCodeScreen> {

  Future<String> validateOtp(String otp) async {
    await Future.delayed(Duration(milliseconds: 100));
    if (otp == "123456") {
      // return null;
      return "The entered Otp is success";
    } else {
      return "The entered Otp is wrong";
    }
  }

  void moveToNextScreen(context) {
    // Utility.getInstance().showAlertDialog(context, 'Status', 'Success');
    // return null;
  }

  @override
  Widget build(BuildContext context) {

    // ตั้งค่าล็อก Screen เป็นแนวตั้ง
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    return Scaffold(
      // appBar: AppBar(
      //   automaticallyImplyLeading: false,
      //   title: Text('กรอกรหัสยืนยันที่ได้รับจากอีเมล์'),
      // ),
      body: OtpScreen(
          otpLength: 6,
          validateOtp: validateOtp,
          routeCallback: moveToNextScreen,
          themeColor: Colors.black,
          titleColor: Colors.teal,
          title: "รหัสยืนยันที่ได้รับจากอีเมล์",
          // subTitle: "Enter the code sent to \n +919876543210",
          subTitle: "",
          icon: Image.asset(
            'assets/images/email_logo.png',
            fit: BoxFit.fill,
          ),
      ),
    );
  }
}