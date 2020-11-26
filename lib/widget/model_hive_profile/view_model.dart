import 'package:hive/hive.dart';
import 'package:srm_final/widget/model_hive/hive_service.dart';
import 'package:srm_final/widget/model_hive/locator.dart';
import 'package:stacked/stacked.dart';


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
  }
}
