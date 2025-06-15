import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class  _DashboardState extends State<Dashboard> {

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text("lol")
      ),
      body: Container(
        padding: EdgeInsets.all(0.0),
        decoration: BoxDecoration(
          color: Colors.grey[200]
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                  "This is a page",
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
            ],
          ),
        ),
      ),
    );
  }
}