import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:srm_final/widget/model_hive_tips/tips.dart';

class TipsItem extends StatelessWidget {
  final Tips tips;
  const TipsItem({Key key, this.tips}) :super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(tips.judul),
      children: [
        Text(tips.judul, style: TextStyle(fontWeight: FontWeight.bold),),
        Text(tips.body)
      ],
    );
  }

}