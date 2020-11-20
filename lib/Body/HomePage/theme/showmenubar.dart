//Mulai ke Menu
import 'package:flutter/material.dart';

ShowMenuBar(BuildContext context) {
  final flatButtonColor = Colors.deepPurple;
  print('Panggi Faktur');
  showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height*0.3,
          padding: EdgeInsets.all(10.0),
          child: ListView(
            children: <Widget>[
              Text(
                'What do you need?',
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height*0.01,
              ),
              FlatButton(
                color: Colors.yellow,
                onPressed: () {
                  return showDialog<void>(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Option'),
                        content: Container(
                            height: MediaQuery.of(context).size.height*0.3,
                            width: MediaQuery.of(context).size.width*0.8,
                            child: Center(
                              child: Container(
                                child: Wrap(
                                  children: <Widget>[
                                    FlatButton(
                                      color: Colors.yellow,
                                      onPressed: () {
                                        // Navigator.of(context).push(
                                        //     MaterialPageRoute(builder: (context) => SpreiCalc()));

                                      },
                                      shape: new RoundedRectangleBorder(
                                        borderRadius: new BorderRadius.circular(10.0),
                                      ),
                                      textColor: flatButtonColor,
                                      child: Container(
                                        width: MediaQuery.of(context).size.width*0.7,
                                        child: Text('Standart Size (Recomended)',
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                    FlatButton(
                                      color: Colors.yellow,
                                      onPressed: () {
                                        // Navigator.of(context).push(
                                        //     MaterialPageRoute(builder: (context) => spreiAdvanced()));

                                      },
                                      shape: new RoundedRectangleBorder(
                                        borderRadius: new BorderRadius.circular(10.0),
                                      ),
                                      textColor: flatButtonColor,
                                      child: Container(
                                        width: MediaQuery.of(context).size.width*0.7,
                                        child: Text('Custome Advanced',
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                        ),
                        actions: <Widget>[
                          FlatButton(
                            textColor: flatButtonColor,
                            child: Text('Cancel',),
                            onPressed: () {
                              Navigator.of(context).pop(true);
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
                shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(10.0),
                ),
                textColor: flatButtonColor,
                child: Text('Sprei Set (Complete) Recomended',
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height*0.01,
              ),
              FlatButton(
                color: Colors.yellow,
                onPressed:(){
                  // Navigator.of(context).push(
                  //     MaterialPageRoute(builder: (context) => BantalCalc()));
                } ,
//                  onPressed: () {
//                    return showDialog<void>(
//                      context: context,
//                      builder: (BuildContext context) {
//                        return AlertDialog(
//                          title: Text('Option'),
//                          content: Container(
//                              height: MediaQuery.of(context).size.height*0.17,
//                              width: MediaQuery.of(context).size.width*0.8,
//                              child: Center(
//                                child: Container(
//                                  child: Column(
//                                    children: <Widget>[
//                                      FlatButton(
//                                        color: Colors.yellow,
//                                        onPressed: () {
//                                          return showDialog<void>(
//                                            context: context,
//                                            builder: (BuildContext context) {
//                                              return AlertDialog(
//                                                title: Text("Oops!"),
//                                                content: Text("Coming Soon"),
//                                                actions: <Widget>[
//                                                  FlatButton(onPressed: (){
//                                                    Navigator.of(context).pop(true);
//                                                  }, child: Text("Ok"))
//                                                ],
//                                              );
//                                            },
//                                          );
//                                        },
//                                        shape: new RoundedRectangleBorder(
//                                          borderRadius: new BorderRadius.circular(10.0),
//                                        ),
//                                        textColor: flatButtonColor,
//                                        child: Container(
//                                          width: MediaQuery.of(context).size.width*0.7,
//                                          child: Text('Custome Advanced',
//                                            textAlign: TextAlign.center,
//                                          ),
//                                        ),
//                                      ),
//                                      FlatButton(
//                                        color: Colors.yellow,
//                                        onPressed: () {
//                                          return showDialog<void>(
//                                            context: context,
//                                            builder: (BuildContext context) {
//                                              return AlertDialog(
//                                                title: Text("Oops!"),
//                                                content: Text("Coming Soon"),
//                                                actions: <Widget>[
//                                                  FlatButton(onPressed: (){
//                                                    Navigator.of(context).pop(true);
//                                                  }, child: Text("Ok"))
//                                                ],
//                                              );
//                                            },
//                                          );
//                                        },
//                                        shape: new RoundedRectangleBorder(
//                                          borderRadius: new BorderRadius.circular(10.0),
//                                        ),
//                                        textColor: flatButtonColor,
//                                        child: Container(
//                                          width: MediaQuery.of(context).size.width*0.7,
//                                          child: Text('Standart Size',
//                                            textAlign: TextAlign.center,
//                                          ),
//                                        ),
//                                      ),
//                                    ],
//                                  ),
//                                ),
//                              )
//                          ),
//                          actions: <Widget>[
//                            FlatButton(
//                              textColor: flatButtonColor,
//                              child: Text('Cancel',),
//                              onPressed: () {
//                                Navigator.of(context).pop(true);
//                              },
//                            ),
//                          ],
//                        );
//                      },
//                    );
//                  },
                shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(10.0),
                ),
                textColor: flatButtonColor,
                child: Text('Pillow & Bolster Only',
                ),
              ),
            ],
          ),
        );
      });
}