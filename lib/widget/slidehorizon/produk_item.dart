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
              borderRadius: BorderRadius.only(topLeft: Radius.circular(8),topRight: Radius.circular(8) ),
              child: Image.network(produk.images[0],
                loadingBuilder:(BuildContext context, Widget child,ImageChunkEvent loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Container(
                    alignment: Alignment.topCenter,
                    child: Shimmer.fromColors(
                        child: Image.asset('assets/ic_logo.png',
                          height: 110,
                        ), baseColor: Colors.grey, highlightColor: Colors.white),
                  );
                },
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
                bottom: 10,
                right: 10,
                child: Icon(
                  Icons.shopping_cart,
                  color: Colors.red,
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
