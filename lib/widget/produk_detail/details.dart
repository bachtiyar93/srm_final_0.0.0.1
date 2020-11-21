import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:srm_final/apikey/sumberapi.dart';
import 'package:srm_final/widget/model_hive/anime.dart';
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
  @override
  void initState() {
     http.post(SumberApi.dilihat, body: {"id": widget.produk.id});
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                backgroundColor: Colors.transparent,
                pinned: false,
                expandedHeight: MediaQuery.of(context).size.height*0.6,
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  title: widget.produk.images.length > 1
                      ? Container(
                    margin: EdgeInsets.symmetric(vertical: 15),
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
                    )
                ),
            ];
          },
        body: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)),
                color: Colors.white
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
                        child: Icon(Icons.shopping_cart, size: 30, color: Colors.white,
                        )
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
              ],
            )),
          ),
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

