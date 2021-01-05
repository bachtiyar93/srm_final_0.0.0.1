import 'package:adobe_xd/adobe_xd.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:srm_final/Body/cart/cart_item.dart';
import 'package:srm_final/Body/payment.dart';
import 'package:srm_final/widget/model_hive/cart_view_model.dart';
import 'package:srm_final/widget/model_hive/hive_service.dart';
import 'package:srm_final/widget/model_hive/locator.dart';
import 'package:srm_final/widget/produk_detail/cart_details.dart';
import 'package:stacked/stacked.dart';



class DaftarCart extends StatefulWidget {

  @override
  _DaftarCartState createState() => _DaftarCartState();
}

class _DaftarCartState extends State<DaftarCart> {
  //_totalBelanja = model.cartList.map<int>((m) => m.harga).reduce((a,b )=>a+b);
  double _total =0;
  double _oldTotal=0;
  bool cek = false;
   Future<String> hitungBayar() async {
    final HiveService hiveService = locator<HiveService>();
    var acartList = await hiveService.getBoxesTypeList("CartTabel");
    await acartList.forEach((item){
      _total += item.harga*item.qty;
    });
    if (cek==true){
         _total = _total-_oldTotal;
         cek=false;
       _oldTotal= _total;
    }else {
        _oldTotal = _total;
    }
  }
  var U = new NumberFormat("'Rp. '###,###.00", "id_ID"), kupon=0.0;

  @override
  void initState() {
    super.initState();
      hitungBayar();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('on DaftarProduk');
    //Ukuran
    var spesialsize;
    //specialSize
    if (MediaQuery.of(context).size.height>MediaQuery.of(context).size.width){
      spesialsize=MediaQuery.of(context).size.width;
    }else{
      spesialsize=MediaQuery.of(context).size.height;
    }
    return ViewModelBuilder<CartViewModel>.reactive(
    viewModelBuilder: () => CartViewModel(),
    onModelReady: (model) => model.getData(),
    builder: (context, model, child) => Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
          children: [
            background(),
            Container(
              color: Colors.white.withOpacity(0.9),
              width: double.infinity,
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text('Keranjang Belanja',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: spesialsize*0.08,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerRight,
                          child: MaterialButton(
                              onPressed: () {  },
                              child: InkWell(
                                  child: Icon(Icons.delete)))
                      )
                    ],
                  ),

                  SizedBox(
                    height:spesialsize*0.01,
                  ),

                  Expanded(
                    child:
                    ListView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: model.cartList.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context) => CartDetails(
                            cartList: model.cartList[index],
                            )));},
                          child: Container(
                            margin: EdgeInsets.all(2),
                            child: AspectRatio(
                              aspectRatio: 1/0.3,
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                child: Stack(
                                  children: [
                                    CartItem(
                                      index: index,
                                      cart: model.cartList[index],
                                    ),
                                    Positioned(
                                      right: -10,
                                      top: -5,
                                      child: FlatButton(
                                          minWidth: 0.8,
                                          onPressed: (){
                                            setState(() {
                                              showDialog(
                                                  context: context,
                                                  builder: (con) => AlertDialog(
                                                      title: Text('Keranjang'),
                                                      content: Text('Produk ini akan dikeluarkan dari keranjang anda?'),
                                                      actions: [
                                                        MaterialButton(
                                                            child: Text('batal'),
                                                            onPressed: () {
                                                              Navigator.of(context).pop();
                                                            }),
                                                        MaterialButton(
                                                            child: Text('hapus'),
                                                            onPressed: () {
                                                              setState(() {
                                                                cek=true;
                                                                hitungBayar();
                                                                model.cartList.removeAt(index);
                                                                //_totalBelanja = model.cartList.map<int>((m) => m.harga).reduce((a,b )=>a+b);
                                                              });
                                                              Navigator.of(context).pop();
                                                            })
                                                      ]));
                                              var box = Hive.box('CartTabel');
                                              box.deleteAt(index);
                                            });
                                          },
                                          child: Container(
                                              color: Colors.grey,
                                              child: Icon(Icons.delete,))),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),

      bottomNavigationBar:Container(
        color: Colors.white.withOpacity(0.9),
        child: Container(
            width: MediaQuery.of(context).size.width*0.94,
            height: 80,
            decoration: BoxDecoration(
              color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(width: 2, color: Colors.red[900])
            ),
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.only(bottom: 20, left: 10, right: 10),
            child: Row(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Kupon Belanja', textAlign: TextAlign.left,),
                    Text(kupon==0.0?'REGULER':'BYKUPON',style: TextStyle(fontWeight: FontWeight.bold),)
                  ],
                ),
                MaterialButton(
                  minWidth: 5,
                    onPressed: null,
                    child: Icon(Icons.edit)),
                Expanded(
                    child:  InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> PaymentPage()));
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 45,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.grey[300]
                        ),
                        padding: EdgeInsets.all(2),
                        child: Text(_oldTotal==0?'Ayo Belanja!':(_oldTotal==.001?'Harga Nego':U.format(_oldTotal).toString()),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25)),
                      ),
                    )
                )
              ],
            )),
      ),
    ),
    );
  }

  background() {
    return Stack(
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
      ],
    );
  }
}