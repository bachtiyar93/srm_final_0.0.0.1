import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'loginPage.dart';
import 'signup.dart';

class WelcomePage extends StatefulWidget {
  WelcomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  void initState() {
    changeBahasa();
    changeTheme();
    super.initState();
  }

  var theme;
  String fingerPrint='', phoneText='', sandi='', tombolLogin='', phoneInvalid='', sandisalah='', registrasi='';
  void changeBahasa() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var bahasa = preferences.getInt('bahasa');
    if (bahasa == 1) {
      setState(() {
        registrasi= 'Daftar Sekarang';
        fingerPrint = 'Login Cepat Sidik Jari';
        phoneText = 'Telepon';
        sandi = 'Sandi';
        tombolLogin = 'Login';
        phoneInvalid = 'Silahkan masukan nomor telepon terdaftar';
        sandisalah = 'Masukan password anda';
      });
    } else {
      setState(() {
        registrasi='Register Now';
        fingerPrint = 'Quick Login with Touch ID';
        phoneText = 'Phone';
        sandi = 'Password';
        tombolLogin = 'Login';
        phoneInvalid = 'Please insert your phone number';
        sandisalah = 'Please insert correct your password';
      });
    }
  }

  Color gradientBawah=Colors.white, gradientAtas=Colors.white, loginButton=Colors.white, fontButton=Colors.white, shimer=Colors.white;
  void changeTheme() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    theme = preferences.getInt('theme');
    if (theme == 1) {
      setState(() {
        debugPrint('Theme Light');
        shimer = Colors.white;
        gradientAtas = Colors.white;
        gradientBawah =Colors.red[900];
        loginButton = Color.fromRGBO(225, 10, 10, 1);
        fontButton = Colors.white;
      });
    } else {
      setState(() {
        debugPrint('Theme Dark');
        shimer = Colors.yellow[800];
        gradientAtas = Color.fromRGBO(30, 1, 1, 1);
        gradientBawah = Color.fromRGBO(30, 30, 30, 1);
        loginButton = Color.fromRGBO(225, 10, 10, 1);
        fontButton = Colors.white;
      });
    }
  }

  Widget _submitButton() {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LoginPage()));
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 13),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: fontButton,
                  offset: Offset(2, 4),
                  blurRadius: 8,
                  spreadRadius: 2)
            ],
            color: loginButton),
        child: Text(
          tombolLogin,
          style: TextStyle(fontSize: 20, color: fontButton),
        ),
      ),
    );
  }

  Widget _signUpButton() {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => SignUpPage()));
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 13),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          border: Border.all(color: fontButton, width: 2),
        ),
        child: Text(
         registrasi,
          style: TextStyle(fontSize: 20, color: fontButton),
        ),
      ),
    );
  }

  Widget _label() {
    return Container(
        margin: EdgeInsets.only(top: 40, bottom: 20),
        child: Column(
          children: <Widget>[
            Text(
              fingerPrint,
              style: TextStyle(color: fontButton, fontSize: 17),
            ),
            SizedBox(
              height: 20,
            ),
            Icon(Icons.fingerprint, size: 70, color: fontButton),
            SizedBox(
              height: 20,
            ),
            Text(
              'SCAN NOW',
              style: TextStyle(
                color: fontButton,
                fontSize: 15,
                decoration: TextDecoration.underline,
              ),
            ),
          ],
        ));
  }

  Widget _title() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset('assets/ic_logo.png',
          height: 90,
          width: 90,
        ),
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            text: 'Sweet Room Medan',
            style: GoogleFonts.alexBrush(
              fontSize: 28,
              color: Color.fromRGBO(225, 10, 10, 1),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SingleChildScrollView(
        child:Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            height: MediaQuery.of(context).size.width*2,
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
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [gradientAtas, gradientBawah])),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _title(),
                SizedBox(
                  height: 80,
                ),
                _submitButton(),
                SizedBox(
                  height: 20,
                ),
                _signUpButton(),
                SizedBox(
                  height: 20,
                ),
                _label()
              ],
            ),
          ),
      ),
    );
  }
}
