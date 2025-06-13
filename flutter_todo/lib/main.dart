import 'package:flutter/material.dart';
import 'widgets/my_custom_text.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("Todo App")),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MyCustomText(text: "no1",color: Colors.red),
                  SizedBox(width: 100),
                  MyCustomText(text: "no2",color : Colors.greenAccent),
                  SizedBox(width: 100),
                  MyCustomText(text: "no3"),
                ],
              ),
              SizedBox(height: 20), // 위아래 간격
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Image.asset('assets/images/1.png', width: 300, height: 200),
                    SizedBox(width: 4),
                    Image.asset('assets/images/2.png', width: 300, height: 200),
                    SizedBox(width: 4),
                    Image.asset('assets/images/3.png', width: 300, height: 200),
                    SizedBox(width: 4),
                    Image.asset('assets/images/4.png', width: 300, height: 200),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}