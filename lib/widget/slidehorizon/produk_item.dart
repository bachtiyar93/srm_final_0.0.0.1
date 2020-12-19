import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:shimmer/shimmer.dart';
import 'package:srm_final/widget/model_hive/anime.dart';
import 'package:srm_final/widget/produk_detail/details.dart';

class ProdukItem extends StatefulWidget {
  final Produk produkList;
  final int star;
  final index;
  const ProdukItem({Key key, this.produkList, this.index ,this.star=0}) :assert (star !=null),super(key: key);

  @override
  _ProdukItemState createState() => _ProdukItemState();
}

class _ProdukItemState extends State<ProdukItem> {
  bool whis=false;
  Future<bool> cekWhis() async {
    var box = await Hive.openBox(widget.produkList.seri);
    var cek = box.get('whistlist');
    if (cek == 0||cek==null) {
      box.put('whislist', 0);
      setState(() {
        whis = false;
      });
    } else {
      setState(() {
        whis = true;
      });
    }
  }
      @override
  void initState() {
    cekWhis();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(context,
          MaterialPageRoute(builder: (context) => ProdukDetails(produkList: widget.produkList, index: widget.index,))),
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
                imageUrl:widget.produkList.images[0],
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
                widget.produkList.produk,
                style: TextStyle(fontSize: 18, color: Colors.black),
              ),
            ),
            Positioned(
              bottom: 100,
              left: 10,
              child: Text(
                'Bidang(cm) : '+widget.produkList.bidang.toString(),
                style: TextStyle(fontSize: 18, color: Colors.black),
              ),
            ),
            Positioned(
              bottom: 80,
              left: 10,
              child: Text(
                'Harga(IDR) :' + widget.produkList.harga.toString(),
                style: TextStyle(fontSize: 18, color: Colors.black),
              ),
            ),
            Positioned(
              bottom: 60,
              left: 10,
              child: Text(
                'Status : '+(widget.produkList.kondisi==0? 'Ready': (widget.produkList.kondisi==1? 'New Arrival':'Habis')),
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
                        index < widget.produkList.rate ? Icons.star : Icons.star_border,
                        color: Colors.yellow[900],
                      );
                    })
                )),
            Positioned(
                top: 10,
                right: 10,
                child: GestureDetector(
                  onTap: () async {
                    if (whis==false) {
                      var box = await Hive.openBox(widget.produkList.seri);
                      box.put('whistlist',1);
                      Hive.box('ProdukTabel').putAt(widget.index, Produk(
                        id:widget.produkList.id,
                        produk: widget.produkList.produk,
                        seri: widget.produkList.seri,
                        harga: widget.produkList.harga,
                        stok: widget.produkList.stok,
                        tglMasuk: widget.produkList.tglMasuk,
                        kondisi: widget.produkList.kondisi,
                        bidang: widget.produkList.bidang,
                        rate: widget.produkList.rate,
                        pembeli: widget.produkList.pembeli,
                        dilihat: widget.produkList.dilihat,
                        whistlist: 1,
                        images: widget.produkList.images,
                      ));
                      setState(() {
                        whis=true;
                      });
                    }else {
                      var box = await Hive.openBox(widget.produkList.seri);
                      box.put('whistlist',0);
                      Hive.box('ProdukTabel').putAt(widget.index, Produk(
                        id:widget.produkList.id,
                        produk: widget.produkList.produk,
                        seri: widget.produkList.seri,
                        harga: widget.produkList.harga,
                        stok: widget.produkList.stok,
                        tglMasuk: widget.produkList.tglMasuk,
                        kondisi: widget.produkList.kondisi,
                        bidang: widget.produkList.bidang,
                        rate: widget.produkList.rate,
                        pembeli: widget.produkList.pembeli,
                        dilihat: widget.produkList.dilihat,
                        whistlist: 0,
                        images: widget.produkList.images,
                      ));
                      setState(() {
                        whis=false;
                      });
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(3)),
                        color: whis==true?Colors.red[600]:Colors.grey[300]
                    ),
                    child: Icon(
                      Icons.bookmark_border,
                      color:  whis==true?Colors.white:Colors.grey,
                    ),
                  ),
                )),
            Positioned(
                bottom: 10,
                left: 10,
                // ignore: unrelated_type_equality_checks
                child: Text(
                        'Motif: '+widget.produkList.seri,
                        style: TextStyle(fontSize: 18),
                      )
            )
                    ])),
    );
  }
}
