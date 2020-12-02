import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:srm_final/widget/model_hive/anime.dart';
import 'package:srm_final/widget/produk_detail/details.dart';

class ProdukItem extends StatelessWidget {
  final Produk produk;
  final int star;
  const ProdukItem({Key key, this.produk, this.star=0}) :assert (star !=null),super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(context,
          MaterialPageRoute(builder: (context) => ProdukDetails(produk: produk))),
      child: Container(
          decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Color.fromRGBO(220, 220, 220, 1),
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
              borderRadius: BorderRadius.only(topLeft: Radius.circular(8),topRight: Radius.circular(8) ),
              child: CachedNetworkImage(
                imageUrl:produk.images[0],
                placeholder: (context, url) => Container(
                  alignment: Alignment.topCenter,
                  child: Shimmer.fromColors(
                      child: Image.asset('assets/ic_logo.png',
                        height: 110,
                        fit: BoxFit.cover,
                      ), baseColor: Colors.grey, highlightColor: Colors.white),
                ),
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              bottom: 120,
              left: 10,
              child: Text(
                produk.kain,
                style: TextStyle(fontSize: 18, color: Colors.black),
              ),
            ),
            Positioned(
              bottom: 100,
              left: 10,
              child: Text(
                'Bidang(cm) : '+produk.bidang.toString(),
                style: TextStyle(fontSize: 18, color: Colors.black),
              ),
            ),
            Positioned(
              bottom: 80,
              left: 10,
              child: Text(
                'Harga(IDR) :' + produk.harga.toString(),
                style: TextStyle(fontSize: 18, color: Colors.black),
              ),
            ),
            Positioned(
              bottom: 60,
              left: 10,
              child: Text(
                'Status : '+(produk.kondisi==0? 'Ready': (produk.kondisi==1? 'New Arrival':'Habis')),
                style: TextStyle(fontSize: 18, color: Colors.black),
              ),
            ),
            Positioned(
                bottom: 35,
                left: 10,
                child: Row(
                  children:
                    List.generate(5, (index) {
                      return Icon(
                        index < produk.rate ? Icons.star : Icons.star_border,
                        color: Colors.yellow[900],
                      );
                    })
                )),
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
                bottom: 10,
                left: 10,
                // ignore: unrelated_type_equality_checks
                child: Text(
                        'Motif: '+produk.seri,
                        style: TextStyle(fontSize: 18),
                      )
            )
                    ])),
    );
  }
}
