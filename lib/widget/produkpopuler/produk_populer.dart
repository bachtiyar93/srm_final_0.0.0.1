import 'package:flutter/material.dart';
import 'package:srm_final/widget/slidehorizon/produk_item.dart';

class ProdukPopulerPage extends StatefulWidget {
  ProdukPopulerPage(this.produkList, {Key key});
  final produkList;

  @override
  _PopularFoodsWidgetState createState() => _PopularFoodsWidgetState();
}

class _PopularFoodsWidgetState extends State<ProdukPopulerPage> {
  @override
  Widget build(BuildContext context) {
    debugPrint('on Produk Kami');
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
  ProdukItems(this.produkList, {Key key});
  final produkList;
  @override
  Widget build(BuildContext context) {
    debugPrint('on Produk Item');
    return  ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: produkList.length,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.all(2),
            child: AspectRatio(
              aspectRatio: 1/1.7,
              child: ProdukItem(
                index: index,
                produkList: produkList[index],
              ),
            ),
          );
        },
    );
  }
}


