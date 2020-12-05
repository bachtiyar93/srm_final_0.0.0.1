import 'package:stacked/stacked.dart';
import 'api_service.dart';
import 'hive_service.dart';
import 'locator.dart';

class CartViewModel extends BaseViewModel {
  final HiveService hiveService = locator<HiveService>();
  final APIService apiService = locator<APIService>();

  List<dynamic> _cartList = [];
  List<dynamic> get cartList => _cartList;
  int _total =0;
  int get total =>_total;


  getData() async {
    print("Entered get Data()");
    bool exists = await hiveService.isExists(boxName: "CartTabel");
    if (exists) {
      print("Getting data from Hive Cart");
      setBusy(true);
      var acartList = await hiveService.getBoxesTypeList("CartTabel");
      _cartList = await hiveService.getBoxesTypeList("CartTabel");
      acartList.forEach((item){
        _total += item.harga;
      });
      setBusy(false);
    }
  }
}
