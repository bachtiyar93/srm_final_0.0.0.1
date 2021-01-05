import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import 'package:srm_final/widget/model_hive/cart.dart';


class CartItem extends StatefulWidget {
  final Cart cart;
  final int star;
  final int index;
  const CartItem({Key key, this.cart, this.index, this.star=0}) :assert (star !=null),super(key: key);

  @override
  _CartItemState createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  var U = new NumberFormat("'Rp. '###,###.00#", "id_ID");
  @override
  Widget build(BuildContext context) {
    return _modelCart(context);
  }

Widget  _modelCart(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Color.fromRGBO(220, 220, 220, 1),
                offset: Offset(-6.0, -6.0),
                blurRadius: 16.0,),
              BoxShadow(
                color: Color.fromRGBO(220, 220, 220, 1),
                offset: Offset(6.0, 6.0),
                blurRadius: 16.0,),
            ],
            borderRadius: BorderRadius.circular(10), color: Color.fromRGBO(230, 230, 230, 1)),
        child: Stack(
          alignment: Alignment.topRight,
            children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.only(topRight: Radius.circular(8),bottomRight: Radius.circular(8) ),
            child: CachedNetworkImage(
              imageUrl:widget.cart.images[0],
              placeholder: (context, url) => Container(
                alignment: Alignment.topCenter,
                child: Shimmer.fromColors(
                    child: Image.asset('assets/ic_logo.png',
                      fit: BoxFit.cover,
                    ), baseColor: Colors.grey, highlightColor: Colors.white),
              ),
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            bottom: 80,
            left: 10,
            child: Text(
              'SR'+DateTime.now().year.toString()+DateTime.now().month.toString()+DateTime.now().day.toString()+DateTime.now().microsecond.toString(),
              style: TextStyle(fontSize: 18, color: Colors.black),
            ),
          ),
          Positioned(
            bottom: 60,
            left: 10,
            child: Text(
              widget.cart.produk,
              style: TextStyle(fontSize: 18, color: Colors.black),
            ),
          ),
          Positioned(
              bottom: 35,
              left: 10,
              child: Text(
              'Motif: '+widget.cart.seri,
                style: TextStyle(fontSize: 18),
              )
          ),
          Positioned(
              bottom: 10,
              left: 10,
            child: Text(
              'Jumlah : ' + (widget.cart.harga==.001?'Harga Nego':U.format(widget.cart.qty*widget.cart.harga).toString()),
              style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold
              ),
            )
          )
        ]));
  }
}