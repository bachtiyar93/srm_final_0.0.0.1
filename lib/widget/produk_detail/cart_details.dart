import 'package:adobe_xd/pinned.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import 'package:srm_final/Body/payment.dart';
import 'package:srm_final/widget/model_hive/cart.dart';
import 'package:srm_final/widget/model_hive/hive_service.dart';
import 'package:srm_final/widget/model_hive/locator.dart';
import 'package:validators/validators.dart';



class CartDetails extends StatefulWidget {
  final Cart cartList;
  final index;
  const CartDetails({Key key, this.cartList, this.index}) : super(key: key);


  @override
  _ProdukDetailsState createState() => _ProdukDetailsState();
}

class _ProdukDetailsState extends State<CartDetails> with TickerProviderStateMixin{
  final _keyConfirm = new GlobalKey<FormState>();
  Color onPressColor1=Colors.white,onPressColor2=Colors.white,onPressColor3=Colors.white;
  final HiveService hiveService = locator<HiveService>();
  List<dynamic> _cartList = [];
  List<dynamic> get cartList => _cartList;

  int _currentImage = 0;
  var U = new NumberFormat("'Rp. '###,###.00#", "id_ID");

  List<Widget> buildPageIndicator(){
    List<Widget> list = [];
    for (var i = 0; i < widget.cartList.images.length; i++) {
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

  @override
  Widget build(BuildContext context) {
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
                  title: widget.cartList.images.length > 1
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
                        children: widget.cartList.images.map((String path) {
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
                        SizedBox(
                          height: 10,),
                        Container(
                          padding: EdgeInsets.only( left: 16, right: 16, bottom: 5),
                          height: MediaQuery.of(context).size.height*0.8,
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
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "Detail Pemesanan",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey[700],
                                  ),
                                ),
                              ),
                              Material(
                                borderRadius: BorderRadius.circular(5),
                                elevation: 18.0,
                                color:Colors.white,
                                clipBehavior: Clip.antiAlias,
                                child: Container(
                                  width: 30,
                                  child: Text(
                                    "Edit",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey[700],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: 505,
                          child: ListView(
                            children: [
                              Material(
                                elevation: 18.0,
                                color:onPressColor1,
                                clipBehavior: Clip.antiAlias,
                                child:
                                _buildSpec('Purchase Order',widget.cartList.produk,widget.cartList.seri,widget.cartList.size,widget.cartList.qty.toString(),U.format(widget.cartList.harga).toString()),
                              ),
                              SizedBox(height: 10,),
                              Material(
                                elevation: 18.0,
                                color:onPressColor1,
                                clipBehavior: Clip.antiAlias,
                                child:
                                _buildSpec('Produk Detail',widget.cartList.produk,widget.cartList.seri,widget.cartList.size,widget.cartList.qty.toString(),U.format(widget.cartList.harga).toString()),
                              ),
                              SizedBox(height: 10,),
                              Material(
                                elevation: 18.0,
                                color:onPressColor1,
                                clipBehavior: Clip.antiAlias,
                                child:
                                _buildSpec('Alamat Pengiriman',widget.cartList.produk,widget.cartList.seri,widget.cartList.size,widget.cartList.qty.toString(),U.format(widget.cartList.harga).toString()),
                              ),
                              SizedBox(height: 10,),
                              Material(
                                elevation: 18.0,
                                color:onPressColor1,
                                clipBehavior: Clip.antiAlias,
                                child:
                                _buildSpec('Keterangan',widget.cartList.produk,widget.cartList.seri,widget.cartList.size,widget.cartList.qty.toString(),U.format(widget.cartList.harga).toString()),
                              ),
                            ],
                          ),
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
        tag: widget.cartList.seri,
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
            fit: BoxFit.cover,
          ),
        ),
      );
    }else{
      return Hero(
        tag: widget.cartList.seri,
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
  Widget _buildSpec(String header,String title, String seri, String size, String qty, String harga){
    return Container(
        height: 100,
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Text(header, textAlign: TextAlign.left, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
            Table(
              border: TableBorder.all(width: 1, color: Colors.grey[300]),
              children: [
                TableRow(
                    children: [
                      TableCell(child: Text('No. Produk',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                      TableCell(
                        child: Text(title=='Katun Jepang'?'SR'+DateTime.now().toString():'Other',
                          textAlign: TextAlign.end,
                        ),
                      ),
                    ]
                ),
                TableRow(
                    children: [
                      TableCell(child: Text('Produk',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                      TableCell(
                        child: Text(title=='Katun Jepang'?'Kain Saja':title,
                          textAlign: TextAlign.end,
                        ),
                      ),
                    ]
                ),
                TableRow(
                    children: [
                      TableCell(child: Text('Jenis',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                      TableCell(
                        child: Text(title,
                          textAlign: TextAlign.end,
                        ),
                      ),
                    ]
                ),
                TableRow(
                    children: [
                      TableCell(child: Text('Model',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                      TableCell(
                        child: Text(seri,
                          textAlign: TextAlign.end,
                        ),
                      ),
                    ]
                ),
                TableRow(
                    children: [
                      TableCell(child: Text('Ukuran',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                      TableCell(
                        child: Text(size,
                          textAlign: TextAlign.end,
                        ),
                      ),
                    ]
                ),
                TableRow(
                    children: [
                      TableCell(child: Text('Quantity',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                      TableCell(
                        child: Text(qty,
                          textAlign: TextAlign.end,
                        ),
                      ),
                    ]
                ),
                TableRow(
                    children: [
                      TableCell(child: Text('Harga',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                      TableCell(
                        child: Text(harga,
                          textAlign: TextAlign.end,
                        ),
                      ),
                    ]
                ),
              ],
            ),
          ],
        )
    );
  }
  
  Widget  _bangunBeli({CartDetails widget, BuildContext context}) {
    return Container(
      height: 80,
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20)),
        color: Colors.red[600],
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
                  "Total Item",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                Row(
                  children: [
                    Text(
                     U.format(widget.cartList.qty*widget.cartList.harga).toString(),
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => PaymentPage()));
              },
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration:(
                BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(100)),
                  color: Colors.white,
                )
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                   Icon(Icons.monetization_on_outlined),
                    Text('Order Sekarang')
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void save() async {
    final form = _keyConfirm.currentState;
    if (form.validate()) {
      form.save();
    }
  }
}

