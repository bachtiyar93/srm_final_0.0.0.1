import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:srm_final/Body/cart/cart_item.dart';
import 'package:srm_final/widget/model_hive/cart_view_model.dart';
import 'package:srm_final/widget/model_hive/hive_service.dart';
import 'package:srm_final/widget/model_hive/locator.dart';
import 'package:stacked/stacked.dart';



class DaftarCart extends StatefulWidget {

  @override
  _DaftarCartState createState() => _DaftarCartState();
}

class _DaftarCartState extends State<DaftarCart> {
  //_totalBelanja = model.cartList.map<int>((m) => m.harga).reduce((a,b )=>a+b);
  int _total =0;
  int _oldTotal=0;
  bool cek = false;
   hitungBayar(bool) async {
    final HiveService hiveService = locator<HiveService>();
    var acartList = await hiveService.getBoxesTypeList("CartTabel");
    acartList.forEach((item){
      _total += item.harga;
    });
    if (cek==true){
         _total = _total-_oldTotal;
         cek=false;
       _oldTotal= _total;
    }else {
        _oldTotal = _total;
    }
  }


  @override
  void initState() {
    super.initState();
      hitungBayar(cek);
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
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Stack(
          children: [
            Container(
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
                        return Container(
                          margin: EdgeInsets.all(2),
                          child: AspectRatio(
                            aspectRatio: 1/0.3,
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              child: Row(
                                children: [
                                  CartItem(
                                    index: index,
                                    cart: model.cartList[index],
                                  ),
                                  FlatButton(
                                      minWidth: 5,
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
                                                            hitungBayar(cek=true);
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
                                      child: Icon(Icons.delete)),
                                ],
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
      ),
      bottomNavigationBar:Container(
          width: MediaQuery.of(context).size.width*0.94,
          height: 80,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(width: 2, color: Colors.red)
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
                  Text('REGULER',style: TextStyle(fontWeight: FontWeight.bold),)
                ],
              ),
              MaterialButton(
                minWidth: 5,
                  onPressed: null,
                  child: Icon(Icons.edit)),
              Expanded(
                  child:  Container(
                    alignment: Alignment.center,
                    height: 45,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.grey[300]
                    ),
                    padding: EdgeInsets.all(2),
                    child: Text(_oldTotal==0?'Ayo Belanja!':_oldTotal.toString(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25)),
                  )
              )
            ],
          )),
    ),
    );
  }
}