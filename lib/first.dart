import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class FirstUI extends StatefulWidget {
  @override
  _FirstUIState createState() => _FirstUIState();
}

class _FirstUIState extends State<FirstUI> with SingleTickerProviderStateMixin {
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
    double width = MediaQuery.of(context).size.width;
    var myDrawer = Container(
      color: Colors.blue,
      child: Column(
        children: [
          Icon(Icons.sd_storage),
          Container(
            width: width,
            height: 40,
            
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
    return Scaffold(
        body: GestureDetector(
      //onHorizontalDragStart: _onDragStart,
      //onHorizontalDragUpdate: _onDragUpdate,
      //onHorizontalDragEnd: _onDragEnd,
      onTap: toggle,
      child: AnimatedBuilder(
        animation: controller,
        builder: (context, _) {
          double slide = width / 2 * (controller.value);
          double scale = 1 - (controller.value * 0.5);
          return Stack(
            children: [
              myDrawer,
              Transform(
                transform: Matrix4.identity()
                  ..scale(scale)
                  ..translate(slide),
                alignment: Alignment.centerRight,
                child: myChild,
              )
            ],
          );
        },
      ),
    ));
  }

  bool _canBeDragged = true;
  double minDragStartEdge = 50, maxDragStartEdge = 300;

  /*

  _onDragStart(DragStartDetails details) {
    bool _isDragFromLeft =
        controller.isDismissed && details.globalPosition.dx < minDragStartEdge;
    bool _isDragFromRight =
        controller.isDismissed && details.globalPosition.dx > maxDragStartEdge;
    _canBeDragged = _isDragFromRight || _isDragFromLeft;
  }

  _onDragUpdate(DragUpdateDetails details) {
    if (_canBeDragged) {
      double delta = details.primaryDelta / maxSlide;
      controller.value += delta;
    }
  }

  _onDragEnd(DragEndDetails details) {
    if (controller.isDismissed || controller.isCompleted) {
      return;
    }
    if (details.velocity.pixelsPerSecond.dx.abs() >= 365.0) {
      double visualVelocity = details.velocity.pixelsPerSecond.dx /
          MediaQuery.of(context).size.width;
      controller.fling(velocity: visualVelocity);
    } else if (controller.value < 0.5) {
      // close();
    } else {
      //open();
    }
  }

  */
}
