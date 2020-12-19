import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:shimmer/shimmer.dart';
import 'package:srm_final/widget/model_hive/anime.dart';
import 'package:srm_final/widget/produk_detail/details.dart';

class ProdukShowSlide extends StatefulWidget {
  final Produk produkList;
  final int star;
  final index;
  const ProdukShowSlide({Key key, this.produkList,this.index, this.star=0}) :assert (star !=null),super(key: key);

  @override
  _ProdukShowSlideState createState() => _ProdukShowSlideState();
}

class _ProdukShowSlideState extends State<ProdukShowSlide> {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () => Navigator.push(context,
              MaterialPageRoute(builder: (context) => ProdukDetails(produkList: widget.produkList, index: widget.index,))),
          child: Container(
            height: 170,
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.white,
                      offset: Offset(-6.0, -6.0),
                      blurRadius: 16.0,
                    ),
                    BoxShadow(
                      color: Color.fromRGBO(220, 220, 220, 1),
                      offset: Offset(6.0, 6.0),
                      blurRadius: 16.0,
                    ),
                  ],
                  borderRadius: BorderRadius.circular(10), color: Color.fromRGBO(230, 230, 230, 1)),
              child: Stack(children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  child: Image.network(widget.produkList.images[0],
                    height: 170,
                    loadingBuilder:(BuildContext context, Widget child,ImageChunkEvent loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Container(
                        alignment: Alignment.topCenter,
                        child: Shimmer.fromColors(
                            child: Image.asset('assets/ic_logo.png',
                              height: 170,
                            ), baseColor: Colors.grey, highlightColor: Colors.white),
                      );
                    },
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.4),
                      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(8), bottomRight: Radius.circular(8))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          widget.produkList.produk,
                          textAlign: TextAlign.right,
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                        SizedBox(width: 40,),
                        Text(
                          widget.produkList.harga.toString(),
                          textAlign: TextAlign.left,
                          style: TextStyle(fontSize: 18, color: Colors.white,),
                        ),
                      ],
                    ),
                  ),
                ),
              ])),
        ),
      ],
    );
  }
}
