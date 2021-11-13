import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:makr_shakr_app/model/facts_response.dart';

class TileDetail extends StatelessWidget {
  Datum dataDetail;
   TileDetail({Key key, @required this.dataDetail}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Padding(
          padding: EdgeInsets.only(left: 30.0, right: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(child: Image.network(dataDetail.img,fit: BoxFit.scaleDown,)),
              Expanded(
                child: Text(
                    dataDetail.fact,
                  textAlign: TextAlign.center,
                  maxLines: 10,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
