import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:math' as math;

///3D rotating

class SecondUI extends StatefulWidget {
  @override
  _SecondUIState createState() => _SecondUIState();
}

class _SecondUIState extends State<SecondUI>
    with SingleTickerProviderStateMixin {
  double maxSlide = 225;

  AnimationController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    //maxSlide = MediaQuery.of(context).size.width / 2;
  }

  void toggle() =>
      controller.isDismissed ? controller.forward() : controller.reverse();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    double dWidth = 3 * width / 4;
    var myDrawer = Container(
      color: Colors.yellow,
      height: height,
      width: dWidth,
      child: Column(
        children: [
          Container(
            height: 80,
            width: dWidth,
            color: Colors.blue,
          ),
          Icon(Icons.sd_storage),
          Container(
            width: dWidth,
            height: 40,
            color: Colors.black,
          )
        ],
      ),
    );
    var myChild = Scaffold(
      appBar: AppBar(title: Text('Hii')),
      body: Center(
        child: Icon(Icons.ac_unit),
      ),
    );
    return Container(
      color: Colors.grey,
      child: GestureDetector(
        onTap: toggle,
        child: AnimatedBuilder(
          animation: controller,
          builder: (context, _) {
            double angle = (-math.pi / 2 * controller.value);
            double angle2 = (math.pi / 2 * (1 - controller.value));
            double maxSlide = width * 3 / 4;
            return Stack(
              children: [
                Transform.translate(
                  offset: Offset(maxSlide * (controller.value - 1), 0),
                  child: Transform(
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, 0.001)
                      ..rotateY(angle2),
                    alignment: Alignment.centerRight,
                    child: myDrawer,
                  ),
                ),
                Transform.translate(
                  offset: Offset(maxSlide * controller.value, 0),
                  child: Transform(
                    transform: Matrix4.identity()
                      //..translate(slideD)
                      //..rotateX(angle)
                      ..setEntry(3, 2, 0.001)
                      ..rotateY(angle),
                    alignment: Alignment.centerLeft,
                    child: myChild,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  bool _canBeDragged = true;
  double minDragStartEdge = 50, maxDragStartEdge = 300;
}
