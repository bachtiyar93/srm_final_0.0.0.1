import 'dart:convert';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:custom_progress_dialog/custom_progress_dialog.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:srm_final/apikey/sumberapi.dart';
import 'package:srm_final/main.dart';
import 'Widget/bezierContainer.dart';
import 'loginPageMail.dart';
import 'signup.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _LoginPageState createState() => _LoginPageState();
}
enum LoginStatus { suksesSignIn, belumSignIn }
class _LoginPageState extends State<LoginPage> {
  LoginStatus _loginStatus = LoginStatus.belumSignIn;
  final _keyForm = new GlobalKey<FormState>();

  @override
  void initState() {
    changeTheme();
    changeBahasa();
    super.initState();
  }

  String phoneKurang,
      phoneInvalid,
      lupaPassword,
      tidakAdaAkun,
      phoneText,
      sandi,
      tombolLogin,
      phoneKosong,
      sandisalah,
      registrasi,
      back,
      or,
      textLoginEmail,
      logoutSukses,
      logoutGagal;
  void changeBahasa() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var bahasa = preferences.getInt('bahasa');
    if (bahasa == 1) {
      setState(() {
        logoutSukses='Anda telah keluar';
        logoutGagal ='Logout gagal, periksa koneksi anda';
        textLoginEmail='Login dengan Email';
        or='atau';
        back = 'Kembali';
        registrasi= 'Daftar';
        tidakAdaAkun = 'Belum memiliki akun?';
        phoneText = 'Telepon';
        sandi = 'Sandi';
        tombolLogin = 'Login';
        phoneKosong = 'Silahkan masukan nomor telepon terdaftar';
        sandisalah = 'Masukan password anda';
        lupaPassword= 'Lupa Password?';
        phoneInvalid = 'Telepon tidak valid';
        phoneKurang = 'Telepon tidak terdaftar';
      });
    } else {
      setState(() {
        logoutSukses='Logout data is Removed';
        logoutGagal ='Failed to logout, please check connection';
        lupaPassword = 'Forgot Password?';
        textLoginEmail='Login with Mail';
        or = 'or';
        back= 'Back';
        registrasi='Register';
        tidakAdaAkun = "Don't have account?";
        phoneText = 'Phone';
        sandi = 'Password';
        tombolLogin = 'Login';
        phoneKosong = 'Please insert your phone number';
        sandisalah = 'Please insert correct your password';
        phoneInvalid ="Invalid Number don't use Symbol";
        phoneKurang = "Invalid Number";
      });
    }
  }

  Color gradientBawah, gradientAtas, loginButton, fontButton, shimer, fontColor, bgcolor;
  void changeTheme() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var theme = preferences.getInt('theme');
    if (theme == 1) {
      setState(() {
        debugPrint('Theme Light');
        bgcolor = Colors.white;
        shimer = Colors.white;
        gradientAtas = Colors.white;
        gradientBawah =Color.fromRGBO(225, 10, 10, 1);
        loginButton = Color.fromRGBO(225, 10, 10, 1);
        fontButton = Colors.white;
        fontColor = Colors.black;
      });
    } else {
      setState(() {
        debugPrint('Theme Dark');
        bgcolor = Color.fromRGBO(30, 30, 30, 1);
        shimer = Colors.yellow[800];
        gradientAtas = Color.fromRGBO(30, 1, 1, 1);
        gradientBawah = Color.fromRGBO(30, 30, 30, 1);
        loginButton = Color.fromRGBO(225, 10, 10, 1);
        fontButton = Colors.white;
        fontColor = Colors.white;
      });
    }
  }


  Widget _backButton() {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 0, top: 10, bottom: 10),
              child: Icon(Icons.keyboard_arrow_left, color: fontColor),
            ),
            Text(back,
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: fontColor))
          ],
        ),
      ),
    );
  }


  Widget _submitButton() {
    return InkWell(
      onTap: check,
      child: Container(
        width: MediaQuery.of(context).size.width,
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
                colors: [Colors.red, Color.fromRGBO(225, 10, 10, 1)])),
        child: Text(
          tombolLogin,
          style: TextStyle(fontSize: 20, color: fontButton),
        ),
      ),
    );
  }

  Widget _divider() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Divider(
                thickness: 1,
              ),
            ),
          ),
          Text(or, style: TextStyle(color: fontColor),),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Divider(
                thickness: 1,
              ),
            ),
          ),
          SizedBox(
            width: 20,
          ),
        ],
      ),
    );
  }

  Widget _mailButton() {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LoginPageMail()));
      },
      child: Container(
        height: 50,
        margin: EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(
                decoration: BoxDecoration(
                  color: loginButton,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(5),
                      topLeft: Radius.circular(5)),
                ),
                alignment: Alignment.center,
                child: Icon(Icons.mail),
              ),
            ),
            Expanded(
              flex: 5,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.red[500],
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(5),
                      topRight: Radius.circular(5)),
                ),
                alignment: Alignment.center,
                child: Text(textLoginEmail,
                    style: TextStyle(
                        color: fontButton,
                        fontSize: 18,
                        fontWeight: FontWeight.w400)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _createAccountLabel() {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => SignUpPage()));
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20),
        padding: EdgeInsets.all(15),
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              tidakAdaAkun,
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: fontColor),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              registrasi,
              style: TextStyle(
                  color: Color(0xfff79c4f),
                  fontSize: 13,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
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
  void showHide() {
    setState(() {
      isPassword = !isPassword;
    });
  }
  bool isPassword=true;
  var _phone, _password;
  RegExp regx = RegExp(r"^[0-9]*$",caseSensitive: false);
  Widget _emailPasswordWidget() {
    return Form(
      key: _keyForm,
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    phoneText,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: fontColor),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                      validator: (e) {
                        if (e.isEmpty) {
                          return  phoneKosong;
                        } else if (e.length <= 10){
                          return phoneKurang;
                        } else if (!(regx.hasMatch(e))){
                        return phoneInvalid;
                        } return null;
                      },
                      onSaved: (e) => _phone = e,
                      cursorColor: fontColor,
                      decoration: InputDecoration(
                          hintText: "081 xxx xxx xxx",
                          focusColor: fontColor,
                          border: InputBorder.none,
                          fillColor: Color(0xfff3f3f4),
                          filled: true))
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    sandi,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: fontColor),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    cursorColor: fontColor,
                      validator: (e) {
                        if (e.isEmpty) {
                          return  sandisalah;
                        } return null;
                      },
                      obscureText: isPassword,
                      onSaved: (e) => _password = e,
                      decoration: InputDecoration(
                          suffixIcon: IconButton(
                            onPressed: showHide,
                            icon: Icon(isPassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                              color: Color.fromRGBO(225, 10, 10, 1),
                            ),
                          ),
                          hintText: sandi,
                          focusColor: fontColor,
                          border: InputBorder.none,
                          fillColor: Color(0xfff3f3f4),
                          filled: true))
                ],
              ),
            )
          ],
        )
    );
  }

  @override
  // ignore: missing_return
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    switch (_loginStatus) {
      case LoginStatus.belumSignIn:
    return Scaffold(
      backgroundColor: bgcolor,
        body: Container(
      height: height,
      child: Stack(
        children: <Widget>[
          Positioned(
              top: 0,
              right: 0,
              child: BezierContainer()),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: height * .2),
                  _title(),
                  SizedBox(height: 50),
                  _emailPasswordWidget(),
                  SizedBox(height: 20),
                  _submitButton(),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    alignment: Alignment.centerRight,
                    child: Text(lupaPassword,
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w500, color: fontColor)),
                  ),
                  _divider(),
                  _mailButton(),
                  SizedBox(height: height * .055),
                  _createAccountLabel(),
                ],
              ),
            ),
          ),
          Positioned(top: 40, left: 0, child: _backButton()),
        ],
      ),
    ));
      case LoginStatus.suksesSignIn:
        return App();
        break;
    }
  }
  ProgressDialog _progressDialog = ProgressDialog();
  void check() async {
    final form = _keyForm.currentState;
    if (form.validate()) {
      _progressDialog.showProgressDialog(context,
          textToBeDisplayed: 'Checking the system',
          barrierColor: Colors.transparent,
          onDismiss: () {});
      form.save();
      login();
    }
  }

  void login() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var token = preferences.getString('token');
    final response = await http.post(SumberApi.login,
        body: {"phone": _phone, "password": _password, "token": token});
    //terima data
    final data = jsonDecode(response.body);
    int valueLogin =data['value'];
    String produkReady = data["produk_ready"];
    String appNews= data["app_news"];
    String id= data["id"];
    String nama= data["nama"];
    String phone= data["phone"];
    String alamat= data["alamat"];
    String email= data["email"];
    String password= data["password"];
    String  tgldaftar= data["tgldaftar"];
    String status= data["status"];
    String update= data["update"];
    String pesanApi =data['message'];

    if (valueLogin == 1) {
      debugPrint('value: '+valueLogin.toString());
      //hive Buka
      var produkReadyaddt =await  Hive.openBox('produkReady');
      var appNewsaddt = await  Hive.openBox('appNews');
      var idaddt = await  Hive.openBox('id');
      var namaaddt =await  Hive.openBox('nama');
      var phoneaddt = await Hive.openBox('phone');
      var alamataddt = await Hive.openBox('alamat');
      var emailaddt =await Hive.openBox('email');
      var passwordaddt = await Hive.openBox('password');
      var tgldaftaraddt = await Hive.openBox('tgldaftar');
      var statusaddt =await Hive.openBox('status');
      var updateaddt = await Hive.openBox('update');

      //hive isi
      produkReadyaddt.put('produkReady', produkReady);
      appNewsaddt.put('appNews', appNews);
      idaddt.put('id', id);
      namaaddt.put('nama', nama);
      phoneaddt.put('phone', phone);
      alamataddt.put('alamat', alamat);
      emailaddt.put('email', email);
      passwordaddt.put('password', password);
      tgldaftaraddt.put('tgldaftar', tgldaftar);
      statusaddt.put('status', status);
      updateaddt.put('update', update);

      setState(() {
        _loginStatus = LoginStatus.suksesSignIn;
        saveInformasiLogin(valueLogin);
      });
      _progressDialog.dismissProgressDialog(context);
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: Text('Disarankan menutup aplikasi setelah login, dan membukanya kembali'),
            );
          });
    } else {
      setState(() {
        _loginStatus = LoginStatus.belumSignIn;
      });
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
  void saveInformasiLogin
      (int valueLogin) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences.setInt("valueLogin", valueLogin);
      _loginStatus = LoginStatus.suksesSignIn;
    });
  }

  var getId;
  int getValueLogin;
  //digunakan untuk pengiriman data logout
  void konfirmasiDariServer() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      getValueLogin = preferences.getInt("valueLogin");
      getId = preferences.getString("_id");
      _loginStatus = getValueLogin == 1 ? LoginStatus.suksesSignIn : LoginStatus.belumSignIn;
    });
  }
  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }
}
