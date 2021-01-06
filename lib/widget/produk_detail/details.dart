import 'dart:convert';

import 'package:adobe_xd/pinned.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_picker/Picker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import 'package:srm_final/apikey/sumberapi.dart';
import 'package:srm_final/widget/model_hive/anime.dart';
import 'package:srm_final/widget/model_hive/cart.dart';
import 'package:srm_final/widget/model_hive/hive_service.dart';
import 'package:srm_final/widget/model_hive/locator.dart';
import 'package:validators/validators.dart';
import 'PickerSprei.dart';
import 'details_row_widget.dart';
import 'package:http/http.dart' as http;
import 'package:hive/hive.dart';



class ProdukDetails extends StatefulWidget {
  final Produk produkList;
  final index;
  const ProdukDetails({Key key, this.produkList, this.index}) : super(key: key);


  @override
  _ProdukDetailsState createState() => _ProdukDetailsState();
}

class _ProdukDetailsState extends State<ProdukDetails> with TickerProviderStateMixin {
  final _keyConfirm = new GlobalKey<FormState>();
  AnimationController _animationController;
  double _containerPaddingLeft = 20.0;
  double _animationValue;
  double _translateX = 0;
  double _translateY = 0;
  double _rotate = 0;
  double _scale = 1;
  var tapAllow = 0;
  bool show;
  bool sent = false;
  Color _color = Colors.red,
      onPressColor1 = Colors.white,
      onPressColor2 = Colors.white,
      onPressColor3 = Colors.white;
  final HiveService hiveService = locator<HiveService>();
  List<dynamic> _cartList = [];

  List<dynamic> get cartList => _cartList;

  int _currentImage = 0;
  double _jumlahPesanan = 0;
  double _setHarga = 0;

  var U = new NumberFormat("'Rp. '###,###.00#", "id_ID"),
      _size="None",
      _namaProduk='Produk name',
      _ket,
      _status = 0;

  List<Widget> buildPageIndicator() {
    List<Widget> list = [];
    for (var i = 0; i < widget.produkList.images.length; i++) {
      list.add(buildIndicator(i == _currentImage));
    }
    return list;
  }

  Widget buildIndicator(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 100),
      margin: EdgeInsets.symmetric(horizontal: 6),
      height: 8,
      width: isActive ? 20 : 8,
      decoration: BoxDecoration(
        color: isActive ? Colors.black : Colors.grey[400],
        borderRadius: BorderRadius.all(
          Radius.circular(12),
        ),
      ),
    );
  }

  bool whis = false;

  cekWhis() async {
    var box = await Hive.openBox(widget.produkList.seri);
    var cek = box.get('whistlist');
    if (cek == null) {
      box.put('whistlist', 0);
      setState(() {
        whis = false;
      });
    } else if (cek == 0) {
      box.put('whistlist', 0);
      setState(() {
        whis = false;
      });
    } else {
      setState(() {
        whis = true;
      });
    }
  }

  void dilihatMethod() async {
    await http.post(
        SumberApi.dilihat, body: {"id": widget.produkList.id.toString()});
  }

  void kontrolAnimasi() {
    _animationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1300));
    show = true;
    _animationController.addListener(() {
      setState(() {
        show = false;
        _animationValue = _animationController.value;
        if (_animationValue >= 0.2 && _animationValue < 0.4) {
          _containerPaddingLeft = 100.0;
          _color = Colors.grey[300];
        } else if (_animationValue >= 0.4 && _animationValue <= 0.5) {
          _translateX = 80.0;
          _rotate = -20.0;
          _scale = 0.1;
        } else if (_animationValue >= 0.5 && _animationValue <= 0.8) {
          _translateY = -20.0;
        } else if (_animationValue >= 0.81) {
          _containerPaddingLeft = 20.0;
          sent = true;
        }
      });
    });
  }

  @override
  void initState() {
    cekWhis();
    dilihatMethod();
    super.initState();
    kontrolAnimasi();
  }

  @override
  Widget build(BuildContext context) {
    var spesialsize;
    //specialSize
    if (MediaQuery
        .of(context)
        .size
        .height > MediaQuery
        .of(context)
        .size
        .width) {
      spesialsize = MediaQuery
          .of(context)
          .size
          .width;
    } else {
      spesialsize = MediaQuery
          .of(context)
          .size
          .height;
    }
    return Scaffold(
        body: Stack(
            children: <Widget>[
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
                    borderRadius: BorderRadius.all(
                        Radius.elliptical(9999.0, 9999.0)),
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
                    borderRadius: BorderRadius.all(
                        Radius.elliptical(9999.0, 9999.0)),
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
                    borderRadius: BorderRadius.all(
                        Radius.elliptical(9999.0, 9999.0)),
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
                    borderRadius: BorderRadius.all(
                        Radius.elliptical(9999.0, 9999.0)),
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
              NestedScrollView(
                headerSliverBuilder: (BuildContext context,
                    bool innerBoxIsScrolled) {
                  return <Widget>[
                    SliverAppBar(
                      backgroundColor: Colors.transparent,
                      pinned: false,
                      floating: true,
                      expandedHeight: MediaQuery
                          .of(context)
                          .size
                          .height * 0.55,
                      flexibleSpace: FlexibleSpaceBar(
                        centerTitle: true,
                        title: widget.produkList.images.length > 1
                            ? Container(
                          margin: EdgeInsets.symmetric(vertical: 0.01),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: buildPageIndicator(),
                          ),
                        )
                            : Container(),
                        background: Container(
                          child: PageView(
                            physics: BouncingScrollPhysics(),
                            onPageChanged: (int page) {
                              setState(() {
                                _currentImage = page;
                              });
                            },
                            children: widget.produkList.images.map((
                                String path) {
                              return Container(
                                child: _bangunGambarDetail(path),
                                height: MediaQuery
                                    .of(context)
                                    .size
                                    .height * 0.5,
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ),
                  ];
                },
                body: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20)),
                      gradient: LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          colors: [
                            Color.fromRGBO(40, 10, 10, 0.95),
                            Colors.red[900].withOpacity(0.95),
                            Colors.redAccent.withOpacity(0.95)
                          ])
                  ),
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        alignment: Alignment.topCenter,
                        child: Container(
                          height: 3,
                          width: 30,
                          color: Colors.black,
                        ),
                      ),
                      Center(child: Text(
                        'Sweet Room Medan', style: GoogleFonts.alexBrush(
                          fontSize: 35,
                          color: Color.fromRGBO(225, 80, 80, 1)
                      ),),),
                      Row(
                        children: <Widget>[
                          Image.network(widget.produkList.images[0],
                            height: 80,
                            width: 80,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment
                                  .start,
                              children: <Widget>[
                                Text(
                                  widget.produkList.produk,
                                  maxLines: 1,
                                  overflow: TextOverflow.fade,
                                  softWrap: false,
                                  style: GoogleFonts.lobster(
                                      fontSize: 25,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white),
                                ),
                                Text(
                                  widget.produkList.seri,
                                  style: GoogleFonts.lato(
                                      fontSize: 18,
                                      color: Colors.white.withOpacity(
                                          0.6)),
                                )
                              ],
                            ),
                          ),
                          Expanded(
                            child: Row(
                              children: [
                                InkWell(
                                  onTap: () async {
                                    if (whis == false) {
                                      var box = await Hive.openBox(
                                          widget.produkList.seri);
                                      box.put('whistlist', 1);
                                      Hive.box('ProdukTabel').putAt(
                                          widget.index, Produk(
                                        id: widget.produkList.id,
                                        produk: widget.produkList.produk,
                                        seri: widget.produkList.seri,
                                        harga: widget.produkList.harga,
                                        stok: widget.produkList.stok,
                                        tglMasuk: widget.produkList
                                            .tglMasuk,
                                        kondisi: widget.produkList
                                            .kondisi,
                                        bidang: widget.produkList.bidang,
                                        rate: widget.produkList.rate,
                                        pembeli: widget.produkList
                                            .pembeli,
                                        dilihat: widget.produkList
                                            .dilihat,
                                        whistlist: 1,
                                        images: widget.produkList.images,
                                      ));
                                      setState(() {
                                        whis = true;
                                      });
                                    } else {
                                      var box = await Hive.openBox(
                                          widget.produkList.seri);
                                      box.put('whistlist', 0);
                                      Hive.box('ProdukTabel').putAt(
                                          widget.index, Produk(
                                        id: widget.produkList.id,
                                        produk: widget.produkList.produk,
                                        seri: widget.produkList.seri,
                                        harga: widget.produkList.harga,
                                        stok: widget.produkList.stok,
                                        tglMasuk: widget.produkList
                                            .tglMasuk,
                                        kondisi: widget.produkList
                                            .kondisi,
                                        bidang: widget.produkList.bidang,
                                        rate: widget.produkList.rate,
                                        pembeli: widget.produkList
                                            .pembeli,
                                        dilihat: widget.produkList
                                            .dilihat,
                                        whistlist: 0,
                                        images: widget.produkList.images,
                                      ));
                                      setState(() {
                                        whis = false;
                                      });
                                    }
                                  },
                                  child: Container(
                                      width: spesialsize * 0.12,
                                      height: spesialsize * 0.12,
                                      decoration: BoxDecoration(
                                        color: whis == true ? Colors
                                            .red[600] : Colors
                                            .transparent,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(15),
                                        ),
                                        border: Border.all(
                                          color: whis == true ? Colors
                                              .transparent : Colors.white,
                                          width: 1,
                                        ),
                                      ),
                                      child: Icon(
                                        Icons.bookmark_border,
                                        color: whis == true
                                            ? Colors.white
                                            : Colors.grey,
                                        size: spesialsize * 0.07,
                                      )
                                  ),
                                ),

                                SizedBox(
                                  width: 5,
                                ),

                                Container(
                                    width: spesialsize * 0.12,
                                    height: spesialsize * 0.12,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(15),
                                      ),
                                      border: Border.all(
                                        color: Colors.white,
                                        width: 1,
                                      ),
                                    ),
                                    child: Icon(
                                      Icons.share,
                                      color: Colors.grey,
                                      size: spesialsize * 0.07,
                                    )
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text("Details:",
                          style: GoogleFonts.quicksand(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20)),
                      DetailsRow(
                          heading: "Jenis Kain",
                          details: widget.produkList.produk),
                      DetailsRow(heading: "Seri/Motif",
                          details: widget.produkList.seri),
                      DetailsRow(heading: "Bidang Kain (cm)",
                          details: widget.produkList.bidang.toString()),
                      DetailsRow(
                          heading: "Stok (m)",
                          details: widget.produkList.stok.toString()),
                      DetailsRow(
                          heading: "Rate (1-5)",
                          details: widget.produkList.rate.toString()),
                      DetailsRow(
                          heading: "Harga/m",
                          details: U
                              .format(widget.produkList.harga)
                              .toString()),
                      DetailsRow(
                          heading: "Pembeli",
                          details: widget.produkList.pembeli.toString()),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                child: _bangunBeli(widget: widget, context: context),
              )
            ]
        )
    );
  }

  _bangunGambarDetail(String path) {
    if (isURL(path)) {
      return Hero(
        tag: widget.produkList.seri,
        child: GestureDetector(
          onTap: () => showSimpleDialog(context, path),
          child: CachedNetworkImage(
            imageUrl: path,
            placeholder: (context, url) =>
                Container(
                  alignment: Alignment.topCenter,
                  child: Shimmer.fromColors(
                      child: Image.asset('assets/ic_logo.png',
                        fit: BoxFit.scaleDown,
                      ), baseColor: Colors.grey, highlightColor: Colors.white),
                ),
            fit: BoxFit.scaleDown,
          ),
        ),
      );
    } else {
      return Hero(
        tag: widget.produkList.seri,
        child: Image.asset(
          'assets/ic_logo.png',
          fit: BoxFit.scaleDown,
        ),
      );
    }
  }

  void showSimpleDialog(BuildContext context, String path) {
    showDialog<Null>(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          contentPadding: EdgeInsets.all(2),
          children: <Widget>[
            CachedNetworkImage(imageUrl: path,),
          ],
        );
      },
    );
  }

  Widget _bangunBeli({ProdukDetails widget, BuildContext context}) {
    return Container(
      height: 80,
      width: MediaQuery
          .of(context)
          .size
          .width,
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        color: Colors.red[900],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                Text(
                  _namaProduk=="Produk name"?"Belanja Anda":_namaProduk,
                  style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                Row(
                  children: [
                    Text(
                _setHarga==0.001?'Harga Nego':U.format(_setHarga * _jumlahPesanan).toString(),
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: InkWell(
                onTap: () {
                  if (tapAllow == 1) {
                    _animationController.forward();
                    Cart cart = Cart(
                        id: widget.produkList.id,
                        produk: _namaProduk,
                        seri: widget.produkList.seri,
                        harga: _setHarga,
                        qty: _jumlahPesanan,
                        tglTransaksi: widget.produkList.tglMasuk,
                        size: _size,
                        ket: _ket == null ? 'Tidak ada catatan' : _ket,
                        //status 0 = ready atau jumlah hari
                        status: _status,
                        images: widget.produkList.images);
                    _cartList.add(cart);
                    debugPrint('add to Cart');
                    hiveService.addBoxesTypeList(_cartList, "CartTabel");
                    setState(() {
                      tapAllow = 2;
                    });
                  } else if(tapAllow==0){
                    showOptions(context);
                  }else{
                    Navigator.pop(context);
                  }
                },
                child: Center(
                  child: AnimatedContainer(
                      decoration: BoxDecoration(
                        color: _color,
                        borderRadius: BorderRadius.circular(100.0),
                        boxShadow: [
                          BoxShadow(
                            color: _color,
                            blurRadius: 21,
                            spreadRadius: -15,
                            offset: Offset(
                              0.0,
                              20.0,
                            ),
                          )
                        ],
                      ),
                      padding: EdgeInsets.only(
                          left: _containerPaddingLeft,
                          right: 20.0,
                          top: 10.0,
                          bottom: 10.0),
                      duration: Duration(milliseconds: 400),
                      curve: Curves.easeOutCubic,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          (!sent)
                              ? AnimatedContainer(
                            duration: Duration(milliseconds: 400),
                            child: Icon(Icons.shopping_cart),
                            curve: Curves.fastOutSlowIn,
                            transform: Matrix4.translationValues(
                                _translateX, _translateY, 0)
                              ..rotateZ(_rotate)
                              ..scale(_scale),
                          )
                              : Container(),
                          AnimatedSize(
                            vsync: this,
                            duration: Duration(milliseconds: 600),
                            child: show ? SizedBox(width: 10.0) : Container(),
                          ),
                          AnimatedSize(
                            vsync: this,
                            duration: Duration(milliseconds: 200),
                            child: show ? Text("Pilihan Produk") : Container(),
                          ),
                          AnimatedSize(
                            vsync: this,
                            duration: Duration(milliseconds: 200),
                            child: sent ? Icon(Icons.done) : Container(),
                          ),
                          AnimatedSize(
                            vsync: this,
                            alignment: Alignment.topLeft,
                            duration: Duration(milliseconds: 600),
                            child: sent ? SizedBox(width: 10.0) : Container(),
                          ),
                          AnimatedSize(
                            vsync: this,
                            duration: Duration(milliseconds: 200),
                            child: sent ? Text("Selesai") : Container(),
                          ),
                        ],
                      )),
                )
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSpec(String title, String data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 1,
        ),
        Text(
          data,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.grey,
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  void save() async {
    final form = _keyConfirm.currentState;
    if (form.validate()) {
      form.save();
    }
  }


  void showPilihSprei(BuildContext context) {
    Picker(
        adapter: PickerDataAdapter<String>(
            pickerdata: new JsonDecoder().convert(PickerSpreiKatunJepang)),
        hideHeader: true,
        textScaleFactor: 0.6,
        selectedTextStyle: TextStyle(fontWeight: FontWeight.bold),
        title: Column(
          children: [
            new Text("Pilih ukuran & model"),
            SizedBox(height: 15,),
            Row(
              children: [
                Expanded(child: Text("Model", textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14),)),
                Expanded(child: Text("Luas", textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14))),
                Expanded(child: Text("Tinggi", textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14))),
                Expanded(child: Text("Qty", textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14))),
              ],
            )
          ],
        ),
        onConfirm: (Picker picker, List hasil) {
          if (picker.getSelectedValues()[0]=="Karet"){
            double tinggi = picker.getSelectedValues()[2]=="Custom"?0:double.parse(picker.getSelectedValues()[2]);
            double untung = 0.30;
            double lebar = picker.getSelectedValues()[1]=="100x200"? 100 :(picker.getSelectedValues()[1]=="120x200"?120:(picker.getSelectedValues()[1]=="160x200"?160:(picker.getSelectedValues()[1]=="180x200"?180:(picker.getSelectedValues()[1]=="200x200"?200:0))));
            double bidang = double.parse(widget.produkList.bidang.toString());
            double bantal_guling = picker.getSelectedValues()[1]=="100x200" || picker.getSelectedValues()[1]=="120x200"? 90:190;
            double upah_jahit = picker.getSelectedValues()[1]=="100x200" || picker.getSelectedValues()[1]=="120x200"? 22500:25000;
            double harga_kain = widget.produkList.harga/100;
            double jahitan = 10;
            double panjang = 200;
            double tas = 6000;
            double pemakaian_kain = (tinggi*2)+jahitan+lebar+((tinggi*2)+jahitan+panjang-bidang)+bantal_guling;
            double harga =pemakaian_kain*harga_kain+upah_jahit+((pemakaian_kain*harga_kain+upah_jahit)*untung)+tas;
            if (lebar==0) {
              setState(() {
                _namaProduk="Set Sprei Karet";
                _setHarga=0.001;
                _jumlahPesanan=double.parse(picker.getSelectedValues()[3]);
                _size="Custom";
                tapAllow = 1;
              });
            }  else {
              setState(() {
                _namaProduk="Set Sprei Karet";
                _setHarga=harga;
                _jumlahPesanan=double.parse(picker.getSelectedValues()[3]);
                _size=picker.getSelectedValues()[1]+'x'+picker.getSelectedValues()[2];
                tapAllow = 1;
              });
            }
          }else if(picker.getSelectedValues()[0]=="Rimpel"){
            double tinggi = picker.getSelectedValues()[2]=="Custom"?0:double.parse(picker.getSelectedValues()[2]);
            double untung = 0.30;
            double lebar = picker.getSelectedValues()[1]=="100x200"? 100 :(picker.getSelectedValues()[1]=="120x200"?120:(picker.getSelectedValues()[1]=="160x200"?160:(picker.getSelectedValues()[1]=="180x200"?180:(picker.getSelectedValues()[1]=="200x200"?200:0))));
            double bidang = double.parse(widget.produkList.bidang.toString());
            double bantal_guling = picker.getSelectedValues()[1]=="100x200" || picker.getSelectedValues()[1]=="120x200"? 90:190;
            double upah_jahit = picker.getSelectedValues()[1]=="100x200" || picker.getSelectedValues()[1]=="120x200"? 22500:25000;
            double harga_kain = widget.produkList.harga/100;
            double jahitan = 10;
            double panjang = 200;
            double tas = 6000;
            double jalur=picker.getSelectedValues()[1]=="100x200" || picker.getSelectedValues()[1]=="120x200"? 3:4;
            double upah_rimpel=picker.getSelectedValues()[1]=="100x200" || picker.getSelectedValues()[1]=="120x200"? 10000:15000;
            double rimpel=(jalur*60)*harga_kain+upah_rimpel;
            double pemakaian_kain = (tinggi*2)+jahitan+lebar+((tinggi*2)+jahitan+panjang-bidang)+bantal_guling;
            double harga =pemakaian_kain*harga_kain+upah_jahit+rimpel+((pemakaian_kain*harga_kain+upah_jahit+rimpel)*untung)+tas;
           if(lebar==0){
             setState(() {
               _namaProduk="Set Sprei Rimpel";
               _setHarga=.001;
               _jumlahPesanan=double.parse(picker.getSelectedValues()[3]);
               _size="Custom";
               tapAllow = 1;
             });
           }else {
             setState(() {
               _namaProduk="Set Sprei Rimpel";
               _setHarga=harga;
               _jumlahPesanan=double.parse(picker.getSelectedValues()[3]);
               _size=picker.getSelectedValues()[1]+'x'+picker.getSelectedValues()[2];
               tapAllow = 1;
             });
           }
          }else {
            double tinggi = picker.getSelectedValues()[2]=="Custom"?0:double.parse(picker.getSelectedValues()[2]);
            double untung = 0.30;
            double lebar = picker.getSelectedValues()[1]=="100x200"? 100 :(picker.getSelectedValues()[1]=="120x200"?120:(picker.getSelectedValues()[1]=="160x200"?160:(picker.getSelectedValues()[1]=="180x200"?180:(picker.getSelectedValues()[1]=="200x200"?200:0.0))));
            double upah_jahit = picker.getSelectedValues()[1]=="100x200" || picker.getSelectedValues()[1]=="120x200"? 22500:25000;
            double harga_kain = widget.produkList.harga/100;
            double jahitan = 10;
            double tas = 6000;
            double risleting = 15000;
            double pemakaian_kain = (tinggi+lebar)*2+jahitan;
            double harga =pemakaian_kain*harga_kain+upah_jahit+((pemakaian_kain*harga_kain+upah_jahit)*untung)+tas+risleting;
            if(lebar==0){
              setState(() {
                _namaProduk="Sarung Kasur";
                _setHarga=0.001;
                _jumlahPesanan=double.parse(picker.getSelectedValues()[3]);
                _size="Custom";
                tapAllow = 1;
              });
            }else {
              setState(() {
                _namaProduk = "Sarung Kasur";
                _setHarga = harga;
                _jumlahPesanan = double.parse(picker.getSelectedValues()[3]);
                _size = picker.getSelectedValues()[1] + 'x' +
                    picker.getSelectedValues()[2];
                tapAllow = 1;
              });
            }
          }
          Navigator.pop(context);
          print(hasil.toString());
          print(picker.getSelectedValues());
        }
    ).showDialog(context, barrierDismissible: false);
  }
  void showPilihBC(BuildContext context) {
    Picker(
        adapter: PickerDataAdapter<String>(
            pickerdata: new JsonDecoder().convert(PickerBcdanQuilt)),
        hideHeader: true,
        textScaleFactor: 0.6,
        selectedTextStyle: TextStyle(fontWeight: FontWeight.bold),
        title: Column(
          children: [
            new Text("Pilih ukuran & model"),
            SizedBox(height: 15,),
            Row(
              children: [
                Expanded(child: Text("Model", textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14),)),
                Expanded(child: Text("Luas", textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14))),
                Expanded(child: Text("Qty", textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14))),
              ],
            )
          ],
        ),
        onConfirm: (Picker picker, List hasil) {
          if (picker.getSelectedValues()[0]=='Bedcover') {
            double kain_dasar = picker.getSelectedValues()[1]=="100x200"?  320:(picker.getSelectedValues()[1]=="120x200"?360:(picker.getSelectedValues()[1]=="160x200"?440:(picker.getSelectedValues()[1]=="180x200"?480:(picker.getSelectedValues()[1]=="200x200"?520:0.0))));
            double dacron = picker.getSelectedValues()[1]=="100x200"?  12000:(picker.getSelectedValues()[1]=="120x200"?130000:(picker.getSelectedValues()[1]=="160x200"?140000:(picker.getSelectedValues()[1]=="180x200"?150000:(picker.getSelectedValues()[1]=="200x200"?160000:0.0))));
            double upah_jahit = picker.getSelectedValues()[1]=="100x200" || picker.getSelectedValues()[1]=="120x200"? 25000:30000;
            double untung = 0.30;
            double harga_kain =widget.produkList.harga/100;
            double harga = kain_dasar*harga_kain+dacron+upah_jahit+((kain_dasar*harga_kain+dacron+upah_jahit)*untung);
            if (picker.getSelectedValues()[1]=='Custom') {
              setState(() {
                _namaProduk = "Bedcover Only";
                _setHarga = 0.001;
                _jumlahPesanan = double.parse(picker.getSelectedValues()[2]);
                _size = picker.getSelectedValues()[1];
                tapAllow = 1;
              });
            }else{
              setState(() {
                _namaProduk = "Bedcover Only";
                _setHarga = harga;
                _jumlahPesanan = double.parse(picker.getSelectedValues()[2]);
                _size = picker.getSelectedValues()[1];
                tapAllow = 1;
              });

            }
          }else if (picker.getSelectedValues()[0]=='Quilt Cover') {
            double kain_dasar = picker.getSelectedValues()[1]=="100x200"?  320:(picker.getSelectedValues()[1]=="120x200"?360:(picker.getSelectedValues()[1]=="160x200"?440:(picker.getSelectedValues()[1]=="180x200"?480:(picker.getSelectedValues()[1]=="200x200"?520:0.0))));
            double upah_jahit = picker.getSelectedValues()[1]=="100x200" || picker.getSelectedValues()[1]=="120x200"? 25000:30000;
            double untung = 0.30;
            double harga_kain =widget.produkList.harga/100;
            double harga = kain_dasar*harga_kain+upah_jahit+((kain_dasar*harga_kain+upah_jahit)*untung);
            if (picker.getSelectedValues()[1]=='Custom') {
              setState(() {
                _namaProduk = "Quilt Cover";
                _setHarga = 0.001;
                _jumlahPesanan = double.parse(picker.getSelectedValues()[2]);
                _size = picker.getSelectedValues()[1];
                tapAllow = 1;
              });
            }else{
              setState(() {
                _namaProduk = "Quilt Cover";
                _setHarga = harga;
                _jumlahPesanan = double.parse(picker.getSelectedValues()[2]);
                _size = picker.getSelectedValues()[1];
                tapAllow = 1;
              });
            }
          }else if (picker.getSelectedValues()[0]=='Sarung Bantal') {
            double kain = picker.getSelectedValues()[1]=='Sofa 40cm'?25
                :(picker.getSelectedValues()[1]=='Sofa 45cm'?27.5
                :(picker.getSelectedValues()[1]=='Standart'?52.5
                :(picker.getSelectedValues()[1]=='Kingkoil'?60
                :(picker.getSelectedValues()[1]=='Kapuk'?50
                :(picker.getSelectedValues()[1]=='Cinta'?60
                :(picker.getSelectedValues()[1]=='Poligami'?130
                :(picker.getSelectedValues()[1]=='Santai'?75
                :0.001)))))));
            double risleting = picker.getSelectedValues()[1]=='Sofa 40cm'?10000
                :(picker.getSelectedValues()[1]=='Sofa 45cm'?10000
                :(picker.getSelectedValues()[1]=='Standart'?10000
                :(picker.getSelectedValues()[1]=='Kingkoil'?0
                :(picker.getSelectedValues()[1]=='Kapuk'?0
                :(picker.getSelectedValues()[1]=='Cinta'?10000
                :(picker.getSelectedValues()[1]=='Poligami'?15000
                :(picker.getSelectedValues()[1]=='Santai'?10000
                :0.001)))))));
            double upah_jahit =10000;
            double harga_kain=widget.produkList.harga/100;
            double untung =0.35;
            double harga =(kain*harga_kain+upah_jahit+risleting)*untung+(kain*harga_kain+upah_jahit+risleting);
            setState(() {
              _namaProduk = "Sarung Bantal";
              _setHarga = harga;
              _jumlahPesanan = double.parse(picker.getSelectedValues()[2]);
              _size = picker.getSelectedValues()[1];
              tapAllow = 1;
            });
          }else{
            double kain = picker.getSelectedValues()[1]=='Standart'?40
                :(picker.getSelectedValues()[1]=='Kingkoil'?55
                :0.001);
            double upah_jahit =10000;
            double harga_kain=widget.produkList.harga/100;
            double untung =0.35;
            double harga =(kain*harga_kain+upah_jahit)*untung+(kain*harga_kain+upah_jahit);
            setState(() {
              _namaProduk = "Sarung Guling";
              _setHarga = harga;
              _jumlahPesanan = double.parse(picker.getSelectedValues()[2]);
              _size = picker.getSelectedValues()[1];
              tapAllow = 1;
            });
          }
          Navigator.pop(context);
          print(hasil.toString());
          print(picker.getSelectedValues());
        }
    ).showDialog(context, barrierDismissible: false);
  }
  void showPilihBaby(BuildContext context) {
    Picker(
        adapter: PickerDataAdapter<String>(
            pickerdata: new JsonDecoder().convert(PickerBabyBumper)),
        hideHeader: true,
        textScaleFactor: 0.6,
        selectedTextStyle: TextStyle(fontWeight: FontWeight.bold),
        title: Column(
          children: [
            new Text("Pilih ukuran & model"),
            SizedBox(height: 15,),
            Row(
              children: [
                Expanded(child: Text("Panjang", textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14),)),
                Expanded(child: Text("Lebar", textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14))),
                Expanded(child: Text("Tinggi", textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14)))
              ],
            )
          ],
        ),
        onConfirm: (Picker picker, List hasil) {
          setState(() {
            _namaProduk = "Baby Bumper";
            _setHarga = 0.001;
            _jumlahPesanan = 1;
            _size = picker.getSelectedValues()[0] + 'x' +
                picker.getSelectedValues()[1]+'x'+picker.getSelectedValues()[2];
            tapAllow = 1;
          });
          Navigator.pop(context);
          print(hasil.toString());
          print(picker.getSelectedValues());
        }
    ).showDialog(context, barrierDismissible: false);
  }
  void showOptions(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
        context: context,
        builder: (BuildContext context) {
          return Container(
            decoration: BoxDecoration(
              color: Colors.grey[400],
                borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))
            ),
            padding: EdgeInsets.only(top: 16, bottom: 16, left: 5,right: 5),
            height: 200,
            child: Column(
              children: [
                Container(
                  padding:EdgeInsets.only(bottom: 16),
                  child: Text('Pilihan Produk',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),),
                Container(
                  height: 100,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      Container(
                        width: 150,
                          child: Material(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(22.0)),
                            elevation: 18.0,
                            color: onPressColor1,
                            clipBehavior: Clip.antiAlias,
                            child: MaterialButton(
                                height: 100,
                                minWidth: MediaQuery
                                    .of(context)
                                    .size
                                    .width,
                                onPressed: () {
                                  showDialog(
                                      barrierDismissible: false,
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text(
                                              "Jumlah Quantity (Meter)"),
                                          content: Container(
                                            height: 100,
                                            child: Column(
                                              children: [
                                                Form(
                                                    key: _keyConfirm,
                                                    child: TextFormField(
                                                        onSaved: (e) =>
                                                        _jumlahPesanan =
                                                            double.parse(e),
                                                        cursorColor: Colors.red,
                                                        decoration: InputDecoration(
                                                            hintText: "Masukan Jumlah / Meter",
                                                            focusColor: Colors
                                                                .black,
                                                            border: InputBorder
                                                                .none,
                                                            fillColor: Color(
                                                                0xfff3f3f4),
                                                            filled: true))
                                                ),
                                                Row(
                                                  children: [
                                                    Icon(Icons.help_outline,
                                                      color: Colors.yellow,),
                                                    Text(
                                                      'Gunakan dot/titik  "." mengganti koma ","!',
                                                      style: TextStyle(
                                                          fontSize: 12),)
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                          actions: [
                                            Material(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius
                                                      .circular(22.0)),
                                              elevation: 18.0,
                                              color: Colors.grey,
                                              clipBehavior: Clip.antiAlias,
                                              child: MaterialButton(
                                                  child: Text('Batal'),
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  }
                                              ),
                                            ),
                                            Material(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius
                                                      .circular(22.0)),
                                              elevation: 18.0,
                                              clipBehavior: Clip.antiAlias,
                                              child: MaterialButton(
                                                child: Text('0k'),
                                                onPressed: () async {
                                                  _jumlahPesanan == null
                                                      ? null
                                                      :
                                                  await save();
                                                  setState(() {
                                                    _setHarga=widget.produkList.harga;
                                                    _jumlahPesanan;
                                                    _namaProduk="Bahan Kain";
                                                    _size="Bidang "+widget.produkList.bidang.toString();
                                                    onPressColor1 = Colors.red[700];
                                                    tapAllow = 1;
                                                  });
                                                  Navigator.pop(context);
                                                  Navigator.pop(context);
                                                },
                                              ),
                                            ),
                                          ],
                                        );
                                      });
                                },
                                child: _buildSpec('Kain Saja', 'Pembelian Bahan')),
                          )),
                      SizedBox(width: 5,),
                      Container(
                          width: 150,
                          child: Material(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(22.0)),
                            elevation: 18.0,
                            color: onPressColor2,
                            clipBehavior: Clip.antiAlias,
                            child: MaterialButton(
                                height: 100,
                                minWidth: MediaQuery
                                    .of(context)
                                    .size
                                    .width,
                                onPressed: () {
                                  showPilihSprei(context);
                                },
                                child: _buildSpec('Sprei', 'Sprei Set & Sarung Kasur')),
                          )),
                      SizedBox(width: 5,),
                      Container(
                          width: 150,
                          child: Material(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(22.0)),
                            elevation: 18.0,
                            color: onPressColor3,
                            clipBehavior: Clip.antiAlias,
                            child: MaterialButton(
                                height: 100,
                                minWidth: MediaQuery
                                    .of(context)
                                    .size
                                    .width,
                                onPressed: () {
                                  showPilihBC(context);
                                },
                                child: _buildSpec('Selimut & Bantal', 'Bedcover, Quilt, Sarung Bantal & Guling')),
                          )),
                      SizedBox(width: 5,),
                      Container(
                          width: 150,
                          child: Material(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(22.0)),
                            elevation: 18.0,
                            color: onPressColor3,
                            clipBehavior: Clip.antiAlias,
                            child: MaterialButton(
                                height: 100,
                                minWidth: MediaQuery
                                    .of(context)
                                    .size
                                    .width,
                                onPressed: () {
                                  showPilihBaby(context);
                                },
                                child: _buildSpec('For Baby', 'Baby Bumper Set, Guling, Bantal, Mattress')),
                          ))
                    ],
                  ),
                ),
              ],
            ),
          );
        }
    );
  }
}