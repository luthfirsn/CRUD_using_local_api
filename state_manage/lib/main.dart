import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:state_manage/apllication_color.dart';

import 'networking_http.dart';

void main() {
  runApp(MaterialApp(
    home: NetworkingHttpApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ApplicationColor>(
      create: (context) => ApplicationColor(),
      // builder: (context) => ,
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.black26,
            title: Consumer<ApplicationColor>(
              builder: (context, applicationColor, _) => Text(
                "Provider State Management",
                style: TextStyle(color: applicationColor.color),
              ),
            ),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Consumer<ApplicationColor>(
                  builder: (context, applicationColor, _) => AnimatedContainer(
                    margin: EdgeInsets.all(5),
                    width: 100,
                    height: 100,
                    color: applicationColor.color,
                    duration: Duration(milliseconds: 500),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(margin: EdgeInsets.all(5), child: Text("AB")),
                    Consumer<ApplicationColor>(
                      builder: (context, applicationColor, child) => Switch(
                        value: applicationColor.isGreenAccent,
                        onChanged: (newValue) {
                          applicationColor.isGreenAccent = newValue;
                        },
                      ),
                    ),
                    Container(margin: EdgeInsets.all(5), child: Text("GA"))
                  ],
                )
              ],
            ),
          )),
    );
  }
}
