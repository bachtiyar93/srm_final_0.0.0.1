import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:srm_final/Body/HomePage/theme/daftarproduk.dart';

class ProdukPage extends StatefulWidget {
  ProdukPage(List<dynamic> produkList):this.produkList=produkList ?? [];
  final produkList;
  @override
  State<StatefulWidget> createState() => _ProdukPage();

}
class _ProdukPage extends State<ProdukPage>{
  @override
  Widget build(BuildContext context) {
    debugPrint('on ProdukPage');
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children:[
            GestureDetector(
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DaftarProduk()),
                  );
                },
                child: CardProduk('Semua Kain','Koleksi berbagai jenis kain')),
        GestureDetector(
            onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DaftarProduk()),
              );
            },
            child:CardProduk('Produk Ready','Berbagai macam sprei, bantal & guling')),
        GestureDetector(
            onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DaftarProduk()),
              );
            },
            child:CardProduk('Aksesoris & Perlengkapan Bed','Koleksi aksesoris bed, dacron, griper dll')),
            GestureDetector(
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DaftarProduk()),
                  );
                },
            child:CardProduk('Curtains','Koleksi gordyn, roller, shade & blind dll')),
        ]
        ),
      ),
    );
  }
}

Widget CardProduk(String nama_produk, String text_penjelasan) {
  return Padding(
    padding: EdgeInsets.only(top: 16, right: 16, left: 16),
    child: Container(
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      padding: EdgeInsets.all(24),
      height: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Text(
                nama_produk,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),

              Text(
                text_penjelasan,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),

            ],
          ),

          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(15),
              ),
            ),
            height: 50,
            width: 50,
            child: Center(
              child: Icon(
                Icons.arrow_forward_ios,
                color: Colors.red,
              ),
            ),
          ),

        ],
      ),
    ),
  );
}