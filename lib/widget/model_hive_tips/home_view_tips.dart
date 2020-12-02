import 'package:srm_final/apikey/sumberapi.dart';
import 'package:srm_final/widget/model_hive/api_service.dart';
import 'package:srm_final/widget/model_hive/hive_service.dart';
import 'package:srm_final/widget/model_hive/locator.dart';
import 'package:srm_final/widget/model_hive_tips/tips.dart';
import 'package:stacked/stacked.dart';

class TipsView extends BaseViewModel {
  final HiveService hiveService = locator<HiveService>();
  final APIService apiService = locator<APIService>();

  List<dynamic> _tipsList = [];
  List<dynamic> get tipsList => _tipsList;
  final String url = SumberApi.tips;
  String _text="";
  String get text=>_text;

  getData() async {
    print("Entered get Data");
    _text="Fetching data";
    bool exists = await hiveService.isExists(boxName: "TipsTabel");
    if (exists) {
      print("Getting data from Hive Tips");
      setBusy(true);
      _tipsList = await hiveService.getBoxesTypeList("TipsTabel");
      setBusy(false);
    } else {
      print("Getting data from Api Tips");
      setBusy(true);
      var result = await apiService.fetchData(url: url);
      (result as List).map((terima) {
        Tips tips = Tips(
            id: terima["id"],
            judul:  terima["judul"],
            body: terima["body"]);
        _tipsList.add(tips);
      }).toList();
      await hiveService.addBoxesTypeList(_tipsList, "TipsTabel");
      setBusy(false);
    }
  }
}
