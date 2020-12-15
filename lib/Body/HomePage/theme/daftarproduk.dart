
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:srm_final/widget/slidehorizon/produk_item.dart';
import 'data.dart';

class DaftarProduk extends StatefulWidget {
  DaftarProduk(List produkList, {Key key}): this.produkList=produkList ?? [];
  final List<dynamic> produkList;

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
    debugPrint('on DaftarProduk');
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
              Text("Ready "+widget.produkList.length.toString()+" lagi",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: spesialsize*0.04,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

              SizedBox(
                height:spesialsize*0.01,
              ),

              Expanded(
                child:
                GridView.builder(
                  gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 1/1.55,
                      crossAxisCount: 2,
                      crossAxisSpacing: MediaQuery.of(context).size.height*0.01,
                      mainAxisSpacing:MediaQuery.of(context).size.height*0.01),
                  physics: BouncingScrollPhysics(),
                  itemCount: widget.produkList.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.all(2),
                      child: AspectRatio(
                        aspectRatio: 1/1.7,
                        child: ProdukItem(
                          produkList: widget.produkList[index],
                        ),
                      ),
                    );
                  },
                ),
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
        color: Colors.red[900],
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
            color: selectedFilter == filter ? Colors.red[900] : Colors.grey[300],
            fontSize: 16,
            fontWeight: selectedFilter == filter ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
