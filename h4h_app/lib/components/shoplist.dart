import 'package:flutter/material.dart';

Widget shopList() {
    return Column (
      children: [
        shopTile(),
        shopTile(),
        shopTile(),
        shopTile(),
        shopTile(),
        shopTile()
      ],
    );
}

Widget shopTile() {
  return Container(
    margin: EdgeInsets.all(8),
    padding: EdgeInsets.fromLTRB(14,10,14,10),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.1), // light shadow
          blurRadius: 5,
          offset: Offset(0, 3),
        ),
      ],
    ),
    child: Column(
      spacing:10.0,

      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex:1,
              child: Container(
                height: 100,
                width: 98,
                color: Colors.green,
              ),
            ),
            Expanded(
              flex: 2,
              child: Center( // 👈 this centers text within its 2/3 area
                child: SizedBox(
                  width: 180,
                  child: Text(
                    'Centered text here YAY YAY YAYY',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(height: 30, width:150, child: Container(color: Colors.red),),
          ],
        ),
        SizedBox(height: 35, child: Container(color: Colors.purple),),
      ]
    )
  );
}