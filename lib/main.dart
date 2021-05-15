import 'package:dino_game/ball_game.dart';
import 'package:dino_game/first.dart';
import 'package:dino_game/fourthUI.dart';
import 'package:dino_game/secondUI.dart';
import 'package:dino_game/thirdUI.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int current = 1;
  double scale = 1;
  double rotate = 12;
  double x = 12, y = 32;
  double translate = 120;
  // AnimationController controllar;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // controllar = AnimationController(
    //   vsync: this, duration: Duration(milliseconds: 1000));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Text('-$current-'),
          IconButton(
              icon: Text('1'),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => FirstUI()));
              }),
          IconButton(
              icon: Text('2'),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => SecondUI()));
              }),
          IconButton(
              icon: Text('3'),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => ThirdUI()));
              }),
          IconButton(
              icon: Text('4'),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => FourthUI()));
              }),
          IconButton(
              icon: Text('5'),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => BallGame()));
              }),
        ],
      ),
      body: Center(child: getTransform(current)),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          FloatingActionButton(
            heroTag: null,
            onPressed: () {
              switch (current) {
                case 1:
                  x += 5;
                  y += 5;
                  break;
                case 2:
                  scale += 0.1;
                  break;
                case 3:
                  rotate += 10;
                  break;
                case 4:
                  translate += 10;
                  break;
              }
              setState(() {});
            },
            child: Icon(Icons.add),
          ),
          FloatingActionButton(
              heroTag: null,
              onPressed: () {
                current++;
                // controllar.value = 0;
                if (current == 5) current = 1;
                setState(() {});
              },
              child: Icon(Icons.compare_arrows)),
          FloatingActionButton(
              heroTag: null,
              onPressed: () {
                switch (current) {
                  case 1:
                    x -= 5;
                    y -= 5;
                    break;
                  case 2:
                    scale -= 0.1;
                    break;
                  case 3:
                    rotate -= 10;
                    break;
                  case 4:
                    translate -= 10;
                    break;
                }
                setState(() {});
              },
              child: Icon(
                Icons.remove,
              )),
        ],
      ),
    );
  }

  Widget getTransform(int x) {
    Widget first = Transform.translate(
      offset: Offset(this.x, y),
      child: childWidget(),
    );

    Widget second = Transform.scale(
      scale: scale,
      child: childWidget(),
    );

    Widget third = Transform.rotate(
      angle: rotate,
      child: childWidget(),
    );

    Widget fourth = Transform(
      transform: Matrix4.identity()..translate(translate),
      child: childWidget(),
    );

    if (x == 1)
      return first;
    else if (x == 2)
      return second;
    else if (x == 3) return third;
    return fourth;
  }

  Widget childWidget() {
    return Container(
      decoration: BoxDecoration(
          color: Colors.green[900],
          border: Border.all(color: Colors.red),
          borderRadius: BorderRadius.circular(20)),
      height: 300,
      width: 200,
    );
  }
}

//stack
//Transoform
