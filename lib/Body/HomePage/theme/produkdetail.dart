import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:srm_final/widget/model_hive/anime.dart';
import 'package:srm_final/widget/produk_detail/details_row_widget.dart';
import 'package:validators/validators.dart';


class ProdukDetail extends StatefulWidget {
  final Produk produk;
  ProdukDetail({@required this.produk, BuildContext context});

  @override
  _ProdukDetailState createState() => _ProdukDetailState();
}
class _ProdukDetailState extends State<ProdukDetail> {
  int _currentImage = 0;
  var U = new NumberFormat("'Rp. '###,###.0#", "id_ID");
  List<Widget> buildPageIndicator(){
    List<Widget> list = [];
    for (var i = 0; i < widget.produk.images.length; i++) {
      list.add(buildIndicator(i == _currentImage));
    }
    return list;
  }

  Widget buildIndicator(bool isActive){
    debugPrint('on Produk Detail');
    return AnimatedContainer(
      duration: Duration(milliseconds: 100),
      margin: EdgeInsets.symmetric(horizontal: 6),
      height: 15,
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
    var spesialsize;
    //specialSize
    if (MediaQuery.of(context).size.height>MediaQuery.of(context).size.width){
    spesialsize=MediaQuery.of(context).size.width;
    }else{
    spesialsize=MediaQuery.of(context).size.height;
    }
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Container(
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
                                  Icons.keyboard_arrow_left,
                                  color: Colors.black,
                                  size: spesialsize*0.07,
                                )
                              ),
                            ),

                            Row(
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
                                  width:  spesialsize*0.001,
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
                                    color: Colors.black,
                                    size: spesialsize*0.07,
                                  )
                                ),

                              ],
                            ),

                          ],
                        ),
                      ),

                      SizedBox(
                        height:  0.001,
                      ),

                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          widget.produk.seri,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      SizedBox(
                        height: 0.001,
                      ),

                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          widget.produk.produk,
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                        ),
                      ),

                      SizedBox(
                        height:spesialsize*0.001,
                      ),

                      Expanded(
                        child: Container(
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
                              );
                            }).toList(),
                          ),
                        ),
                      ),

                      widget.produk.images.length > 1
                      ? Container(
                        margin: EdgeInsets.symmetric(vertical: spesialsize*0.01),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: buildPageIndicator(),
                        ),
                      )
                      : Container(),

                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: spesialsize*0.01),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            buildPricePerPeriod(
                              "12",
                              U.format(widget.produk.harga/12).toString(),
                              true,
                            ),
                            SizedBox(
                              width: spesialsize*0.05,
                            ),
                            buildPricePerPeriod(
                              "6",
                              U.format(widget.produk.harga/6).toString(),
                              false,
                            ),
                            SizedBox(
                              width:spesialsize*0.05,
                            ),
                            buildPricePerPeriod(
                              "1",
                              U.format(widget.produk.harga).toString(),
                              false,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              
              Container(
                height: 116,
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 0, left: 16, right: 16),
                      child: Text(
                        "SPECIFICATIONS",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[400],
                        ),
                      ),
                    ),
                    _buildSpec(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _bangunBeli(widget:widget, context:context),
    );
  }

  Widget buildPricePerPeriod(String months, String price, bool selected){
    return Expanded(
      child: Container(
        height: 80,
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: selected ? Colors.red[900] : Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
          border: Border.all(
            color: Colors.grey[300],
            width: selected ? 0 : 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              months + " Month",
              style: TextStyle(
                color: selected ? Colors.white : Colors.black,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),

            Text(
              price,
              style: TextStyle(
                color: selected ? Colors.white : Colors.black,
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget _buildSpec() {
    var spesialsize;
    //specialSize
    if (MediaQuery.of(context).size.height>MediaQuery.of(context).size.width){
      spesialsize=MediaQuery.of(context).size.width;
    }else{
      spesialsize=MediaQuery.of(context).size.height;
    }
    return Container(
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
                          widget.produk.produk,
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
                          width:  spesialsize*0.001,
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
                              color: Colors.black,
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
                  details: widget.produk.produk),
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
            ],
          )),
    );
  }

  // Widget buildSpecificationCar(String title, String data){
  //   var spesialsize;
  //   //specialSize
  //   if (MediaQuery.of(context).size.height>MediaQuery.of(context).size.width){
  //     spesialsize=MediaQuery.of(context).size.width;
  //   }else{
  //     spesialsize=MediaQuery.of(context).size.height;
  //   }
  //   return Container(
  //     width: spesialsize*0.5,
  //     decoration: BoxDecoration(
  //       color: Colors.white,
  //       borderRadius: BorderRadius.all(
  //         Radius.circular(15),
  //       ),
  //     ),
  //     padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16,),
  //     margin: EdgeInsets.only(right: 16),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       children: [
  //         Text(
  //           title,
  //           style: TextStyle(
  //             color: Colors.grey,
  //             fontSize: 14,
  //           ),
  //         ),
  //
  //         SizedBox(
  //           height: 0.001,
  //         ),
  //
  //         Text(
  //           data,
  //           style: TextStyle(
  //             color: Colors.black,
  //             fontSize: 18,
  //             fontWeight: FontWeight.bold,
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

 Widget  _bangunBeli({ProdukDetail widget, BuildContext context}) {
    return Container(
      height: 75,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Text(
                "12 Month",
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

                  SizedBox(
                    width: 3,
                  ),

                  Text(
                    "per month",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                    ),
                  ),

                ],
              ),

            ],
          ),
          Container(
            height: 40,
            decoration: BoxDecoration(
              color: Colors.red[900],
              borderRadius: BorderRadius.all(
                Radius.circular(15),
              ),
            ),
            child: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Text(
                  "Beli ini",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
 }

  _bangunGambarDetail(String path) {
    if (isURL(path)) {
      return Hero(
        tag: widget.produk.seri,
        child: GestureDetector(
          onTap: () => showSimpleDialog(context, path),
          child: Image.network(
            path,
            fit: BoxFit.scaleDown,
            loadingBuilder:(BuildContext context, Widget child,ImageChunkEvent loadingProgress) {
              if (loadingProgress == null) return child;
              return Center(
                child: CircularProgressIndicator(
                  value: loadingProgress.expectedTotalBytes != null ?
                  loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes
                      : null,
                  backgroundColor: Colors.grey,
                  valueColor: new AlwaysStoppedAnimation<Color>(
                      Colors.red),
                ),
              );
            },
          ),
        ),
      );
    }else{
      return Hero(
        tag: widget.produk.seri,
        child: Image.network(
          "https://www.houseofwellness.com.au/wp-content/uploads/2018/06/smile-GettyImages-882495390-crop.jpg",
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
            Image.network(path)
          ],
        );
      },
    );
  }
}