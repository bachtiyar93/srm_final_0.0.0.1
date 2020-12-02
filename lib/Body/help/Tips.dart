import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:srm_final/widget/help/TipsItem.dart';
import 'package:srm_final/widget/loading.dart';
import 'package:srm_final/widget/model_hive_tips/home_view_tips.dart';
import 'package:stacked/stacked.dart';

class HelpPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState()=> _HelpPage();
}
class _HelpPage extends State<HelpPage> {
  double cWidth = 0.0;
  double screenWidth;
  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width - 40;
    return ViewModelBuilder<TipsView>.reactive(
    viewModelBuilder: () => TipsView(),
    onModelReady: (model) => model.getData(),
    builder: (context, model, child) => Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Column(
          children: [
            Text("Riwayat Transaksi",
                style: GoogleFonts.lato(color: Colors.black)),
            Text('Anda memiliki '+model.tipsList.length.toString()+' transaksi',
              style: TextStyle(fontSize: 14),
            ),
          ],
        ),
      ),
      body:  model.tipsList.length != 0
        ? NotificationListener(
      onNotification: (ScrollNotification scrollNotification) {
        double progress = scrollNotification.metrics.pixels / scrollNotification.metrics.maxScrollExtent;
        cWidth = screenWidth * progress;
        setState(() {});
        return false;
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: screenWidth,
            alignment: Alignment.centerLeft,
            child: Container(
              height: 20,
              width: cWidth,
              color: Colors.grey,
              alignment: Alignment.centerLeft,
              child: Text('${(cWidth / screenWidth * 100).toStringAsFixed(2)}%'),
            ),
          ),
          Container(
            color: Colors.white,
            padding: EdgeInsets.all(10),
            child: Container(
              height: MediaQuery.of(context).size.height*0.725,
              child:    ListView.builder(
              itemCount: model.tipsList.length,
              itemBuilder: (context, index) {
                return TipsItem(tips: model.tipsList[index]);
              },
            ),
            ),
          ),
        ],
      ),
    )
        : LoadingScreen(text: model.text,),
    )
    );
  }
}