import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:custom_progress_dialog/custom_progress_dialog.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:srm_final/apikey/sumberapi.dart';
import 'file:///D:/develop/srm_final/lib/login_page/loginPage.dart';
import 'file:///D:/develop/srm_final/lib/login_page/welcomePage.dart';
import 'Widget/bezierContainer.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _SignUpPageState createState() => _SignUpPageState();
}
class _SignUpPageState extends State<SignUpPage> {
  final _keyRegis = new GlobalKey<FormState>();
  final TextEditingController _pass = TextEditingController();
  final TextEditingController _confirmPass = TextEditingController();

  @override
  void initState() {
    changeTheme();
    changeBahasa();
    super.initState();
  }
  String emailInvalid,
      lupaPassword,
      sudahPunyaAkun,
      mailText,
      sandiText,
      sandi2Text,
      tombolRegis,
      emailKosong,
      sandisalah,
      loginUp,
      back,
      namaText,
      alamatText,
      phoneText,
  namaKosong,
  phoneKosong,
  phoneInvalid,
  alamatKosong,
  sandiKosong,
  sandi2Kosong,
  sandiTidaksama,
  daftarberhasil,
  terdaftaroleh;
  void changeBahasa() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var bahasa = preferences.getInt('bahasa');
    if (bahasa == 1) {
      setState(() {
        daftarberhasil='Pendaftaran Berhasil';
        terdaftaroleh = 'Data telah terdaftar a/n: ';
        namaText= 'Nama';
        back = 'Kembali';
        loginUp= 'Login';
        sudahPunyaAkun = 'Sudah memiliki akun?';
        mailText = 'Email';
        sandiText = 'Sandi';
        sandi2Text = 'Konfirmasi Sandi';
        alamatText= 'Alamat';
        phoneText = 'Telepon';
        tombolRegis = 'Daftar';
        emailKosong = 'Silahkan masukan email terdaftar';
        sandisalah = 'Masukan password anda';
        lupaPassword= 'Lupa Password?';
        emailInvalid = 'Email tidak valid';
        namaKosong='Nama harus di isi';
        phoneKosong='No telepon tidak boleh kosong';
        phoneInvalid="Format telepon salah";
        alamatKosong= 'Alamat tidak boleh kosong';
        sandiKosong='Isi sandi anda';
        sandi2Kosong='Konfirmasi sandi anda';
        sandiTidaksama='Sandi tidak sama';
      });
    } else {
      setState(() {
        daftarberhasil='Success Registration!';
        terdaftaroleh = 'Already registered by: ';
        namaText='Name';
        lupaPassword = 'Forgot Password?';
        back= 'Back';
        loginUp='Login';
        sudahPunyaAkun = "Already have account?";
        mailText = 'Email';
        sandiText = 'Password';
        sandi2Text ='Confirm Password';
        alamatText= 'Address';
        phoneText = 'Phone';
        tombolRegis = 'Sign Up';
        emailKosong = 'Please insert your mail';
        sandisalah = 'Please insert correct your password';
        emailInvalid ="Invalid mail";
        namaKosong='Please insert your name';
        phoneKosong='Please insert your phone';
        phoneInvalid='Phone invalid';
        alamatKosong='Please insert you address';
        sandiKosong='Password must be set';
        sandi2Kosong='Please confirm your password';
        sandiTidaksama='Password incorrect';
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
          tombolRegis,
          style: TextStyle(fontSize: 20, color: fontButton),
        ),
      ),
    );
  }


  Widget _createAccountLabel() {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LoginPage()));
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20),
        padding: EdgeInsets.all(15),
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              sudahPunyaAkun,
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: fontColor),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              loginUp,
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
  var nama, phone, email, alamat, password, password2;
  RegExp regEmail = RegExp(r"^[a-z0-9.a-z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-z0-9]+\.[a-z]+",caseSensitive: false);
  RegExp regPhone = RegExp(r"^[0-9]*$",caseSensitive: false);
  Widget _emailPasswordWidget() {
    return Form(
        key: _keyRegis,
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    namaText,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: fontColor),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                      validator: (e) {
                        if (e.isEmpty) {
                          return  namaKosong;
                        }  return null;
                      },
                      onSaved: (e) => nama = e,
                      cursorColor: fontColor,
                      decoration: InputDecoration(
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
                        }  else if(!(regPhone.hasMatch(e))){
                          return phoneInvalid;
                        }return null;
                      },
                      onSaved: (e) => phone = e,
                      cursorColor: fontColor,
                      decoration: InputDecoration(
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
                        } else if (!(regEmail.hasMatch(e))){
                          return emailInvalid;
                        } return null;
                      },
                      onSaved: (e) => email = e,
                      cursorColor: fontColor,
                      decoration: InputDecoration(
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
                    alamatText,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: fontColor),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                      validator: (e) {
                        if (e.isEmpty) {
                          return  alamatKosong;
                        }  return null;
                      },
                      onSaved: (e) => alamat = e,
                      cursorColor: fontColor,
                      decoration: InputDecoration(
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
                    sandiText,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: fontColor),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: _pass,
                      cursorColor: fontColor,
                      validator: (e) {
                        if (e.isEmpty) {
                          return  sandiKosong;
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
                    sandi2Text,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: fontColor),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: _confirmPass,
                      cursorColor: fontColor,
                      validator: (e) {
                        if (e.isEmpty) {
                          return  sandi2Kosong;
                        } else if (e != _pass.text){
                          return sandiTidaksama;
                        }return null;
                      },
                      obscureText: isPassword,
                      onSaved: (e) => password2 = e,
                      decoration: InputDecoration(
                          suffixIcon: IconButton(
                            onPressed: showHide,
                            icon: Icon(isPassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                              color: Color.fromRGBO(225, 10, 10, 1),
                            ),
                          ),
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
                          _createAccountLabel(),
                        ],
                      ),
                    ),
                  ),
                  Positioned(top: 40, left: 0, child: _backButton()),
                ],
              ),
            ));
  }
  ProgressDialog _progressDialog = ProgressDialog();
  void check() async {
    final form = _keyRegis.currentState;
    if (form.validate()) {
      form.save();
      registrasiPage();
      _progressDialog.showProgressDialog(context,
          textToBeDisplayed: 'Checking System', onDismiss: () {});
    }
  }
  void registrasiPage() async {
    final response = await http.post(SumberApi.daftar,
        body: {"nama": nama, "phone": phone, "email": email, "alamat": alamat, "password": password});
    //terima data
    final data = jsonDecode(response.body);
    int valueApi = data['value'];
    String pesanApi = data['message'];

    if (valueApi == 1) {
      _progressDialog.dismissProgressDialog(context);
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: bgcolor,
              content: Text(daftarberhasil,
                style: TextStyle(color: fontColor),),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => WelcomePage()));
                    },
                    child: Text('Login', style: TextStyle(color: fontColor),))
              ],
            );
          });
    } else {
      _progressDialog.dismissProgressDialog(context);
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: bgcolor,
              content: Text(terdaftaroleh+pesanApi, style: TextStyle(color: fontColor),),
            );
          });
    }
  }
}
