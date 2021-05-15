import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class FourthUI extends StatefulWidget {
  @override
  _FourthUIState createState() => _FourthUIState();
}

class _FourthUIState extends State<FourthUI>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        children: [
          Positioned(
            top: 100,
            left: 100,
            child: AnimatedBuilder(
              animation: controller,
              builder: (context, _) {
                double x = controller.value + 0.1;
                return Transform(
                  child: NewPage(),
                  transform: Matrix4.identity()..scale(x)
                  //..rotateZ(x * 3.14)
                  ,
                );
              },
            ),
          ),
          Positioned(
            left: 10,
            bottom: 20,
            child: AnimatedBuilder(
              animation: controller,
              builder: (context, _) {
                double x = controller.value * size.width;
                return Transform(
                  child: CircleAvatar(
                    radius: 20,
                  ),
                  transform: Matrix4.identity()..translate(x, -x)
                  //..rotateZ(x * 3.14)
                  ,
                );
              },
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.star_outline),
        onPressed: () {
          controller.isDismissed ? controller.forward() : controller.reverse();
        },
      ),
    );
  }
}

class NewPage extends StatefulWidget {
  @override
  _NewPageState createState() => _NewPageState();
}

class _NewPageState extends State<NewPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: 200,
      decoration: BoxDecoration(
          color: Colors.cyan,
          border: Border.all(color: Colors.red, width: 5),
          borderRadius: BorderRadius.circular(20)),
      child: Center(
        child: Icon(
          Icons.airplanemode_active,
          size: 100,
          color: Colors.white,
        ),
      ),
    );
  }
}
