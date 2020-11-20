import 'anime.dart';
import 'package:stacked/stacked.dart';
import 'api_service.dart';
import 'hive_service.dart';
import 'locator.dart';

class HomeViewModel extends BaseViewModel {
  final HiveService hiveService = locator<HiveService>();
  final APIService apiService = locator<APIService>();

  List<dynamic> _produkList = [];
  List<dynamic> get produkList => _produkList;
  String _text="";
  String get text=>_text;

  final String url = "https://sweetroommedan.com/android/produk_ready.php";

  getData() async {
    print("Entered get Data()");
    _text="Fetching data";
    bool exists = await hiveService.isExists(boxName: "ProdukTabel");
    if (exists) {
      _text="Fetching from hive";
      print("Getting data from Hive");
      setBusy(true);
      _produkList = await hiveService.getBoxes("ProdukTabel");
      setBusy(false);
    } else {
      _text="Fetching from Server";
      print("Getting data from Api");
      setBusy(true);
      var result = await apiService.fetchData(url: url);
      (result as List).map((terima) {
        Produk produk = Produk(
            id: int.parse(terima["id"]),
        kain: terima["kain"],
        seri: terima["seri"],
        harga: int.parse(terima["harga"]),
        stok: int.parse(terima["stok"]),
        tglMasuk: DateTime.parse(terima["tgl_masuk"]),
        kondisi: int.parse(terima["kondisi"]),
        bidang: int.parse(terima["bidang"]),
        rate: int.parse(terima["rate"]),
        pembeli: int.parse(terima["pembeli"]),
        dilihat: int.parse(terima["dilihat"]),
        images: List<String>.from(terima["images"].map((x) => x)));
        _produkList.add(produk);
      }).toList();
      _text="Caching data";
      await hiveService.addBoxes(_produkList, "ProdukTabel");
      setBusy(false);
    }
  }
}
