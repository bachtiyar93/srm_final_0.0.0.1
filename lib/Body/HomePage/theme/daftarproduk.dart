
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'produkdetail.dart';
import 'buildproduk.dart';
import 'data.dart';
import 'theme.dart';

class DaftarProduk extends StatefulWidget {
  @override
  _DaftarProdukState createState() => _DaftarProdukState();
}

class _DaftarProdukState extends State<DaftarProduk> {

  List<Filter> filters = getFilterList();
  Filter selectedFilter;


  @override
  void initState() {
    super.initState();
    setState(() {
      selectedFilter = filters[0];
    });
  }

  @override
  Widget build(BuildContext context) {
    //Ukuran
    var spesialsize;
    //specialSize
    if (MediaQuery.of(context).size.height>MediaQuery.of(context).size.width){
    spesialsize=MediaQuery.of(context).size.width;
    }else{
    spesialsize=MediaQuery.of(context).size.height;
    }
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Container(
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
                  width: spesialsize*0.12,
                  height: spesialsize*0.12,
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
                    size: spesialsize*0.07,
                  )
                ),
              ),

              FutureBuilder<List<Produk>>(
                future: dataProduk(),
                builder: (context, snapshot){
                  if (snapshot.hasData){
                    return Text("Ready "+snapshot.data.length.toString()+" lagi",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: spesialsize*0.04,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  }else {
                    return Padding(
                        padding: EdgeInsets.all(15.0),
                        child: new LinearProgressIndicator(
                          backgroundColor: Colors.grey,
                          valueColor: new AlwaysStoppedAnimation<Color>(
                              Colors.red),
                        )
                    );
                  }
                }
                ),

              SizedBox(
                height:spesialsize*0.01,
              ),

              Expanded(
                child: FutureBuilder<List<Produk>>(
                    future: dataProduk(),
                    builder: (context, snapshot){
                      if (snapshot.hasData) {return
                        GridView.count(
                          physics: BouncingScrollPhysics(),
                          childAspectRatio: 1/1.55,
                          crossAxisCount: 2,
                          crossAxisSpacing: 15,
                          mainAxisSpacing: 15,
                          children: snapshot.data.map((item) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => ProdukDetail(produk: item, context: context)),
                                );
                              },
                              child: buildProduk(item, null, context)
                            );
                          }).toList(),
                        );
                      }else {
                        return Center(
                            child: CircularProgressIndicator(
                              backgroundColor: Colors.grey,
                              valueColor: new AlwaysStoppedAnimation<Color>(
                                  Colors.red),
                            )
                        );
                      }
                    }
                ),


                // GridView.count(
                //   physics: BouncingScrollPhysics(),
                //   childAspectRatio: 1/1.55,
                //   crossAxisCount: 2,
                //   crossAxisSpacing: 15,
                //   mainAxisSpacing: 15,
                //   children: dataProduk().map((item) {
                //     return GestureDetector(
                //       onTap: () {
                //         Navigator.push(
                //           context,
                //           MaterialPageRoute(builder: (context) => ProdukDetail(produk: item, context: context)),
                //         );
                //       },
                //       child: buildProduk(item, null, context)
                //     );
                //   }).toList(),
                // ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 80,
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Row(
          children: [
            buildFilterIcon(),
            Row(
              children: buildFilters(),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildFilterIcon(){
    return Container(
      width: 50,
      height: 50,
      margin: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: LightColors.warnaJudul,
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      child: Center(
        child: Icon(
          Icons.filter_list,
          color: Colors.white,
          size: 24,
        ),
      ),
    );
  }

  List<Widget> buildFilters(){
    List<Widget> list = [];
    for (var i = 0; i < filters.length; i++) {
      list.add(buildFilter(filters[i]));
    }
    return list;
  }

  Widget buildFilter(Filter filter){
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedFilter = filter;
        });
      },
      child: Padding(
        padding: EdgeInsets.only(right: 16),
        child: Text(
          filter.name,
          style: TextStyle(
            color: selectedFilter == filter ? LightColors.warnaJudul : Colors.grey[300],
            fontSize: 16,
            fontWeight: selectedFilter == filter ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
