import 'package:adobe_xd/adobe_xd.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:srm_final/Body/HomePage/theme/daftarproduk.dart';
import 'package:srm_final/widget/search_widget.dart';

class ProdukPage extends StatefulWidget {
  ProdukPage(List<dynamic> produkList):this.produkList=produkList ?? [];
  final produkList;
  @override
  State<StatefulWidget> createState() => _ProdukPage();

}
class _ProdukPage extends State<ProdukPage>{
  var query='';
  @override
  Widget build(BuildContext context) {
    debugPrint('on ProdukPage');
    return Scaffold(
      appBar: AppBar(
        actions: [
          MaterialButton(
            onPressed:() async {
              final String selected = await showSearch(
                  context: context,
                  delegate: Search(produkList: widget.produkList));
              if (selected != null && selected != query) {
                setState(() {
                  query = selected;
                });
              }
            },
            child: Row(
              children: [
                Text('Search', style: TextStyle(fontSize: 20),),
                Icon(Icons.search),
              ],
            ),
          )
        ],
      ),
      body: Stack(
        children: [
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
          SingleChildScrollView(
            child: Column(
              children:[
                GestureDetector(
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => DaftarProduk(widget.produkList)),
                      );
                    },
                    child: CardProduk('Semua Kain','Koleksi berbagai jenis kain')),
            GestureDetector(
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DaftarProduk(widget.produkList)),
                  );
                },
                child:CardProduk('Produk Ready','Berbagai macam sprei, bantal & guling')),
            GestureDetector(
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DaftarProduk(widget.produkList)),
                  );
                },
                child:CardProduk('Aksesoris & Perlengkapan Bed','Koleksi aksesoris bed, dacron, griper dll')),
                GestureDetector(
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => DaftarProduk(widget.produkList)),
                      );
                    },
                child:CardProduk('Curtains','Koleksi gordyn, roller, shade & blind dll')),
                GestureDetector(
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => DaftarProduk(widget.produkList.where((i) => i.whistlist==1).toList())),
                      );
                    },
                    child:CardProduk('Whistlist Saya','Produk ditandai')),
            ]
            ),
          ),
        ],
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
                  fontSize: 19,
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