import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:custom_progress_dialog/custom_progress_dialog.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:srm_final/apikey/sumberapi.dart';
import 'package:srm_final/login_page/src/loginPage.dart';
import 'package:srm_final/main.dart';
import 'Widget/bezierContainer.dart';
import 'signup.dart';

class LoginPageMail extends StatefulWidget {
  LoginPageMail({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _LoginPageMailState createState() => _LoginPageMailState();
}
enum LoginStatus { suksesSignIn, belumSignIn }
class _LoginPageMailState extends State<LoginPageMail> {
  LoginStatus _loginStatus = LoginStatus.belumSignIn;
  final _keyForm = new GlobalKey<FormState>();

  @override
  void initState() {
    changeTheme();
    changeBahasa();
    super.initState();
  }

  String
  emailInvalid,
      lupaPassword,
      tidakAdaAkun,
      mailText,
      sandi,
      tombolLogin,
      emailKosong,
      sandisalah,
      registrasi,
      back,
      or,
      textLoginPhone,
      logoutSukses,
      logoutGagal;
  void changeBahasa() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var bahasa = preferences.getInt('bahasa');
    if (bahasa == 1) {
      setState(() {
        logoutSukses='Anda telah keluar';
        logoutGagal ='Logout gagal, periksa koneksi anda';
        textLoginPhone='Login dengan Telepon';
        or='atau';
        back = 'Kembali';
        registrasi= 'Daftar';
        tidakAdaAkun = 'Belum memiliki akun?';
        mailText = 'Email';
        sandi = 'Sandi';
        tombolLogin = 'Login';
        emailKosong = 'Silahkan masukan email terdaftar';
        sandisalah = 'Masukan password anda';
        lupaPassword= 'Lupa Password?';
        emailInvalid = 'Email tidak valid';
      });
    } else {
      setState(() {
        logoutSukses='Logout data is Removed';
        logoutGagal ='Failed to logout, please check connection';
        lupaPassword = 'Forgot Password?';
        textLoginPhone='Login with Phone';
        or = 'or';
        back= 'Back';
        registrasi='Register';
        tidakAdaAkun = "Don't have account?";
        mailText = 'Email';
        sandi = 'Password';
        tombolLogin = 'Login';
        emailKosong = 'Please insert your mail';
        sandisalah = 'Please insert correct your password';
        emailInvalid ="Invalid mail";
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
            context, MaterialPageRoute(builder: (context) => LoginPage()));
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
                child: Icon(Icons.phone),
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
                child: Text(textLoginPhone,
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
  var email, password;
  RegExp regx = RegExp(r"^[a-z0-9.a-z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-z0-9]+\.[a-z]+",caseSensitive: false);
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
                    mailText,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: fontColor),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                      validator: (e) {
                        if (e.isEmpty) {
                          return  emailKosong;
                        } else if (!(regx.hasMatch(e))){
                          return emailInvalid;
                        } return null;
                      },
                      onSaved: (e) => email = e,
                      cursorColor: fontColor,
                      decoration: InputDecoration(
                          hintText: "email@mail.com",
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
                      onSaved: (e) => password = e,
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
                      top: -height * .15,
                      right: -MediaQuery.of(context).size.width * .4,
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
        return MyApp();
        break;
    }
  }
  ProgressDialog _progressDialog = ProgressDialog();
  void check() async {
    final form = _keyForm.currentState;
    if (form.validate()) {
      form.save();
      login();
      _progressDialog.showProgressDialog(context,
          textToBeDisplayed: 'Checking the system', onDismiss: () {});
    }
  }
  void login() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var token = preferences.getString('token');
    final response = await http.post(SumberApi.login,
        body: {"email": email, "password": password, "token": token});
    //terima data
    final data = jsonDecode(response.body);

    int _id = data['id'];
    String _nama = data['nama'];
    String _phone = data['phone'];
    String _alamat = data['alamat'];
    String _email = data ['email'];
    String _password =data ['password'];
    String _tgldaftar = data['tgldaftar'];
    String _status =data['status'];
    int valueLogin =data['value'];
    String pesanApi =data['message'];


    if (valueLogin == 1) {
      setState(() {
        _loginStatus = valueLogin == 1 ? LoginStatus.suksesSignIn : LoginStatus.belumSignIn;
        saveInformasiLogin(valueLogin, _id, _nama, _phone, _alamat, _email, _password, _tgldaftar,_status);
      });
      _progressDialog.dismissProgressDialog(context);
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
  void saveInformasiLogin(valueLogin, _id, _nama, _phone, _alamat, _email, _password, _tgldaftar,_status) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences.setInt("valueLogin", valueLogin);
      preferences.setString("_id", _id);
      preferences.setString("_phone", _phone);
      preferences.setString("_alamat", _alamat);
      preferences.setString("_email", _email);
      preferences.setString("_password", _password);
      preferences.setString("_tgldaftar", _tgldaftar);
      preferences.setString("_status", _status);
      // ignore: deprecated_member_use
      preferences.commit();
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
    });
  }

  void signOut() async {
    _progressDialog.showProgressDialog(context,
        dismissAfter: Duration(seconds: 5),
        textToBeDisplayed: 'System in Progress...',
        onDismiss: () {});
    final response = await http.post(SumberApi.logout, body: {"id": getId});
    final data = jsonDecode(response.body);
    int valueApi = data['value'];
    _progressDialog.dismissProgressDialog(context);
    if (valueApi == 0) {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: Text(logoutSukses),
            );
          });
      setState(() {
        preferences.remove('valueLogin');
        // ignore: deprecated_member_use
        preferences.commit();
        _loginStatus = LoginStatus.belumSignIn;
      });
    } else {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: Text(logoutGagal),
            );
          });
    }
  }


}
