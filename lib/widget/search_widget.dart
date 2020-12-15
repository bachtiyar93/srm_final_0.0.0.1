import 'dart:math';

import 'package:adobe_xd/adobe_xd.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:srm_final/widget/produk_detail/details.dart';

class Search extends SearchDelegate<String> {
  final List<dynamic> produkList;

  Search({this.produkList});
  List<dynamic> filterSearch = [];
  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
        tooltip: 'Clear',
        icon: const Icon((Icons.clear)),
        onPressed: () {
          query = '';
          showSuggestions(context);
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow, progress: transitionAnimation),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Text(query);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    var _history = [];
    var _images =[];
    for (int i = 0; i <= 5; i++) {
      int i = Random().nextInt(produkList.length);
      _history.add(produkList[i].produk+' '+produkList[i].seri);
      _images.add(produkList[i].images[0]);
    }
    List<String> strList = [];
    List<String> img =[];
    for (var i in produkList) {
      strList.add((i.produk+' '+i.seri).toString());
      img.add(i.images[0].toString());
    }
    final suggestions = query.isEmpty
        ? _history
        : strList
        .where((element) =>
        element.toLowerCase().contains(query.toLowerCase()))
        .toList();
    final suggestions2 = query.isEmpty
    ? _images
        : img;
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
        Container(
          color: Colors.black.withOpacity(0.9),
          child: ListView.builder(
              itemCount: suggestions.length,
              itemBuilder: (BuildContext context, int index) {
                return new ListTile(
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(40),
                    child: CircleAvatar(
                        backgroundColor: Colors.orange,
                        child: Container(
                          height: 40,
                            child: CachedNetworkImage(imageUrl:suggestions2[index], fit: BoxFit.cover,))
                    ),
                  ),
                  title: Text(
                    suggestions[index],
                    style: GoogleFonts.lato(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w300),
                  ),
                  onTap: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProdukDetails(
                              produkList: returnAnime(suggestions[index]),
                            )));
                  },
                );
              }),
        ),
      ],
    );
  }

  returnAnime(String i) {
    for (var i in produkList) {
        return i;
  }
}
}
