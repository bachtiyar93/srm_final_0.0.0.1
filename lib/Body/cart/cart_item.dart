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
      width: MediaQuery.of(context).size.width*0.74,
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
              'INV.2020/21/SRM/APP',
              style: TextStyle(fontSize: 18, color: Colors.black),
            ),
          ),
          Positioned(
            bottom: 60,
            left: 10,
            child: Text(
              widget.cart.kain,
              style: TextStyle(fontSize: 18, color: Colors.black),
            ),
          ),
          Positioned(
              bottom: 35,
              left: 10,
            child: Text(
              'Harga :' + U.format(widget.cart.harga).toString(),
              style: TextStyle(fontSize: 18, color: Colors.black),
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
              bottom: 10,
              left: 10,
              // ignore: unrelated_type_equality_checks
              child: Text(
                'Motif: '+widget.cart.seri,
                style: TextStyle(fontSize: 18),
              )
          )
        ]));
  }
}