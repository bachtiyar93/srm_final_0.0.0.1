import 'package:adobe_xd/pinned.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import 'package:srm_final/apikey/sumberapi.dart';
import 'package:srm_final/widget/model_hive/anime.dart';
import 'package:srm_final/widget/model_hive/cart.dart';
import 'package:srm_final/widget/model_hive/hive_service.dart';
import 'package:srm_final/widget/model_hive/locator.dart';
import 'package:validators/validators.dart';
import 'details_row_widget.dart';
import 'package:http/http.dart' as http;



class ProdukDetails extends StatefulWidget {
  final Produk produk;
  const ProdukDetails({Key key, this.produk}) : super(key: key);

  @override
  _ProdukDetailsState createState() => _ProdukDetailsState();
}

class _ProdukDetailsState extends State<ProdukDetails> {
  final HiveService hiveService = locator<HiveService>();
  List<dynamic> _cartList = [];
  List<dynamic> get cartList => _cartList;

  int _currentImage = 0;
  var U = new NumberFormat("'Rp. '###,###.00#", "id_ID");
  List<Widget> buildPageIndicator(){
    List<Widget> list = [];
    for (var i = 0; i < widget.produk.images.length; i++) {
      list.add(buildIndicator(i == _currentImage));
    }
    return list;
  }
  Widget buildIndicator(bool isActive){
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
  void dilihatMethod () async {
    await http.post(SumberApi.dilihat, body: {"id": widget.produk.id.toString()});
    debugPrint('update value show');
  }
  @override
  void initState() {
    dilihatMethod();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var spesialsize;
    //specialSize
    if (MediaQuery.of(context).size.height>MediaQuery.of(context).size.width){
      spesialsize=MediaQuery.of(context).size.width;
    }else{
      spesialsize=MediaQuery.of(context).size.height;
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
          NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                backgroundColor: Colors.transparent,
                pinned: false,
                floating: true,
                expandedHeight: MediaQuery.of(context).size.height*0.55,
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  title: widget.produk.images.length > 1
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
                        onPageChanged: (int page){
                          setState(() {
                            _currentImage = page;
                          });
                        },
                        children: widget.produk.images.map((String path) {
                          return Container(
                            child: _bangunGambarDetail(path),
                            height: MediaQuery.of(context).size.height*0.5,
                          );
                        }).toList(),
                      ),
                    ) ,
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
              height: MediaQuery.of(context).size.height,
              child: SingleChildScrollView(
                  child: Container(
                    height: 650,
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
                        Center(child: Text('Sweet Room Medan', style: GoogleFonts.alexBrush(
                            fontSize: 35,
                            color: Color.fromRGBO(225, 80, 80, 1)
                        ),),),
                        Row(
                          children: <Widget>[
                            Image.network(widget.produk.images[0],
                        height: 80,
                        width: 80,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              widget.produk.kain,
                              maxLines: 1,
                              overflow: TextOverflow.fade,
                              softWrap: false,
                              style: GoogleFonts.lobster(
                                  fontSize: 25,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white),
                            ),
                            Text(
                              widget.produk.seri,
                              style: GoogleFonts.lato(
                                fontSize: 18,
                                  color: Colors.white.withOpacity(0.6)),
                            )
                          ],
                        ),
                      ),
                      Expanded(
                          child:Row(
                            children: [
                              Container(
                                  width: spesialsize*0.12,
                                  height: spesialsize*0.12,
                                  decoration: BoxDecoration(
                                    color: Colors.red[900],
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(15),
                                    ),
                                  ),
                                  child: Icon(
                                    Icons.bookmark_border,
                                    color: Colors.white,
                                    size: spesialsize*0.07,
                                  )
                              ),

                              SizedBox(
                                width:  5,
                              ),

                              Container(
                                  width: spesialsize*0.12,
                                  height: spesialsize*0.12,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(15),
                                    ),
                                    border: Border.all(
                                      color: Colors.grey[300],
                                      width: 1,
                                    ),
                                  ),
                                  child: Icon(
                                    Icons.share,
                                    color: Colors.grey,
                                    size: spesialsize*0.07,
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
                      details: widget.produk.kain),
                        DetailsRow(heading: "Seri/Motif", details: widget.produk.seri),
                        DetailsRow(heading: "Bidang Kain (cm)", details: widget.produk.bidang.toString()),
                        DetailsRow(
                      heading: "Stok (m)", details: widget.produk.stok.toString()),
                        DetailsRow(
                      heading: "Rate (1-5)", details: widget.produk.rate.toString()),
                        DetailsRow(
                      heading: "Harga/m",
                      details: U.format(widget.produk.harga).toString()),
                        DetailsRow(
                      heading: "Pembeli", details: widget.produk.pembeli.toString()),
                        Container(
                          padding: EdgeInsets.only( left: 16, right: 16, bottom: 5),
                          height: 140,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              color: Colors.grey[100],
                              borderRadius: BorderRadius.all(Radius.circular(20))
                          ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 10, left: 16, right: 16, bottom: 5),
                          child: Text(
                            "Options",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[400],
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Expanded(child:InkWell(
                              splashColor: Colors.red,
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text("Jumlah"),
                                          content: Text("Connection Error, Please try again!"),
                                          actions: [
                                            Text("Ok mas bro"),
                                          ],
                                        );
                                      });
                                },
                                child: _buildSpec('Kain Saja', 'Pembelian Bahan'))),
                            SizedBox(width: 5,),
                            Expanded(child:_buildSpec('Sprei', 'Sprei, Sarung Bantal & Guling')),
                            SizedBox(width: 5,),
                            Expanded(child:_buildSpec('Bedcover', 'Bedcover/Selimut')),
                          ],
                        )
                      ],
                    ),
                ),
              ],
            ),
                  )
            ),
          ),
          ),
          Positioned(
            bottom: 0,
            child: _bangunBeli(widget:widget, context:context),
          )
        ]
      )
    );
  }
  _bangunGambarDetail(String path) {
    if (isURL(path)) {
      return Hero(
        tag: widget.produk.seri,
        child: GestureDetector(
          onTap: () => showSimpleDialog(context, path),
          child: CachedNetworkImage(
            imageUrl:path,
            placeholder: (context, url) => Container(
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
    }else{
      return Hero(
        tag: widget.produk.seri,
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
  Widget  _bangunBeli({ProdukDetails widget, BuildContext context}) {
    return Container(
      height: 80,
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20)),
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
                  "Harga Barang",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      U.format(widget.produk.harga).toString(),
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () async{
                Cart cart = Cart(
                    id: widget.produk.id,
                    kain: widget.produk.kain,
                    seri: widget.produk.seri,
                    harga: widget.produk.harga,
                    stok: widget.produk.stok,
                    tglMasuk: widget.produk.tglMasuk,
                    kondisi: widget.produk.kondisi,
                    bidang: widget.produk.bidang,
                    rate:widget.produk.rate,
                    pembeli: widget.produk.pembeli,
                    dilihat: widget.produk.dilihat,
                    whistlist:widget.produk.whistlist,
                    images: widget.produk.images);
                _cartList.add(cart);
                debugPrint('add to Cart');
                await hiveService.addBoxesTypeList(_cartList, "CartTabel");
              },
              child: Container(
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.all(
                    Radius.circular(15),
                  ),
                ),
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      margin: EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Text('Add to Cart', style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),),
                          Icon(Icons.shopping_cart,
                          color: Colors.white,
                          ),
                        ],
                      ),
                    )
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
Widget _buildSpec(String title, String data){
  return Container(
    height: 100,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.all(
        Radius.circular(15),
      ),
    ),
    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
    child: Column(
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
    ),
  );
}
}

