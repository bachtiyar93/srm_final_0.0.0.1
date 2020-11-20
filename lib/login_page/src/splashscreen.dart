import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:srm_final/login_page/src/welcomePage.dart';

class SplashConfig extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SplashConfigTree(),
    );
  }
}

class SplashConfigTree extends StatefulWidget {
  @override
  _SplashConfigTreeState createState() => _SplashConfigTreeState();
}

class _SplashConfigTreeState extends State<SplashConfigTree> {
  bool flags = false;
  Color bgColor, trackColor, dColor, fontColor, btnColor, shiMer;
  int theme;
  void changeTheme() async {
    if (flags == false) {
      setState(() {
        theme = 1;
        debugPrint('Theme Light');
        shiMer = Colors.white;
        bgColor = Colors.white;
        trackColor = Colors.black;
        dColor = Colors.white;
        fontColor = Color.fromRGBO(1, 1, 1, 1);
        btnColor = Color.fromRGBO(225, 50, 50, 1);
      });
    } else {
      setState(() {
        theme = 2;
        debugPrint('Theme Dark');
        shiMer = Colors.yellow[800];
        bgColor = Color.fromRGBO(30, 30, 30, 1);
        trackColor = Colors.white;
        dColor = Colors.black;
        fontColor = Color.fromRGBO(225, 225, 225, 1);
        btnColor = Color.fromRGBO(220, 1, 1, 1);
      });
    }
  }

  String tema, light, dark, btnText;
  void changeBahasa() async {
    if (dropdownValue == 'Bahasa Indonesia') {
      tema = 'Tema';
      light = 'Terang';
      dark = 'Gelap';
      btnText = 'Lanjutkan';
    } else {
      tema = 'Theme';
      light = 'Light';
      dark = 'Dark';
      btnText = "Let's Go";
    }
  }

  String dropdownValue;

  List<String> bahasa = [
    'English',
    'Bahasa Indonesia',
  ];

  @override
  void initState() {
    changeBahasa();
    changeTheme();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    double widthScreen = mediaQueryData.size.width;

    String valuedropdown;
    if (dropdownValue == null) {
      valuedropdown = "Please choose language";
    } else {
      valuedropdown = btnText;
    }
    return Container(
      color: bgColor,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/ic_logo.png',
              height: widthScreen * 0.3,
              width: widthScreen * 0.3,
            ),
            Shimmer.fromColors(
                child: Text(
                  'Sweet Room Medan',
                  style: GoogleFonts.alexBrush(fontSize: widthScreen * 0.09),
                ),
                baseColor: Colors.red[900],
                highlightColor: shiMer),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  tema,
                  style: TextStyle(
                    color: fontColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  light,
                  style: TextStyle(
                    color: fontColor,
                  ),
                ),
                Switch(
                  activeColor: btnColor,
                  inactiveThumbColor: btnColor,
                  activeTrackColor: trackColor,
                  inactiveTrackColor: trackColor,
                  value: flags,
                  onChanged: (v) {
                    setState(() {
                      flags = v;
                      changeTheme();
                    });
                  },
                ),
                Text(
                  dark,
                  style: TextStyle(
                    color: fontColor,
                  ),
                ),
              ],
            ),
            DropdownButton<String>(
              dropdownColor: dColor,
              hint: Text(
                'Language',
                style: TextStyle(color: fontColor),
              ),
              value: dropdownValue,
              icon: Icon(Icons.arrow_drop_down),
              iconSize: 24,
              elevation: 16,
              style: TextStyle(color: fontColor, fontSize: 18),
              underline: Container(
                height: 2,
                color: btnColor,
              ),
              onChanged: (String data) {
                setState(() {
                  dropdownValue = data;
                  changeBahasa();
                });
              },
              items: bahasa.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Row(
                    children: [
                      Icon(
                        Icons.flag_outlined,
                        color: fontColor,
                      ),
                      Text(
                        value,
                        style: TextStyle(color: fontColor),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
            InkWell(
              onTap: () async {
                if (valuedropdown != 'Please choose language') {
                  SharedPreferences preferences =
                  await SharedPreferences.getInstance();
                  setState(() {
                    preferences.setInt('splash', 1);
                    preferences.setInt('theme', theme);
                    if (dropdownValue == 'English') {
                      preferences.setInt('bahasa', 2);
                    } else {
                      preferences.setInt('bahasa', 1);
                    }
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => WelcomePage()));
                  });
                }
              },
              child: Container(
                width: widthScreen*0.7,
                height: 50,
                padding: EdgeInsets.symmetric(vertical: 15),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                          color: Colors.grey.shade200,
                          offset: Offset(2, 4),
                          blurRadius: 5,
                          spreadRadius: 2)
                    ],
                    gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [Colors.red, Colors.red[900]])),
                child: Text(
                  valuedropdown,
                  style: TextStyle( color: fontColor),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
