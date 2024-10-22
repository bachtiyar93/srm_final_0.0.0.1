import 'dart:convert';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:srm_final/apikey/sumberapi.dart';
import 'package:srm_final/main.dart';
import 'package:srm_final/widget/produk_bar_slide/slide_produk.dart';
import 'package:srm_final/widget/produkpopuler/produk_populer.dart';
import '../Chat/dashboardchat.dart';
import 'theme/daftarproduk.dart';
import 'theme/showmenubar.dart';
import 'package:http/http.dart' as http;
import 'package:adobe_xd/adobe_xd.dart';

class HomePage extends StatefulWidget {
  HomePage(List produkList): this.produkList=produkList ?? [];
  final produkList;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();
  DateTime backButtonPressTime;
  static const snackBarDuration = Duration(seconds: 2);
  final snackBar = SnackBar(
    content: Text('Press back again to leave'),
    duration: snackBarDuration,
  );
  Text subheading(String title) {
    return Text(
      title,
      style: TextStyle(
          color: Colors.black,
          fontSize: 20.0,
          fontWeight: FontWeight.w700,
          letterSpacing: 1.2),
    );
  }
  void cekServer() async{
    final response = await http.post(SumberApi.profile);
    //terima data
    final data = jsonDecode(response.body);
    String produkReady = data["produk_ready"];
    String appNews= data["app_news"];

    var produkReadyOld =await  Hive.openBox('produkReady');
    var appNewsOld = await  Hive.openBox('appNews');

    var _produkReadydataOld = produkReadyOld.get('produkReady');
    var _appNewsdataOld = appNewsOld.get('appNews');

    var _produkReadydataNow = produkReady;
    var _appNewsdataNow = appNews;
    debugPrint('Data baru $_produkReadydataNow, $_appNewsdataNow, data lama $_produkReadydataOld,$_appNewsdataOld');
    if ( _produkReadydataNow == _produkReadydataOld){
      if(_appNewsdataNow == _appNewsdataOld){
        debugPrint('Database up to date');
      }else {
        setState(() {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  actions: [
                    FlatButton(
                        color: Colors.red,
                        onPressed: () async {
                          var appNewsOld = await  Hive.openBox('appNews');
                          appNewsOld.put('appNews', _appNewsdataNow);//download produk
                          Navigator.of(context).pop();
                        },
                        child: Text('Update Now'))
                  ],
                  content: Container(
                    height: 130,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text('Produk'),
                            Text('Up to date')
                          ],
                        ),
                        Row(
                          children: [
                            Text('Umpan Baru tersedia'),
                            FlatButton(
                                onPressed: null,
                                child: Text('Versi:$_appNewsdataNow'))
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              });
        });
      }
    }else {
      if(_appNewsdataNow == _appNewsdataOld){
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  actions: [
                    FlatButton(
                        color: Colors.red,
                        onPressed: () async {
                          var box = Hive.box('ProdukTabel');
                          box.deleteFromDisk();
                          var produkReadyOld = await  Hive.openBox('produkReady');
                          produkReadyOld.put('produkReady', _produkReadydataNow);
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => App()),
                          );
                        },
                        child: Text('Update Now'))
                  ],
                  content: Container(
                    height: 130,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text('Produk Baru tersedia'),
                            FlatButton(onPressed: null,
                                child: Text('Versi:$_produkReadydataNow'))
                          ],
                        ),
                        Row(
                          children: [
                            Text('Umpan'),
                            FlatButton(onPressed: null,
                                child: Text('Up to date'))
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              });
      }else {
        Hive.deleteBoxFromDisk('ProdukTabel');
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  actions: [
                    FlatButton(
                      color: Colors.red,
                        onPressed: () async {
                          var box = Hive.box('ProdukTabel');
                          box.deleteFromDisk();
                          var produkReadyOld = await  Hive.openBox('produkReady');
                          var appNewsOld = await  Hive.openBox('appNews');
                          produkReadyOld.put('produkReady', _produkReadydataNow);
                          appNewsOld.put('appNews', _appNewsdataNow);//download produk
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => App()),
                          );
                        },
                        child: Text('Update Now'))
                  ],
                  content: Container(
                    height: 130,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text('Produk Baru tersedia'),
                            FlatButton(onPressed: null,
                                child: Text('Versi:$_produkReadydataNow'))
                          ],
                        ),
                        Row(
                          children: [
                            Text('Umpan baru tersedia'),
                            FlatButton(onPressed: null,
                                child: Text('Versi:$_appNewsdataNow'))
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              });
      }
    }
  }
  @override
  void initState() {
    super.initState();
    cekServer();
  }
  @override
  Widget build(BuildContext context) {
    debugPrint('on HomePage');
    return Scaffold(
      key: _scaffoldState,
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => DashboardChat()),);},
        child: Icon(Icons.chat,),
        backgroundColor: Colors.grey,
      ),
      body: WillPopScope(
        onWillPop: onWillPop,
        child: DefaultTabController(
          length: 1,
          child: NestedScrollView(
            headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                _appBarWidget(),
              ];
              },
            body: Stack(
              children: [
                Pinned.fromSize(
                  bounds: Rect.fromLTWH(27.0, -109.0, 375.0, 812.0),
                  size: Size(523.0, 837.0),
                  pinLeft: true,
                  pinTop: true,
                  pinBottom: true,
                  fixedWidth: true,
                  child: Container(
                    decoration: BoxDecoration(),
                  ),
                ),
                Pinned.fromSize(
                  bounds: Rect.fromLTWH(144.0, -150.0, 379.0, 383.0),
                  size: Size(523.0, 937.0),
                  pinRight: true,
                  pinTop: true,
                  fixedWidth: true,
                  fixedHeight: true,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.elliptical(9999.0, 9999.0)),
                      gradient: LinearGradient(
                        begin: Alignment(0.0, -1.0),
                        end: Alignment(0.0, 1.0),
                        colors: [
                          const Color(0xffff0707),
                          const Color(0xffec0707),
                          const Color(0xff800404)
                        ],
                        stops: [0.0, 0.222, 1.0],
                      ),
                    ),
                  ),
                ),
                Pinned.fromSize(
                  bounds: Rect.fromLTWH(-50.0, 383.0, 186.0, 189.0),
                  size: Size(523.0, 937.0),
                  pinLeft: true,
                  fixedWidth: true,
                  fixedHeight: true,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.elliptical(9999.0, 9999.0)),
                      gradient: LinearGradient(
                        begin: Alignment(0.0, -1.0),
                        end: Alignment(0.0, 1.0),
                        colors: [
                          const Color(0xffff0707),
                          const Color(0xffea0606),
                          const Color(0xff800404)
                        ],
                        stops: [0.0, 0.167, 1.0],
                      ),
                    ),
                  ),
                ),
                Pinned.fromSize(
                  bounds: Rect.fromLTWH(444.0, 665.0, 274.0, 272.0),
                  size: Size(523.0, 837.0),
                  pinBottom: true,
                  fixedWidth: true,
                  fixedHeight: true,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.elliptical(9999.0, 9999.0)),
                      gradient: LinearGradient(
                        begin: Alignment(0.0, -1.0),
                        end: Alignment(0.0, 1.0),
                        colors: [
                          const Color(0xffff0707),
                          const Color(0xffe80606),
                          const Color(0xff800404)
                        ],
                        stops: [0.0, 0.184, 1.0],
                      ),
                    ),
                  ),
                ),
                Pinned.fromSize(
                  bounds: Rect.fromLTWH(468.0, 460.0, 59.0, 55.0),
                  size: Size(523.0, 937.0),
                  fixedWidth: true,
                  fixedHeight: true,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.elliptical(9999.0, 9999.0)),
                      gradient: LinearGradient(
                        begin: Alignment(0.0, -1.0),
                        end: Alignment(0.0, 1.0),
                        colors: [
                          const Color(0xffff0000),
                          const Color(0xffec0000),
                          const Color(0xffe70000),
                          const Color(0xffde0000),
                          const Color(0xff800000)
                        ],
                        stops: [0.0, 0.151, 0.192, 0.259, 1.0],
                      ),
                    ),
                  ),
                ),
                Container(
                  color: Colors.white.withOpacity(0.9),
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        titleAndNotifBar(),
                        kainKami(),
                        ProdukTitleBar(),
                        topBar(widget.produkList),
                        terlaris(widget.produkList),
                        produkReady(widget.produkList),
                        produkKami(widget.produkList),
                        //tipsNews(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget  _appBarWidget() {
  //Ukuran
  var spesialsize, heightCustom;
  heightCustom = MediaQuery.of(context).size.height;
  //specialSize
  if (MediaQuery.of(context).size.height>MediaQuery.of(context).size.width){
    spesialsize=MediaQuery.of(context).size.width;
  }else{
    spesialsize=MediaQuery.of(context).size.height;
  }
  return  SliverAppBar(
    backgroundColor: Colors.grey[300],
    expandedHeight: heightCustom*0.4,
    floating: true,
    pinned: false,
    flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text('Pusat Grosir Sprei & Gordyn Berkualitas',
          style: TextStyle(
              fontSize: spesialsize*0.03
          ),
        ),
        background: Container(
          margin: EdgeInsets.symmetric(
              horizontal: 40,
              vertical: 40
          ),
          width: spesialsize*0.03,
          child: Image.asset("assets/ic_logo.png",
            width: 0.1,
            height: 0.1,
          ),
        )
    ),
  );
}
  Widget  titleAndNotifBar() {
    //Ukuran
    var spesialsize;
    //specialSize
    if (MediaQuery.of(context).size.height>MediaQuery.of(context).size.width){
      spesialsize=MediaQuery.of(context).size.width;
    }else{
      spesialsize=MediaQuery.of(context).size.height;
    }
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: 20.0, vertical: 10.0),
      height: spesialsize*0.2,
      child: Row(
          children: <Widget>[
            Expanded(
              child: Text('Sweet Room Medan',
                textAlign: TextAlign.start,
                style: GoogleFonts.alexBrush(
                    fontSize: spesialsize*0.07,
                    color: Colors.red[900]
                ),
              ),
            ),
            InkWell(
              onTap: () => ShowMenuBar(context),
              child: Container(
                width: 40,
                child: Stack(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(Icons.notification_important,
                          size: spesialsize*0.09,
                          color: Colors.red[900],
                        ),
                      ],
                    ),
                    Positioned(
                      top: -0,
                      left: 20,
                      child: Container(
                        width: 20,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: Colors.blue[900],
                            borderRadius: BorderRadius.circular(20)
                        ),
                        child: Text('3',
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: spesialsize*0.06),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ]
      ),
    );
  }
  Widget kainKami() {
  var spesialsize, heightCustom, widthCustom;
  heightCustom = MediaQuery.of(context).size.height;
  widthCustom = MediaQuery.of(context).size.width;
  //specialSize
  if (MediaQuery.of(context).size.height>MediaQuery.of(context).size.width){
    spesialsize=MediaQuery.of(context).size.width;
  }else{
    spesialsize=MediaQuery.of(context).size.height;
  }
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 5.0),
    child: Column(
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text('Akses Cepat',
              style: TextStyle(
                color: Colors.red[300],
                fontSize: spesialsize*0.06,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.left,
            ),
          ],
        ),
        Container(
          height: heightCustom*0.001,
          width: widthCustom,
          color: Colors.grey,
        ),
        SizedBox(height: spesialsize*0.015),
        Container(
          margin: EdgeInsets.only(top: 15),
          height: MediaQuery.of(context).size.width*0.2,
          child: Row(
            children: [
              _buttonMenu('assets/ic_roll.png','Kain',DaftarProduk(widget.produkList.where((i) => i.produk=='Katun Jepang').toList())),
              _buttonMenu('assets/ic_bed.png','Sprei',DaftarProduk(widget.produkList.where((i) => i.produk=='Sprei').toList())),
              _buttonMenu('assets/ic_curtains.png','Tirai',DaftarProduk(widget.produkList.where((i) => i.produk=='Curtains').toList())),
              _buttonMenu('assets/ic_send.png','Wallpaper',DaftarProduk(widget.produkList.where((i) => i.produk=='Wallpaper').toList())),
              _buttonMenu('assets/ic_rod.png','Aksesoris',DaftarProduk(widget.produkList.where((i) => i.produk=='Aksesoris').toList())),
            ],
          )
        )
      ],
    ),
  );
}
  Widget produkReady(List<dynamic> produkList) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DaftarProduk(produkList)),
        );
      },
      child: Padding(
        padding: EdgeInsets.only(top: 16, right: 16, left: 16),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
          ),
          padding: EdgeInsets.all(24),
          height: 100,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  Text(
                    "Produk Ready",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  Text(
                    "Khusus Produk Ready",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),

                ],
              ),

              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(15),
                  ),
                ),
                height: 50,
                width: 50,
                child: Center(
                  child: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.red,
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
  Widget terlaris(List<dynamic> produkList) {
    return ProdukPopulerPage(produkList);
  }

  Widget produkKami(List<dynamic> produkList) {
    return ProdukPopulerPage(produkList);
  }
  Widget topBar(List<dynamic> produkList) {
    return Container(
        height: 300,
        child: SlideProduk(produkList));
  }

  double cWidth = 0.0;
  // Widget tipsNews() {
  //   double screenWidth;
  //   screenWidth = MediaQuery.of(context).size.width - 40;
  //   return ViewModelBuilder<TipsView>.reactive(
  //       viewModelBuilder: () => TipsView(),
  //       onModelReady: (model) => model.getData(),
  //       builder: (context, model, child) => Container(
  //         child:  model.tipsList.length != 0
  //             ? NotificationListener(onNotification: (ScrollNotification scrollNotification) {
  //               double progress = scrollNotification.metrics.pixels / scrollNotification.metrics.maxScrollExtent;
  //             cWidth = screenWidth * progress;
  //             setState(() {});
  //             return false;
  //           },
  //           child: Column(
  //             children: [
  //               Center(child: Text('Tips & News'),),
  //               Container(
  //                 height: MediaQuery.of(context).size.height*0.725,
  //                 child:    ListView.builder(
  //                   itemCount: model.tipsList.length,
  //                   itemBuilder: (context, index) {
  //                     return TipsItem(tips: model.tipsList[index]);
  //                   },
  //                 ),
  //               ),
  //             ],
  //           ),
  //         )
  //             : LoadingScreen(text: model.text,),
  //       )
  //   );
  // }
  //method close snackbar
  Future<bool> onWillPop() async {
    DateTime currentTime = DateTime.now();
    bool backButtonHasNotBeenPressedOrSnackBarHasBeenClosed =
        backButtonPressTime == null ||
            currentTime.difference(backButtonPressTime) > snackBarDuration;

    if (backButtonHasNotBeenPressedOrSnackBarHasBeenClosed) {
      backButtonPressTime = currentTime;
      _scaffoldState.currentState.showSnackBar(snackBar);
      return false;
    }

    return true;
  }

 Widget  _buttonMenu(String s, String t, tujuan) {
   var spesialsize, widthCustom;
   widthCustom = MediaQuery.of(context).size.width;
   //specialSize
   if (MediaQuery.of(context).size.height>MediaQuery.of(context).size.width){
     spesialsize=MediaQuery.of(context).size.width;
   }else{
     spesialsize=MediaQuery.of(context).size.height;
   }
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.white.withOpacity(0.8),
              offset: Offset(-6.0, -6.0),
              blurRadius: 16.0,
            ),
            BoxShadow(
              color: Colors.grey,
              offset: Offset(6.0, 6.0),
              blurRadius: 16.0,
            ),
          ],
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.0),
        ),
        margin: EdgeInsets.fromLTRB(spesialsize*0.0025, 0, spesialsize*0.0025, 0),
        child: InkWell(
          onTap: () {
                                            Navigator.push(context,
                                                MaterialPageRoute( builder: (context) => tujuan
                                                ));
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(s,
              height: 25,
                width: 25,
              ),
              Text(
                t,
                style: new TextStyle(color: Colors.black.withOpacity(0.9),
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                    fontSize: widthCustom*0.05),
              ),
            ],
          ),
        ),
      ),
    );
 }
}


class ProdukTitleBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 10, top: 5,),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('Populer',
            style: TextStyle(
              color: Colors.red[300],
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.left,
          ),
        ],
      ),
    );
  }
}