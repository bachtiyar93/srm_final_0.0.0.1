import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:custom_progress_dialog/custom_progress_dialog.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:srm_final/apikey/sumberapi.dart';
import 'package:srm_final/dashboard/dashboard.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoginTree(),
    );
  }
}

class LoginTree extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginTreeState();
}

enum LoginStatus { suksesSignIn, belumSignIn }

class _LoginTreeState extends State<LoginTree> {
  LoginStatus _loginStatus = LoginStatus.belumSignIn;
  final scaffoldState = GlobalKey<ScaffoldState>();
  bool _secureText = true;
  String phone, password;
  final _key = new GlobalKey<FormState>();
  var theme;
  String sambutan, phoneT, sandi, btnText, phonesalah, sandisalah;

  void changeBahasa() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var bahasa = preferences.getInt('bahasa');
    theme = preferences.getInt('theme');
    if (bahasa == 1) {
      setState(() {
        sambutan = 'Selamat Datang';
        phoneT = 'Telepon';
        sandi = 'Sandi';
        btnText = 'Login';
        phonesalah = 'Silahkan masukan nomor telepon terdaftar';
        sandisalah = 'Masukan password anda';
      });
    } else {
      setState(() {
        sambutan = 'Welcome';
        phoneT = 'Phone';
        sandi = 'Password';
        btnText = 'Login';
        phonesalah = 'Please insert your phone number';
        sandisalah = 'Please insert correct your password';
      });
    }
  }

  Color bgColor, trackColor, dColor, fontColor, btnColor, shiMer;
  void changeTheme() async {
    if (theme == 1) {
      setState(() {
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
        debugPrint('Theme Dark');
        shiMer = Colors.yellow[800];
        bgColor = Color.fromRGBO(50, 50, 50, 1);
        trackColor = Colors.white;
        dColor = Colors.black;
        fontColor = Color.fromRGBO(225, 225, 225, 1);
        btnColor = Color.fromRGBO(220, 1, 1, 1);
      });
    }
  }

  //Inisialisasi onMessage,Background dan saat launch
  @override
  void initState() {
    changeTheme();
    changeBahasa();
    super.initState();
  }

  @override
  // ignore: missing_return
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    double widthScreen = mediaQueryData.size.width;
    switch (_loginStatus) {
      case LoginStatus.belumSignIn:
        return Scaffold(
          backgroundColor: bgColor,
          body: Form(
            key: _key,
            child: ListView(
              padding: EdgeInsets.all(16.0),
              children: <Widget>[
                Image.asset(
                  'assets/ic_logo.png',
                  width: 200.0,
                  height: 200.0,
                ),
                new Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Text(sambutan,
                        style: new TextStyle(
                            color: fontColor,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic)),
                  ],
                ),
                Column(
                  children: <Widget>[
                    TextFormField(
                      // ignore: missing_return
                      validator: (e) {
                        if (e.isEmpty) {
                          return phonesalah;
                        }
                      },
                      onSaved: (e) => phone = e,
                      decoration: InputDecoration(
                        labelText: phoneT,
                      ),
                    ),
                  ],
                ),
                TextFormField(
                  // ignore: missing_return
                  validator: (e) {
                    if (e.isEmpty) {
                      return sandisalah;
                    }
                  },
                  cursorColor: fontColor,
                  obscureText: _secureText,
                  onSaved: (e) => password = e,
                  decoration: InputDecoration(
                    labelText: sandi,
                    focusColor: btnColor,
                    suffixIcon: IconButton(
                      onPressed: showHide,
                      icon: Icon(_secureText
                          ? Icons.visibility_off
                          : Icons.visibility),
                    ),
                  ),
                ),
                //Divider Login
                Divider(
                  height: 14.0,
                  color: Colors.white,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin:
                      const EdgeInsets.only(left: 30.0, right: 30.0, top: 20.0),
                  alignment: Alignment.center,
                  child: new Row(
                    children: <Widget>[
                      new Expanded(
                        child: new FlatButton(
                          color: Colors.green,
                          onPressed: () {
                            check();
                          },
                          shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30.0),
                          ),
                          child: new Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 20.0,
                              horizontal: 20.0,
                            ),
                            child: new Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                new Expanded(
                                  child: Text(
                                    btnText,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                //Akhir Divider Login
              ],
            ),
          ),
        );
        break;
      case LoginStatus.suksesSignIn:
        return Dashboard(signOut);
    }
  }

  void showHide() {
    setState(() {
      _secureText = !_secureText;
    });
  }

  void check() async {
    final form = _key.currentState;
    if (form.validate()) {
      form.save();
      login();
      _progressDialog.showProgressDialog(context,
          textToBeDisplayed: 'Menghubungi Toko', onDismiss: () {});
    }
  }

  ProgressDialog _progressDialog = ProgressDialog();
  void login() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var token = preferences.getString('token');
    final response = await http.post(SumberApi.login,
        body: {"phone": phone, "password": password, "token": token});
    //terima data
    final data = jsonDecode(response.body);

    int valueApi = data['value'];
    int idApi = data['id'];
    String pesanApi = data['message'];
    debugPrint('valueApi:$valueApi idApi:$idApi');

    if (valueApi == 1) {
      setState(() {
        _loginStatus = LoginStatus.suksesSignIn;
        saveInformasiLogin(valueApi, idApi, phoneApi);
      });
      _progressDialog.dismissProgressDialog(context);
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: Text(pesanApi),
            );
          });
    } else {
      _progressDialog.dismissProgressDialog(context);
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: Text(pesanApi),
            );
          });
    }
  }

  void saveInformasiLogin(int valueApi, int idApi, String phoneApi) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences.setInt("valueApi", valueApi);
      preferences.setInt("idApi", idApi);
      preferences.setString("phoneApi", phoneApi);
      // ignore: deprecated_member_use
      preferences.commit();
      _loginStatus = LoginStatus.suksesSignIn;
    });
  }

  var valueApi, idApi, phoneApi;
  void konfirmasiDariServer() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      valueApi = preferences.getInt("valueApi");
      idApi = preferences.getInt("idApi");
      if (valueApi == 1) {
        _loginStatus =
            valueApi == 1 ? LoginStatus.suksesSignIn : LoginStatus.belumSignIn;
      } else {
        _loginStatus = LoginStatus.belumSignIn;
      }
    });
  }

  void signOut() async {
    _progressDialog.showProgressDialog(context,
        dismissAfter: Duration(seconds: 5),
        textToBeDisplayed: 'System in Progress...',
        onDismiss: () {});
    final response = await http.post(SumberApi.logout, body: {"id": idApi});
    final data = jsonDecode(response.body);
    int valueApi = data['value'];
    String pesanApi = data['message'];
    _progressDialog.dismissProgressDialog(context);
    if (valueApi == 0) {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: Text(pesanApi),
            );
          });
      setState(() {
        preferences.clear();
        // ignore: deprecated_member_use
        preferences.commit();
        _loginStatus = LoginStatus.belumSignIn;
      });
    } else {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: Text(pesanApi),
            );
          });
    }
  }
}
