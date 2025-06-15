import 'package:flutter/material.dart';
import 'package:h4h_app/components/appbar.dart';
import 'package:h4h_app/components/itemscroll.dart';
import 'package:h4h_app/components/shoplist.dart';
import 'package:h4h_app/components/pageview.dart'; // este ya lo tienes
import 'package:h4h_app/components/productsHeader.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 242, 242, 242),
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              itemListView(),

              ImageSlider(),

              const SizedBox(height: 20),

              productsHeader(),

              const SizedBox(height: 6),
              shopList(),
            ],
          ),
        ),
      ),
    );
  }
}
