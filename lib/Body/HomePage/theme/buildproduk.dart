import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:validators/validators.dart';
import 'data.dart';
import 'theme.dart';


Widget buildProduk(Produk produk, int index, BuildContext context){
  //Ukuran
  var spesialsize;
  spesialsize=MediaQuery.of(context).size.width;
  var warnaLabel;
  warnaLabel=produk.stok == "Baru" ? LightColors.warnaJudul : produk.stok == "Promo" ? Colors.blue : Colors.grey;
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.all(
        Radius.circular(15),
      ),
    ),
    padding: EdgeInsets.all(11),
    child: Column(
      children: <Widget>[
        Align(
          alignment: Alignment.centerRight,
          child: Container(
            decoration: BoxDecoration(
              color: warnaLabel,
              borderRadius: BorderRadius.all(
                Radius.circular(15),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Text(
                // "Promo " + (produk.condition == "Baru" ? "Produk Baru" : produk.condition == "Promo" ? "Terbatas" : "Reguler"),
              (produk.stok == "Baru" ? produk.stok : produk.stok == "Promo" ? "Terbatas" : "Reguler"),
                style: TextStyle(
                  fontSize: spesialsize*0.015,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),

        SizedBox(
          height: spesialsize*0.02,
        ),

        _bangunGambar(produk:produk, context:context),

        SizedBox(
          height: spesialsize*0.02,
        ),

        Text(
          produk.seri,
          style: TextStyle(
            fontSize: spesialsize*0.03
          ),
        ),

        SizedBox(
          height: spesialsize*0.02,
        ),

        Text(
          produk.kain,
          style: TextStyle(
            fontSize: spesialsize*0.03,
            fontWeight: FontWeight.bold,
            height: 1,
          ),
        ),
        SizedBox(
          height: spesialsize*0.02,
        ),
    _bangunHarga(produk, index, context),
      ],
    ),
  );
}

_bangunGambar({Produk produk, BuildContext context}) {
  if (isURL(produk.images[0],)) {
    return Container(
      height: MediaQuery.of(context).size.height*0.23,
      child: Center(
        child: Hero(
          tag: produk.seri,
          child:  Image.network(
            produk.images[0],fit: BoxFit.fitWidth,
            loadingBuilder:(BuildContext context, Widget child,ImageChunkEvent loadingProgress) {
              if (loadingProgress == null) return child;
              return Center(
                child: CircularProgressIndicator(
                  value: loadingProgress.expectedTotalBytes != null ?
                  loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes
                      : null,
                ),
              );
            },
          ),
        ),
      ),
    );
  }else{
    return Container(
      child: Center(
        child: Hero(
          tag: produk.seri,
          child: Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.grey,
                valueColor: new AlwaysStoppedAnimation<Color>(
                    Colors.red),
              )
          )
        ),
      ),
    );
  }
}

Widget _bangunHarga(Produk produk, int index, BuildContext context) {
var spesialsize;
spesialsize=MediaQuery.of(context).size.width;
var U = new NumberFormat("'Rp. '###,###.0#", "id_ID");
if (produk.stok == "Baru"){
  return Text(
    U.format(produk.harga).toString(),
    style: TextStyle(
        fontSize: spesialsize*0.025,
        fontWeight: FontWeight.bold
    ),
  );
} else if (produk.stok=='Promo'){
  return Column(
    children: [
      Text(
        U.format(produk.harga*1.6).toString(),
        style: TextStyle(
          fontSize: spesialsize*0.023,
          color: Colors.red,
          decoration: TextDecoration.lineThrough,
        ),
      ),
      Text(
        U.format(produk.harga).toString(),
        style: TextStyle(
            fontSize: spesialsize*0.025,
            fontWeight: FontWeight.bold
        ),
      ),
    ],
  );
}else {
return Column(
  children: [
        Text(
     "Gunakan Kupon",
      style: TextStyle(
      fontSize: spesialsize*0.023,
      ),
      ),
    Text(
      "Rp. " + produk.harga.toString(),
      style: TextStyle(
          fontSize: spesialsize*0.025,
          fontWeight: FontWeight.bold
      ),
    ),
  ],
);
}
}