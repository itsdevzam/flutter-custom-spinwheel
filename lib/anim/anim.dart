import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

class anim extends StatefulWidget {
  const anim({super.key});

  @override
  State<anim> createState() => _animState();
}

class _animState extends State<anim> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool isClick = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GestureDetector(
          onTap: () {
            isClick?_controller.forward():_controller.reverse();
            isClick = !isClick;
          },
          child: Transform.rotate(
            angle: pi*_animation.value,
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(colors: [
                  Colors.lime,
                  Colors.blueAccent
                ],begin: Alignment.centerLeft,end: Alignment.centerRight)
              ),
              height: 200,
              width: 200,
              child: Text("Hello"),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
   _controller = AnimationController(vsync: this,duration: Duration(seconds: 2));
   _animation = Tween<double>(begin: 0,end: 100).animate(_controller);
   _controller.addListener(() {
     setState(() {
       print("Animation Value: ${_animation.value}\n Animation Value with PI: ${pi*_animation.value}");
     });
   },);
   // _controller.forward();
  }
}

