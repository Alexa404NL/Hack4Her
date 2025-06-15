import 'package:flutter/material.dart';

Widget itemListView() {
  return SizedBox(
    height:180,
    child: ListView (
      padding: EdgeInsets.fromLTRB(6,0,6,0),
      scrollDirection: Axis.horizontal,
      children: [
        itemTile("Pedido Fácil"),
        itemTile("Refrescos"),
        itemTile("Agua"),
        itemTile("Bebidas de fruta"),
        itemTile("Agua mineral")
      ],
    ),
  );
}

Widget itemTile(String titlet) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: SizedBox(
      width: 95,
      child: Center(
        child: Column(
          spacing: 11,
          children: [
            Container(
              width: 95,
              height: 95,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [BoxShadow(
                    color: const Color.fromARGB(255, 58, 58, 58).withValues(alpha: 0.1), // light shadow
                    blurRadius: 5,
                    offset: Offset(0, 3),
                )],
              ),
              child: Center(child: Text("[image]", softWrap: true)),
            ),
            Text(titlet,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Color(0xff4c4b4a),
                ),
            ),
          ],
        ),
      ),
    ),
  );
}