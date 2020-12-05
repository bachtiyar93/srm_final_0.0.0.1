import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:srm_final/widget/model_hive/anime.dart';
import 'package:srm_final/widget/produk_detail/details.dart';

class ProdukShowSlide extends StatelessWidget {
  final Produk produk;
  final int star;
  const ProdukShowSlide({Key key, this.produk, this.star=0}) :assert (star !=null),super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () => Navigator.push(context,
              MaterialPageRoute(builder: (context) => ProdukDetails(produk: produk))),
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
                  child: Image.network(produk.images[0],
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
                    top: 10,
                    right: 10,
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(3)),
                          color: Colors.grey[300]
                      ),
                      child: Icon(
                        Icons.bookmark_border,
                        color: Colors.grey,
                      ),
                    )),
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
                          produk.kain,
                          textAlign: TextAlign.right,
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                        SizedBox(width: 40,),
                        Text(
                          produk.harga.toString(),
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
