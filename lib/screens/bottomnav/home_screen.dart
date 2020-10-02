import 'dart:convert';

import 'package:ASmartApp/models/NewsModel.dart';
import 'package:ASmartApp/services/rest_api.dart';
import 'package:ASmartApp/utils/utility.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart' as url_launcher;

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  SharedPreferences sharedPreferences;
  String _fullnameAccount, _avatar;

  final String _currentDate = DateFormat('dd/MM/yyyy').format(DateTime.now());
  final String _currentTime = DateFormat('HH:mm:ss').format(DateTime.now());

  // สร้าง Ojbect Geolocator
  Position position;
  String _lat, _lon;

  // ฟังก์ชันเช็คว่าผู้ใช้เปิด GPS แล้วหรือยัง
  _getPosition() async {
    bool _isLocationServiceEnabled = await isLocationServiceEnabled();
    if (_isLocationServiceEnabled) {
      position =
          await getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      _lat = position.latitude.toString();
      _lon = position.longitude.toString();
      showDialog(
          context: context,
          builder: (BuildContext context) => SimpleDialog(
                // title: Text('เลือกลงเวลาทำงาน'),
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 20.0, right: 20.0, top: 15.0, bottom: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('วันที่ $_currentDate'),
                        Text('เวลา $_currentTime')
                      ],
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.work),
                    title: Text('ลงเวลาเข้าทำงาน'),
                    onTap: () {

                      Map<String, dynamic> body = {
                          "IMEI": "baac1234",
                          "latitude": "12",
                          "longitude": "13",
                          "Type": "1"
                      };

                      checkInCheckOut(body);

                      Utility.getInstance().showAlertDialog(
                        context,
                        'เรียบร้อย',
                        'บันทึกเวลาเข้าทำงานเรียบร้อยแล้ว\nที่พิกัด $_lat, $_lon',
                        'ตกลง');
                      // Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.time_to_leave),
                    title: Text('ลงเวลาออกงาน'),
                    onTap: () {
                      Utility.getInstance().showAlertDialog(
                        context,
                        'เรียบร้อย',
                        'บันทึกเวลาออกงานเรียบร้อยแล้ว\nที่พิกัด $_lat, $_lon',
                        'ตกลง');
                      // Navigator.pop(context);
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    // mainAxisSize: MainAxisSize.max,
                    children: [
                      OutlineButton(
                        child: Icon(
                          Icons.close,
                          size: 20,
                        ),
                        color: Colors.red,
                        textColor: Colors.black,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                  ],
            ),
        ],
      )
      );
    } else {
      Utility.getInstance().showAlertDialog(
          context, 'คุณยังไม่ได้เปิด GPS', 'กรุณาเปิดก่อนใช้งาน');
    }
  }

  checkInCheckOut(empData) async{

    var result = await Connectivity().checkConnectivity();

    if (result == ConnectivityResult.none) {
      Utility.getInstance().showAlertDialog(context, 'ออฟไลน์', 'คุณยังไม่ได้เชื่อมต่ออินเตอร์เน็ต','ตกลง');
    }else{

      var response = await CallAPI().checkInAndOut(
        empData, 
        'Golocation'
      );

      var body = json.decode(response.body);
      print(body);

    }

  }

  // สร้างฟังก์ชันไว้ดึงข้อมูลตัวแปรแบบ sharedPreferences
  readEmployee() async {
    sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      _fullnameAccount = sharedPreferences.getString('storeFirstname') +
          " " +
          sharedPreferences.getString('storeLastname');
      _avatar = sharedPreferences.getString('storeAvatar');
    });
  }

  @override
  void initState() {
    super.initState();
    readEmployee();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:ListView(children: [
        Container(
          width: double.infinity,
          height: 120.0,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/bg_account.jpg'),
                  fit: BoxFit.cover)),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: CircleAvatar(
                        radius: 32,
                        backgroundColor: Color(0xffffffff),
                        child: _avatar != null ? CircleAvatar(
                            radius: 28,
                            backgroundImage: NetworkImage('$_avatar')
                            // backgroundImage: AssetImage('assets/images/avatar.jpg'),
                        ): CircularProgressIndicator(),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'สวัสดี',
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                          Text(
                            '$_fullnameAccount',
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          RaisedButton(
                            onPressed: () {
                              _getPosition();
                            },
                            child: Text(
                              'ลงเวลาทำงาน',
                              style: TextStyle(color: Colors.white),
                            ),
                            color: Colors.red,
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 15.0, left: 15.0, bottom: 15.0),
          child: Text(
            'ข่าวประกาศล่าสุด',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.30,
          child: FutureBuilder(
              future: CallAPI().getNews(),
              builder: (BuildContext context,
                  AsyncSnapshot<List<NewsModel>> snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text('มีข้อผิดพลาด ${snapshot.error.toString()}'),
                  );
                } else if (snapshot.connectionState == ConnectionState.done) {
                  List<NewsModel> news = snapshot.data;
                  return _builderListView(news);
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 15.0, left: 15.0, bottom: 15.0),
          child: Text(
            'ข่าวทั้งหมด',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.28,
          child: FutureBuilder(
              future: CallAPI().getNews(),
              builder: (BuildContext context,
                  AsyncSnapshot<List<NewsModel>> snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text('มีข้อผิดพลาด ${snapshot.error.toString()}'),
                  );
                } else if (snapshot.connectionState == ConnectionState.done) {
                  List<NewsModel> news = snapshot.data;
                  return _listViewAllNews(news);
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
        ),
      ]
    ),
    );
  }

  // ListView builder
  Widget _builderListView(List<NewsModel> news) {
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: news.length,
        itemBuilder: (context, index) {
          // Load Model
          NewsModel newsModel = news[index];
          return Container(
            width: MediaQuery.of(context).size.width * 0.6,
            child: InkWell(
              onTap: () =>
                  url_launcher.launch('https://pub.dev/packages/url_launcher'),
              child: Card(
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      newsModel.imageurl != null ? Container(
                          height: 125.0,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(
                                    newsModel.imageurl,
                                  ),
                                  fit: BoxFit.fitHeight,
                                  alignment: Alignment.topCenter)
                        )
                      ): CircularProgressIndicator(),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Text(newsModel.topic,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold)),
                            Text(newsModel.detail,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 16.0,
                                ))
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  // ListView All news
  Widget _listViewAllNews(List<NewsModel> news) {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: news.length,
        itemBuilder: (context, index) {
          NewsModel newsModel = news[index];
          return ListTile(
            leading: Icon(Icons.new_releases),
            title: Text(newsModel.topic, overflow: TextOverflow.ellipsis),
            subtitle: Text(newsModel.detail, overflow: TextOverflow.ellipsis),
            onTap: () {
              Utility.getInstance()
                  .showAlertDialog(context, newsModel.topic, newsModel.detail);
            },
          );
        });
  }


}
