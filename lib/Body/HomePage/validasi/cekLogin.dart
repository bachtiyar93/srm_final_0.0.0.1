
import 'package:custom_progress_dialog/custom_progress_dialog.dart';
import 'package:flutter/material.dart';

class cekLogin extends StatefulWidget {
  @override
  _StatecekLogin createState() => _StatecekLogin();
}
enum LoginStatus {
  sudahMasuk,
  belumMasuk
}

class _StatecekLogin extends State <cekLogin> {
  LoginStatus _loginStatus = LoginStatus.belumMasuk;
  final _key = new GlobalKey<FormState>();
  ProgressDialog _progressDialog = ProgressDialog();

login () async {

}
check() async {
    final form = _key.currentState;
    if (form.validate()) {
      _progressDialog.showProgressDialog(context,
          dismissAfter: Duration(seconds: 5),
          textToBeDisplayed: 'Waiting Connection...', onDismiss: () {
            //things to do after dismissing -- optional
          });
      form.save();
      login();
      //dismissAfter - if null then progress dialog won't dismiss until dismissProgressDialog is called from the code.
      }
}




  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }

}