import 'package:adobe_xd/adobe_xd.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PaymentPage extends StatefulWidget {
  @override
  _PaymentPageState  createState()=> _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          Container(
            margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
            width: double.infinity,
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                      width: 45,
                      height: 45,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(15),
                        ),
                        border: Border.all(
                          color: Colors.grey[300],
                          width: 1,
                        ),
                      ),
                      child: Icon(
                        Icons.keyboard_arrow_left,
                        color: Colors.black,
                        size: 28,
                      )
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                SingleChildScrollView(
                  child: Column(
                      children:[
                        GestureDetector(
                            onTap: (){

                            },
                            child: PaymentCard('BANK BRI','Transfer to Bank Rakyat Indonesia','https://cdn3.iconfinder.com/data/icons/banks-in-indonesia-logo-badge/100/BRI-512.png')),
                        GestureDetector(
                            onTap: (){

                            },
                            child:PaymentCard('BANK BCA','Transfer to Bank Central Asia','https://cdn3.iconfinder.com/data/icons/banks-in-indonesia-logo-badge/100/BCA-512.png')),
                        GestureDetector(
                            onTap: (){


                            },
                            child:PaymentCard('MANDIRI','Transfer to Bank Mandiri','https://cdn3.iconfinder.com/data/icons/banks-in-indonesia-logo-badge/100/Mandiri-512.png')),
                        GestureDetector(
                            onTap: (){

                            },
                            child:PaymentCard('GOPAY','Pay with Go-pay (Gojek)','https://img.tek.id/img/library/library-1/images/tek/goapy.jpg')),
                      ]
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
Widget PaymentCard(String nama_produk, String text_penjelasan, String image) {
  return Padding(
    padding: EdgeInsets.only(top: 16, right: 16, left: 16),
    child: Container(
      decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(image),
            fit: BoxFit.cover,),
        color: Colors.grey,
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      padding: EdgeInsets.all(24),
      height: 100,)
      // child: Row(
      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //   children: [
      //
      //     Column(
      //       crossAxisAlignment: CrossAxisAlignment.start,
      //       mainAxisAlignment: MainAxisAlignment.center,
      //       children: [
      //
      //         Text(
      //           nama_produk,
      //           style: TextStyle(
      //             fontSize: 22,
      //             fontWeight: FontWeight.bold,
      //           ),
      //         ),
      //
      //         Text(
      //           text_penjelasan,
      //           style: TextStyle(
      //             fontSize: 16,
      //           ),
      //         ),
      //
      //       ],
      //     ),
      //
      //     Container(
      //       decoration: BoxDecoration(
      //         color: Colors.white,
      //         borderRadius: BorderRadius.all(
      //           Radius.circular(15),
      //         ),
      //       ),
      //       height: 50,
      //       width: 50,
      //       child: Center(
      //         child: Icon(
      //           Icons.arrow_forward_ios,
      //           color: Colors.red,
      //         ),
      //       ),
      //     ),
      //
      //   ],
      // ),
    //),
  );
}