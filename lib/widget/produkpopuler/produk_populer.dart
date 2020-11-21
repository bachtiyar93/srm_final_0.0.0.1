import 'package:flutter/material.dart';
import 'package:srm_final/widget/slidehorizon/produk_item.dart';

class ProdukKamiPage extends StatefulWidget {
  ProdukKamiPage(List produkList, {Key key}): this.produkList=produkList ?? [];
  final List<dynamic> produkList;

  @override
  _PopularFoodsWidgetState createState() => _PopularFoodsWidgetState();
}

class _PopularFoodsWidgetState extends State<ProdukKamiPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 265,
      width: double.infinity,
      child: Column(
        children: <Widget>[
          ProdukTitle(),
          Expanded(
            child: ProdukItems(widget.produkList),
          )
        ],
      ),
    );
  }
}



class ProdukTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text('Produk Kami',
                style: TextStyle(
                  color: Colors.red[300],
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.left,
              ),
              Text('Lihat semua',
                style: TextStyle(
                    color: Colors.blue
                ),
                textAlign: TextAlign.right,)
            ],
          ),
          Container(
            height: 1,
            width: MediaQuery.of(context).size.width,
            color: Colors.red[300],
          ),
        ],
      ),
    );
  }
}

class ProdukItems extends StatelessWidget {
  String query = '';
  ProdukItems(List produkList, {Key key}): this.produkList=produkList ?? [];
  final List<dynamic> produkList;
  @override
  Widget build(BuildContext context) {
    return  ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: produkList.length,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.all(2),
            child: AspectRatio(
              aspectRatio: 1/1.7,
              child: ProdukItem(
                produk: produkList[index],
              ),
            ),
          );
        },
    );
  }
}


