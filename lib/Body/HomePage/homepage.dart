import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:srm_final/widget/model_hive/home_view_model.dart';
import 'package:srm_final/widget/produk_bar_slide/slide_produk.dart';
import 'package:srm_final/widget/produkpopuler/produk_populer.dart';
import 'package:stacked/stacked.dart';
import 'fungsi/dashboardchat.dart';
import 'theme/daftarproduk.dart';
import 'theme/showmenubar.dart';
import 'theme/theme.dart';

class HomePage extends StatefulWidget {

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
          color: LightColors.warnaSubhead,
          fontSize: 20.0,
          fontWeight: FontWeight.w700,
          letterSpacing: 1.2),
    );
  }

  @override
  Widget build(BuildContext context) {

    return ViewModelBuilder<HomeViewModel>.reactive(
    viewModelBuilder: () => HomeViewModel(),
    onModelReady: (model) => model.getData(),
    builder: (context, model, child) => Scaffold(
      key: _scaffoldState,
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => DashboardChat()),);},
        child: Icon(Icons.chat,),
        backgroundColor: LightColors.warnaHead,
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
            body: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  titleAndNotifBar(),
                  ProdukTitleBar(),
                  topBar(model.produkList),
                  kainKami(),
                  terlaris(model.produkList),
                  produkReady(),
                  produkKami(model.produkList),
                  tipsNews(),
                ],
              ),
            ),
          ),
        ),
      ),
    )
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
    backgroundColor: LightColors.warnaHead,
    expandedHeight: heightCustom*0.4,
    floating: true,
    pinned: false,
    flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text('Pusat Grosir Sprei & Gordyn Berkualitas',
          style: TextStyle(
              fontSize: spesialsize*0.02
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
                    color: LightColors.warnaJudul
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(Icons.notifications,
                  size: spesialsize*0.06,
                  color: LightColors.warnaJudul,
                ),
                SizedBox(width: spesialsize*0.05),
                GestureDetector(
                  onTap: () => ShowMenuBar(context),
                  child: Icon(Icons.menu,
                    size: spesialsize*0.06,
                    color: LightColors.warnaJudul,
                  ),
                ),
              ],
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
    padding: EdgeInsets.symmetric(
        horizontal: 20.0),
    child: Column(
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text('Kain Kami',
              style: TextStyle(
                color: LightColors.warnaSubJudul,
                fontSize: spesialsize*0.05,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.left,
            ),
            Text('Lihat semua',
              style: TextStyle(
                  color: Colors.blue
              ),
              textAlign: TextAlign.right,)
          ],
        ),
        Container(
          height: heightCustom*0.001,
          width: widthCustom,
          color: LightColors.warnaSubJudul,
        ),
        SizedBox(height: spesialsize*0.015),
        Container(
          height: MediaQuery.of(context).size.width*0.2,
          child: Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: LightColors.warnaBorderDalam.withOpacity(0.8),
                        offset: Offset(-6.0, -6.0),
                        blurRadius: 16.0,
                      ),
                      BoxShadow(
                        color: LightColors.warnaShadow,
                        offset: Offset(6.0, 6.0),
                        blurRadius: 16.0,
                      ),
                    ],
                    color: LightColors.warnaButton,
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  margin: EdgeInsets.fromLTRB(spesialsize*0.0025, 0, spesialsize*0.0025, 0),
                  child: InkWell(
                    onTap: () {
                      //                                 Navigator.push(context,
                      //                                     MaterialPageRoute( builder: (context) => MapGlobal()
                      //                                     ));
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text("SR",
                              style: TextStyle(
                                  fontSize: spesialsize*0.03,
                                  fontFamily: 'Diploma'
                              ),
                            )
                          ],
                        ),
                        Text(
                          'Katun Jepang',
                          style: new TextStyle(color: Colors.black.withOpacity(0.9),
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic,
                              fontSize: widthCustom*0.02),
                        ),
                      ],
                    ),
                  ),
                ),),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: LightColors.warnaBorderDalam.withOpacity(0.8),
                        offset: Offset(-6.0, -6.0),
                        blurRadius: 16.0,
                      ),
                      BoxShadow(
                        color: LightColors.warnaShadow,
                        offset: Offset(6.0, 6.0),
                        blurRadius: 16.0,
                      ),
                    ],
                    color: LightColors.warnaButton,
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  margin: EdgeInsets.fromLTRB(spesialsize*0.0025, 0, spesialsize*0.0025, 0),
                  child: InkWell(
                    onTap: () {
                      //                                 Navigator.push(context,
                      //                                     MaterialPageRoute( builder: (context) => MapGlobal()
                      //                                     ));
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text("CVC",
                              style: TextStyle(
                                  fontSize: spesialsize*0.03,
                                  fontFamily: 'Diploma'
                              ),
                            )
                          ],
                        ),
                        Text(
                          'Katun CVC',
                          style: new TextStyle(color: Colors.black.withOpacity(0.9),
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic,
                              fontSize: widthCustom*0.02),
                        ),
                      ],
                    ),
                  ),
                ),),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: LightColors.warnaBorderDalam.withOpacity(0.8),
                        offset: Offset(-6.0, -6.0),
                        blurRadius: 16.0,
                      ),
                      BoxShadow(
                        color: LightColors.warnaShadow,
                        offset: Offset(6.0, 6.0),
                        blurRadius: 16.0,
                      ),
                    ],
                    color: LightColors.warnaButton,
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  margin: EdgeInsets.fromLTRB(spesialsize*0.0025, 0, spesialsize*0.0025, 0),
                  child: InkWell(
                    onTap: () {
                      //                                 Navigator.push(context,
                      //                                     MaterialPageRoute( builder: (context) => MapGlobal()
                      //                                     ));
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text("SS",
                              style: TextStyle(
                                  fontSize: spesialsize*0.03,
                                  fontFamily: 'Diploma'
                              ),
                            )
                          ],
                        ),
                        Text(
                          'Sutra Silk',
                          style: new TextStyle(color: Colors.black.withOpacity(0.9),
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic,
                              fontSize: widthCustom*0.02),
                        ),
                      ],
                    ),
                  ),
                ),),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: LightColors.warnaBorderDalam.withOpacity(0.8),
                        offset: Offset(-6.0, -6.0),
                        blurRadius: 16.0,),
                      BoxShadow(
                        color: LightColors.warnaShadow,
                        offset: Offset(6.0, 6.0),
                        blurRadius: 16.0,
                      ),
                    ],
                    color: LightColors.warnaButton,
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  margin: EdgeInsets.fromLTRB(spesialsize*0.0025, 0, spesialsize*0.0025, 0),
                  child: InkWell(
                    onTap: () {
                      //                                 Navigator.push(context,
                      //                                     MaterialPageRoute( builder: (context) => MapGlobal()
                      //                                     ));
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text("TC",
                              style: TextStyle(
                                  fontSize: spesialsize*0.03,
                                  fontFamily: 'Diploma'
                              ),
                            )
                          ],
                        ),
                        Text(
                          'Sutra Organic',
                          style: new TextStyle(color: Colors.black.withOpacity(0.9),
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic,
                              fontSize: widthCustom*0.02),
                        ),
                      ],
                    ),
                  ),
                ),),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: LightColors.warnaBorderDalam.withOpacity(0.8),
                        offset: Offset(-6.0, -6.0),
                        blurRadius: 16.0,
                      ),
                      BoxShadow(
                        color: LightColors.warnaShadow,
                        offset: Offset(6.0, 6.0),
                        blurRadius: 16.0,
                      ),
                    ],
                    color: LightColors.warnaButton,
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  margin: EdgeInsets.fromLTRB(spesialsize*0.0025, 0, spesialsize*0.0025, 0),
                  child: InkWell(
                    onTap: () {
                      //                                 Navigator.push(context,
                      //                                     MaterialPageRoute( builder: (context) => MapGlobal()
                      //                                     ));
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text("KKS",
                              style: TextStyle(
                                  fontSize: spesialsize*0.03,
                                  fontFamily: 'Diploma'
                              ),
                            )
                          ],
                        ),
                        Text(
                          'Serat Bambu',
                          style: new TextStyle(color: Colors.black.withOpacity(0.9),
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic,
                              fontSize: widthCustom*0.02),
                        ),
                      ],
                    ),
                  ),
                ),),
            ],
          ),
        )
      ],
    ),
  );
}
  Widget produkReady() {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DaftarProduk()),
        );
      },
      child: Padding(
        padding: EdgeInsets.only(top: 16, right: 16, left: 16),
        child: Container(
          decoration: BoxDecoration(
            color: LightColors.warnaButton,
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
                    color: LightColors.warnaButton,
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
    return ProdukKamiPage(produkList);
  }

  Widget produkKami(List<dynamic> produkList) {
    return ProdukKamiPage(produkList);
  }
  Widget topBar(List<dynamic> produkList) {
    return Container(
        height: 340,
        child: SlideProduk(produkList));
  }


  Widget tipsNews() {
    return Container(
      color: Colors.transparent,
      padding: EdgeInsets.symmetric(
          horizontal: 20.0, vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          subheading('Tips & News'),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Text('Bagaimana cara mencuci sprei?',
                  style: TextStyle(
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
              Container(
                child: Text('Bagaimana cara mencuci gordyn?',
                  style: TextStyle(
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
              Container(
                child: Text('Mengapa kain saya luntur?',
                  style: TextStyle(
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
              Container(
                child: Text('Bagaimana cara order?',
                  style: TextStyle(
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
              Container(
                child: Text('Buah apa yang warnya kuning, kalo dibuka dalamnya pisang?',
                  style: TextStyle(
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
              Container(
                child: Text('Nikmat apa yang engkau dustai?',
                  style: TextStyle(
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
              Container(
                child: Text('Kenapa udang di balik batu?',
                  style: TextStyle(
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ],
          ),
          Center(
            child: Text("© Copyright 2020 Mr.TNB - All Rights Reserved"),
          )
        ],
      ),
    );
  }
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
}

class ProdukTitleBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('Populer',
            style: TextStyle(
              color: Colors.red[300],
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.left,
          ),
        ],
      ),
    );
  }
}