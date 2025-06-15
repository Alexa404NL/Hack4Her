import 'package:flutter/material.dart';
import 'package:h4h_app/components/itemscroll.dart';
import 'package:h4h_app/components/shoplist.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class  _DashboardState extends State<Dashboard> {

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text("lol")
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                  "This is a page",
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                itemListView(),
                shopList()
            ],
          ),
        ),
      ),
    );
  }
}