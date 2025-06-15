import 'package:flutter/material.dart';

Widget itemListView() {
  return SizedBox(
    height:180,
    child: ListView (
      padding: EdgeInsets.fromLTRB(6,0,6,0),
      scrollDirection: Axis.horizontal,
      children: [
        itemTile("Item 1"),
        itemTile("Item 2"),
        itemTile("Item 3"),
        itemTile("Item 4"),
        itemTile("Item 5")
      ],
    ),
  );
}

Widget itemTile(String titlet) {
  return Center(
    child: Column(
      children: [
        Container(
          width: 118,
          height: 118,
          margin: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15.0),
            boxShadow: [BoxShadow(
                color: Colors.black.withValues(alpha: 0.1), // light shadow
                blurRadius: 5,
                offset: Offset(0, 3),
            )],
          ),
          child: Center(child: Text("[image]")),
        ),
        Text(titlet,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18
          ),
        ),
      ],
    ),
  );
}