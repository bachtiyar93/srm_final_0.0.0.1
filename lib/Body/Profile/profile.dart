
import 'package:flutter/material.dart';
import 'package:adobe_xd/pinned.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage(
      this.produkReadydata,
      this.appNewsdata,
      this.iddata,
      this.namadata,
      this.phonedata,
      this.alamatdata,
      this.emaildata,
      this.passworddata,
      this.tgldaftardata,
      this.statusdata,
      this.updatedata, this.signOut);
  final produkReadydata,appNewsdata, iddata,namadata,phonedata,alamatdata,emaildata,passworddata,tgldaftardata,statusdata,updatedata;
  final VoidCallback signOut;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<ProfilePage> {
  signOut() {
    setState(() {
      widget.signOut();
    });
  }
  PageController pageController;
  double viewportFraction = 0.8;
  double pageOffset = 0;
  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: 0, viewportFraction: viewportFraction)
      ..addListener(() {
        setState(() {
          pageOffset = pageController.page;
        });
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: stack()
        // This trailing comma makes auto-formatting nicer for build methods.
        );
  }

  Widget profileView() {
          return Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(30, 50, 30, 30),
                child: Text(
                  'Profile Detail',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 50),
                child: Stack(
                  children: <Widget>[
                    CircleAvatar(
                      radius: 70,
                      child: ClipOval(
                        child: Image.network(
                          'https://www.genpi.co/timthumb.php?src=http://fs.genpi.co/uploads/data/images/idaman(1).png&w=820&a=br&zc=1',
                          height: 150,
                          width: 150,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                        bottom: 1,
                        right: 1,
                        child: Container(
                          height: 40,
                          width: 40,
                          child: Icon(
                            Icons.add_a_photo,
                            color: Colors.white,
                          ),
                          decoration: BoxDecoration(
                              color: Colors.deepOrange,
                              borderRadius: BorderRadius.all(Radius.circular(
                                  20))),
                        ))
                  ],
                ),
              ),
              Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30)),
                        gradient: LinearGradient(
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                            colors: [
                              Color.fromRGBO(40, 10, 10, 0.8),
                              Colors.red[900].withOpacity(0.8),
                              Colors.redAccent.withOpacity(0.8)
                            ])),
                    child: ListView(
                      children: [
                        Container(
                          height: 400,
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    20, 25, 20, 4),
                                child: Container(
                                  height: 60,
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              'Name',
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  color: Colors.white70,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          Expanded(
                                            child: Text(widget.namadata,
                                                textAlign: TextAlign.right,
                                                style: TextStyle(
                                                    color: Colors.white70)),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20)),
                                      border:
                                      Border.all(
                                          width: 1.0, color: Colors.white70)),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    20, 5, 20, 4),
                                child: Container(
                                  height: 60,
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              'Phone',
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  color: Colors.white70,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          Expanded(
                                            child: Text(widget.phonedata,
                                                textAlign: TextAlign.right,
                                                style: TextStyle(
                                                    color: Colors.white70)),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20)),
                                      border:
                                      Border.all(
                                          width: 1.0, color: Colors.white70)),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    20, 5, 20, 4),
                                child: Container(
                                  height: 60,
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              'Email',
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  color: Colors.white70,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          Expanded(
                                            child: Text(widget.emaildata,
                                                textAlign: TextAlign.right,
                                                style: TextStyle(
                                                    color: Colors.white70)),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20)),
                                      border:
                                      Border.all(
                                          width: 1.0, color: Colors.white70)),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    20, 5, 20, 4),
                                child: Container(
                                  height: 60,
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              'Status',
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  color: Colors.white70,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          Expanded(
                                            child: Text(widget.statusdata=="0" ? "reguler":(widget.statusdata=="1" ? "reseller":"diblokir"),
                                                textAlign: TextAlign.right,
                                                style: TextStyle(
                                                    color: Colors.white70)),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20)),
                                      border:
                                      Border.all(
                                          width: 1.0, color: Colors.white70)),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    20, 5, 20, 4),
                                child: Container(
                                  height: 60,
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              'Alamat',
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  color: Colors.white70,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          Expanded(
                                            child: Text(
                                                widget.alamatdata,
                                                textAlign: TextAlign.right,
                                                style: TextStyle(
                                                    color: Colors.white70)),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20)),
                                      border:
                                      Border.all(
                                          width: 1.0, color: Colors.white70)),
                                ),
                              ),
                              Expanded(
                                child: Align(
                                  alignment: Alignment.bottomRight,
                                  child: Container(
                                    width: 230,
                                    height: 50,
                                    child: Align(
                                        child: Container(
                                          margin: EdgeInsets.fromLTRB(
                                              0, 0, 10, 10),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment
                                                .end,
                                            children: [
                                              Icon(Icons.settings),
                                              Row(
                                                children: [
                                                  Icon(Icons.edit),
                                                  Text('Edit Profile',
                                                      style: TextStyle(
                                                          fontSize: 20)),
                                                ],
                                              ),
                                              SizedBox(width: 10),
                                              TextButton(
                                                onPressed: signOut,
                                                child: Row(
                                                  children: [
                                                    Icon(Icons.exit_to_app),
                                                    Text('Logout',
                                                        style: TextStyle(
                                                            fontSize: 20)),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        )),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(30),
                                        )),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ))
            ],
          );
        }

  stack() {
    return Stack(
      children: <Widget>[
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
        profileView()
      ],
    );
  }
}
