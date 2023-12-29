import 'package:colorman/widgets/cards/ModeCard.dart';
import 'package:colorman/widgets/color/ColorHomePage.dart';
import 'package:flutter/material.dart';

import 'widgets/math/CountingWidget.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<HomePage> {
  final List<Mode> modes = [
    Mode('Color Man', Icons.access_alarm, Colors.blue),
    Mode('Math King', Icons.camera_alt, Colors.green),
  ];

  int state = 0;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ColorMan',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Game Mode'),
        ),
        body: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 10.0,
          ),
          itemCount: modes.length,
          itemBuilder: (BuildContext context, int index) {
            return ModeCard(
              mode: modes[index],
              onClick: () {
                var materialPageRoute;
                if (index == 0) {
                  materialPageRoute = MaterialPageRoute(
                      builder: (context) => ColorHomePage(title: "Color Man"));
                } else {
                  materialPageRoute = MaterialPageRoute(
                      builder: (context) => CountingWidget());
                }
                Navigator.push(
                  context,
                  materialPageRoute,
                );
              },
            );
          },
        ),
      ),
    );
  }
}
