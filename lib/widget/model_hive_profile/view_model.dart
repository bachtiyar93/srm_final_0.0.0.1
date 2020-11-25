import 'dart:convert';
import 'package:hive/hive.dart';
import 'package:srm_final/apikey/sumberapi.dart';
import 'package:srm_final/widget/model_hive/hive_service.dart';
import 'package:srm_final/widget/model_hive/locator.dart';
import 'package:stacked/stacked.dart';
import 'package:http/http.dart' as http;


class HomeProfile extends BaseViewModel {
  final HiveService hiveService = locator<HiveService>();

  //hive ambil
  var _produkReadydata = '';
  var _appNewsdata = '';
  var _iddata = '';
  var _namadata = '';
  var _phonedata = '';
  var _alamatdata = '';
  var _emaildata = '';
  var _passworddata = '';
  var _tgldaftardata = '';
  var _statusdata = '';
  var _updatedata = '';
  get produkReadydata => _produkReadydata;
  get appNewsdata => _appNewsdata;
  get iddata => _iddata;
  get namadata => _namadata;
  get phonedata => _phonedata;
  get alamatdata => _alamatdata;
  get emaildata => _emaildata;
  get passworddata => _passworddata;
  get tgldaftardata => _tgldaftardata;
  get statusdata => _statusdata;
  get updatedata => _updatedata;

  getData() async {
    print("Entered get Data()");
    bool exists = await hiveService.isExists(boxName: "produkReady");
    if (exists) {
      print("Getting data from Hive profile");
      setBusy(true);
      //hive Buka
      var produkReadyadd =await  Hive.openBox('produkReady');
      var appNewsadd = await  Hive.openBox('appNews');
      var idadd = await  Hive.openBox('id');
      var namaadd =await  Hive.openBox('nama');
      var phoneadd = await Hive.openBox('phone');
      var alamatadd = await Hive.openBox('alamat');
      var emailadd =await Hive.openBox('email');
      var passwordadd = await Hive.openBox('password');
      var tgldaftaradd = await Hive.openBox('tgldaftar');
      var statusadd =await Hive.openBox('status');
      var updateadd = await Hive.openBox('update');

      _produkReadydata = produkReadyadd.get('produkReady');
      _appNewsdata = appNewsadd.get('appNews');
      _iddata = idadd.get('id');
      _namadata = namaadd.get('nama');
      _phonedata = phoneadd.get('phone');
      _alamatdata = alamatadd.get('alamat');
      _emaildata = emailadd.get('email');
      _passworddata = passwordadd.get('password');
      _tgldaftardata = tgldaftaradd.get('tgldaftar');
      _statusdata = statusadd.get('status');
      _updatedata = updateadd.get('update');
      setBusy(false);
    } else {
      print("Getting data from Api profile");
      setBusy(true);
      final response = await http.post(SumberApi.profile, body: {"id":"1"});
      final json = jsonDecode(response.body);
      String produkReady = json["produk_ready"];
      String appNews= json["app_news"];
      String id= json["id"];
      String nama= json["nama"];
      String phone= json["phone"];
      String alamat= json["alamat"];
      String email= json["email"];
      String password= json["password"];
      String  tgldaftar= json["tgldaftar"];
      String status= json["status"];
      String update= json["update"];
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

      //hive ambil
      _produkReadydata = produkReadyaddt.get('produkReady');
      _appNewsdata = appNewsaddt.get('appNews');
      _iddata = idaddt.get('id');
      _namadata = namaaddt.get('nama');
      _phonedata = phoneaddt.get('phone');
      _alamatdata = alamataddt.get('alamat');
      _emaildata = emailaddt.get('email');
      _passworddata = passwordaddt.get('password');
      _tgldaftardata = tgldaftaraddt.get('tgldaftar');
      _statusdata = statusaddt.get('status');
      _updatedata = updateaddt.get('update');


      print("Getting data $nama");
      setBusy(false);
    }
  }
}
