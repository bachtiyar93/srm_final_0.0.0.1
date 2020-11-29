import 'dart:convert';
import 'dart:io';
import 'package:custom_progress_dialog/custom_progress_dialog.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flushbar/flushbar_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:srm_final/Body/HomePage/homepage.dart';
import 'package:srm_final/Body/Profile/profile.dart';
import 'package:srm_final/Body/cart/cart.dart';
import 'package:srm_final/Body/help/help.dart';
import 'package:srm_final/Body/produk/produk_card.dart';
import 'package:srm_final/apikey/sumberapi.dart';
import 'package:srm_final/dashboard_custom/notched.dart';
import 'package:stacked/stacked.dart';
import 'login_page/splashscreen.dart';
import 'login_page/welcomePage.dart';
import 'widget/model_hive/anime.dart';
import 'widget/model_hive/home_view_model.dart';
import 'widget/model_hive/locator.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:http/http.dart' as http;
import 'widget/model_hive_profile/view_model.dart';

void main() async {
  await Hive.initFlutter();
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Hive.initFlutter();
  } else {
    final appDirectory = await path_provider.getApplicationDocumentsDirectory();
    Hive.init(appDirectory.path);
  }
  Hive.registerAdapter(ProdukAdapter());
  setupLocator();
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sweet Room',
      theme: ThemeData(
        primarySwatch: Colors.grey,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyApp(),
    );
  }
}

class MyApp extends StatefulWidget {


  @override
  _MyAppState createState() => _MyAppState();
}
enum LoginStatus { onSplash, onLogin, onDashboard}
class _MyAppState extends State<MyApp>with SingleTickerProviderStateMixin {
  LoginStatus _screenStatus = LoginStatus.onDashboard;
  final GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  String token = '';
  int currentIndex = 0;
  double height = 60;
  double moveProgress = 0;
  AnimationController controller;
  Animation<double> animation;
  List menuList = [
    Icons.store,
    Icons.shopping_bag_outlined,
    Icons.shopping_cart,
    Icons.library_books_outlined,
    Icons.person
  ];

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
      String notif = '';
      String kode = '';
      String snacktitle = '';
      String snackbody = '';
      if (Platform.isIOS) {
        notif = message['notif'];
        kode = message['kode'];
        page = message['page'];
        snacktitle = message['snacktitle'];
        snackbody = message['snackbody'];
      } else if (Platform.isAndroid) {
        var data = message['data'];
        notif = data['notif'];
        kode = data['kode'];
        page = data['page'];
        snacktitle = data['snacktitle'];
        snackbody = data['snackbody'];
      }
      debugPrint('notif: $notif & kode: $kode & page: $page $snacktitle $snackbody');
      showFlushbar(context: context,
          flushbar: Flushbar(
            title: snacktitle,
            message: snackbody,
            backgroundColor: Colors.red[900].withOpacity(0.3),
            flushbarPosition: FlushbarPosition.TOP,
            icon: Icon(
              Icons.info_outline,
              size: 28.0,
              color: Colors.green,
            ),
            flushbarStyle: FlushbarStyle.FLOATING,
            duration: Duration(seconds: 3),
            boxShadows: [BoxShadow(color: Colors.red[900].withOpacity(0.3), offset: Offset(0.0, 2.0), blurRadius: 3.0,)],
          )..show(context)
      );
      switch (type) {
        case 'onResume':
        case 'onLaunch':
          {
            if (page == "1") {
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


  _getLoginSplash() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var splash = preferences.getInt('splash');
    var valueLogin = preferences.getInt('valueLogin');
    setState(() {
      if (valueLogin == 1) {
        debugPrint('Splash : Done route to Login Page');
        _screenStatus = LoginStatus.onDashboard;
      } else {
        if (splash==1) {
          _screenStatus = LoginStatus.onLogin;
        } else {
          _screenStatus = LoginStatus.onSplash;
        }
        // Navigator.pushReplacement(
        //   context,
        //   MaterialPageRoute(builder: (context) => SplashConfig()),
        // );
      }
    });
  }
  ProgressDialog _progressDialog = ProgressDialog();
  void signOut() async {
    _progressDialog.showProgressDialog(context,
        dismissAfter: Duration(seconds: 5),
        textToBeDisplayed: 'System in Progress...',
        onDismiss: () {});
    var idadd = await  Hive.openBox('id');
    var _iddata = idadd.get('id');
    final response = await http.post(SumberApi.logout, body: {"id": _iddata});
    final data = jsonDecode(response.body);
    int valueApi = data['value'];
    _progressDialog.dismissProgressDialog(context);
    if (valueApi == 0) {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      setState(() {
        preferences.setInt('valueLogin',valueApi);
        _screenStatus = LoginStatus.onLogin;
      });
    } else {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: Text("Connection Error, Please try again!"),
            );
          });
    }
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
    _firebaseMessaging.getToken().then((String token) async {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.setString('token', token);
      debugPrint('getToken: $token');
      setState(() {
        this.token = token;
      });
    });
    controller = AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    super.initState();
    _getLoginSplash();
  }

  @override
  Widget build(BuildContext context) {
    switch (_screenStatus) {
      case LoginStatus.onDashboard:
        return ViewModelBuilder<HomeViewModel>.reactive(
            viewModelBuilder: () => HomeViewModel(),
            onModelReady: (model) => model.getData(),
            builder: (context, model, child) => Scaffold(
          key: _scaffoldState,
          body: KontrolPage(model.produkList),
          bottomNavigationBar: LayoutBuilder(
            builder: (context, constraints) {
              double width = constraints.maxWidth;
              double itemWidth = width / menuList.length;
              double floatingIconRadius = itemWidth * 0.2;
              return Container(
                color: Colors.white,
                child: Stack(children: [
                  Positioned(
                    child: Container(
                      width: width,
                      child: Stack(
                        overflow: Overflow.visible,
                        children: <Widget>[
                          // floating icon
                          Positioned(
                            top: controller.value <= 0.5
                                ? (controller.value * height - height * 0.2)
                                : (1 - controller.value) * height -
                                height * 0.2,
                            left: moveProgress * itemWidth + itemWidth / 2 -
                                floatingIconRadius,
                            child: CircleAvatar(
                              radius: floatingIconRadius,
                              backgroundColor: Colors.red,
                              child: Icon(
                                menuList[currentIndex],
                                color: Colors.white,
                              ),
                            ),
                          ),

                          CustomPaint(
                            child: SizedBox(
                              height: height,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceAround,
                                children: menuList
                                    .asMap()
                                    .keys
                                    .map((value) {
                                  return GestureDetector(
                                    child: Opacity(
                                      opacity: currentIndex == value ? 0 : 1,
                                      child: CircleAvatar(
                                        backgroundColor: Colors.white,
                                        child: Icon(menuList[value],
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                    onTap: () {
                                      changeIndex(value);
                                    },
                                  );
                                }).toList(),
                              ),
                            ),
                            painter: NotchedPainter(itemCount: menuList.length,
                                progress: moveProgress),
                          ),
                        ],
                      ),
                    ),
                  )
                ]),
              );
            },
          ),
            )// This trailing comma makes auto-formatting nicer for build methods.
        );
      case LoginStatus.onSplash:
        return SplashConfig();
        break;
      case LoginStatus.onLogin:
        return WelcomePage();
        break;
    }
    }
    // Switch navigation
    changeIndex(int newIndex) {
      double oldPosition = currentIndex.toDouble();
      double newPosition = newIndex.toDouble();
      if (oldPosition != newPosition &&
          controller.status != AnimationStatus.forward) {
        controller.reset();
        animation = Tween(begin: oldPosition, end: newPosition)
            .animate(
            CurvedAnimation(parent: controller, curve: Curves.easeInOutCubic))
          ..addListener(() {
            setState(() => moveProgress = animation.value);
          })
          ..addStatusListener((AnimationStatus status) {
            if (status == AnimationStatus.completed) {
              setState(() => currentIndex = newIndex);
            }
          });
        controller.forward();
      }
    }

    @override
    void dispose() {
      controller.dispose();
      super.dispose();
    }

  KontrolPage(List produkList) {
    if (menuList[currentIndex] == Icons.person) {
      return ViewModelBuilder<HomeProfile>.reactive(
          viewModelBuilder: () => HomeProfile(),
          onModelReady: (model) => model.getData(),
          builder: (context, model, child) => ProfilePage(
            model.produkReadydata,
            model.appNewsdata,
            model.iddata,
            model.namadata,
            model.phonedata,
            model.alamatdata,
            model.emaildata,
            model.passworddata,
            model.tgldaftardata,
            model.statusdata,
            model.updatedata,
            signOut,
          ));
    }
    else if (menuList[currentIndex] == Icons.shopping_bag_outlined) {
      return ProdukPage(produkList);
    }
    else if (menuList[currentIndex] == Icons.shopping_cart) {
       return CartPage();
    }
    else if (menuList[currentIndex] == Icons.library_books) {
      return HelpPage();
    }
    else {
      return HomePage(produkList);
    }
  }
}
