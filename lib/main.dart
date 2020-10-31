import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:srm_final/login_regis/login.dart';
import 'splashscreen.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyApp(),
    );
  }
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  String token = '';

  static Future<dynamic> onBackgroundMessageHandler(
      Map<String, dynamic> message) {
    debugPrint('onBackgroundMessageHandler');
    if (message.containsKey('data')) {
      final dynamic data = message['data'];
      String name = data['name'];
      String age = data['age'];
      String page = data['page'];
      debugPrint('name: $name & age: $age & page: $page');
    }

    /*if (message.containsKey('notification')) {
    // Handle notification message
    final dynamic notification = message['notification'];
  }*/

    // Or do other work.
    return Future.value(true);
  }

  void _getDataFcm(Map<String, dynamic> message, String type) {
    try {
      String page = '';
      String name = '';
      String age = '';
      if (Platform.isIOS) {
        name = message['name'];
        age = message['age'];
        page = message['page'];
      } else if (Platform.isAndroid) {
        var data = message['data'];
        name = data['name'];
        age = data['age'];
        page = data['page'];
      }
      debugPrint('name: $name & age: $age & page: $page');
      switch (type) {
        case 'onResume':
        case 'onLaunch':
          {
            if (page == "") {
              Login();
            }
            break;
          }
        default:
          {
            debugPrint('unknown type in getDataFcm');
          }
      }
    } catch (error) {
      debugPrint("error: $error");
    }
  }

  _getSplashStatus() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var splash = preferences.getInt('splash');
    preferences.setString('token', token);
    setState(() {
      if (splash == 1) {
        debugPrint('Splash : Done route to Login Page');
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Login()),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => SplashConfig()),
        );
      }
    });
  }

  @override
  void initState() {
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        debugPrint('onMessage');
        _getDataFcm(message, 'onMessage');
      },
      onBackgroundMessage: onBackgroundMessageHandler,
      onResume: (Map<String, dynamic> message) async {
        debugPrint('onResume');
        _getDataFcm(message, 'onResume');
      },
      onLaunch: (Map<String, dynamic> message) async {
        debugPrint('onLaunch');
        _getDataFcm(message, 'onLaunch');
      },
    );
    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(
            sound: true, badge: true, alert: true, provisional: true));
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      debugPrint("Settings registered: $settings");
    });
    _firebaseMessaging.getToken().then((String token) {
      debugPrint('getToken: $token');
      setState(() {
        this.token = token;
      });
    });
    super.initState();
    _getSplashStatus();
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    double widthScreen = mediaQueryData.size.width;

    return Scaffold(
      key: _scaffoldState,
      body: SafeArea(
        child: Center(
          child: Container(
            width: widthScreen,
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/ic_logo.png',
                  height: widthScreen * 0.4,
                  width: widthScreen * 0.4,
                ),
                Text(
                  "Sweet Room Medan",
                  style: GoogleFonts.alexBrush(
                    fontSize: widthScreen * 0.1,
                    color: Colors.red[900],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
