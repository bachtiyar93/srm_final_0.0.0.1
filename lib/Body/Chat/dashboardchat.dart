import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';


class DashboardChat extends StatefulWidget {
  @override
  _BodyChatState createState() => _BodyChatState();
}
class _BodyChatState extends State<DashboardChat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
          ],
        ),
      ),
    );
  }
   Future getData() async{
    var url = 'https://sweetroommedan.com/app/pesan/get.php';
    http.Response response = await http.get(url);
    var data = jsonDecode(response.body);
    print(data.toString());
  }

  @override
  void initState() {
    getData;
  }

}
