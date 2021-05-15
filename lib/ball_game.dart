import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class BallGame extends StatefulWidget {
  @override
  _BallGameState createState() => _BallGameState();
}

class _BallGameState extends State<BallGame> with TickerProviderStateMixin {
  AnimationController _controller;
  AnimationController _ss;
  int _left = 1;
  double _gap;
  int _waitTime = 100;
  double ballPosX = 50, ballPosY = 50;
  double _ballSpeed = 1;
  bool _goingUp = false;
  bool _goingLeft = false;
  int _score = 0;

  int _stopState = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(hours: 5));
    _ss = AnimationController(
        vsync: this, duration: Duration(milliseconds: _waitTime));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    _gap = (size.width - 170) / 3;
    return Scaffold(
      backgroundColor: Colors.green[900],
      body: Stack(
        children: [
          Positioned(
            left: 0,
            top: 0,
            child: Container(
              height: 80,
              padding: EdgeInsets.only(top: 10),
              width: size.width,
              child: Row(
                children: [
                  IconButton(
                      icon: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                        //_controller.forward();
                        //if(_controller.)
                      }),
                  SizedBox(
                    width: 30,
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 80,
            left: 10,
            child: Container(
              height: size.height - 180,
              width: size.width - 20,
              color: Colors.black,
            ),
          ),
          Positioned(
            bottom: 90,
            left: 10,
            child: Container(
              height: 10,
              width: size.width - 20,
              color: Colors.red,
            ),
          ),
          //ball
          Positioned(
            left: 10,
            top: 80,
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, _) {
                if (_stopState > 10) {
                  _controller.value = 1;
                  _isStart = false;
                  _stopState = 0;
                  _controller.value = 0;
                }

                if (ballPosX > size.width - 40) _goingLeft = true;
                if (ballPosX < 0) _goingLeft = false;

                if (ballPosY > size.height - 220) {
                  double le = _left * _gap;
                  if (ballPosX >= le && ballPosX <= le + 130) {
                    _score++;
                    if (_score % 5 == 0) _ballSpeed++;
                    _goingUp = true;
                    // setState(() {});
                  }
                  //print(ballPosX);

                  else {
                    _stopState++;
                  }
                }

                if (ballPosY < 0) _goingUp = false;

                if (_goingLeft)
                  ballPosX -= _ballSpeed;
                else
                  ballPosX += _ballSpeed;

                if (_goingUp)
                  ballPosY -= _ballSpeed;
                else
                  ballPosY += _ballSpeed;

                return Transform(
                  child: CircleAvatar(
                    radius: 10,
                    backgroundColor: Colors.blue,
                  ),
                  transform: Matrix4.identity()..translate(ballPosX, ballPosY),
                );
              },
            ),
          ),

          //batt
          Positioned(
            bottom: 100,
            left: 10,
            child: AnimatedBuilder(
              animation: _ss,
              builder: (context, _) {
                double xxx = _left * _gap + _gap * _ss.value * isForward;
                return Transform(
                  child: Container(
                    height: 20,
                    width: 150,
                    decoration: BoxDecoration(
                        color: Colors.blueGrey,
                        borderRadius: BorderRadius.circular(20)),
                  ),
                  transform: Matrix4.identity()..translate(xxx),
                );
              },
            ),
          ),

          Positioned(
            bottom: 0,
            left: 0,
            child: Container(
              width: size.width,
              height: 100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    child: Container(
                      height: 100,
                      width: 150,
                      child: Center(
                        child: Icon(
                          Icons.arrow_left,
                          size: 100,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    onTap: () async {
                      isForward = -1;
                      if (!_lastperforming && _left > 0) {
                        _lastperforming = true;
                        _ss.forward();
                        await Future.delayed(
                            Duration(milliseconds: _waitTime + 10));
                        _ss.value = 0;
                        _left--;
                        _lastperforming = false;
                      }
                    },
                  ),
                  if (!_isStart)
                    IconButton(
                        icon: Icon(Icons.play_arrow,
                            color: Colors.white, size: 40),
                        onPressed: () {
                          if (_isStart)
                            _ballSpeed++;
                          else {
                            _controller.forward();
                            ballPosX = 50;
                            ballPosY = 50;
                            _score = 0;
                            _ballSpeed = 2;
                            _isStart = true;
                          }
                        }),
                  GestureDetector(
                    child: Container(
                      height: 100,
                      width: 150,
                      //color: Colors.green[800],
                      child: Center(
                          child: Icon(
                        Icons.arrow_right,
                        size: 100,
                        color: Colors.white,
                      )),
                    ),
                    onTap: () async {
                      isForward = 1;
                      if (!_lastperforming && _left < 3) {
                        _lastperforming = true;
                        _ss.forward();
                        await Future.delayed(
                            Duration(milliseconds: _waitTime + 10));
                        _ss.value = 0;
                        _left++;
                        _lastperforming = false;
                      }
                    },
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  bool _isStart = false;

  bool _lastperforming = false;

  int isForward = 1;
}
