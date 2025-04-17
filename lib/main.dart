import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_animation/anim/anim.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  late Animation<double> _angle;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    double end = (6 + Random().nextDouble() * 2.2) * pi;
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                children: [
                  Transform.rotate(
                    angle: _angle.value,
                    child: CustomPaint(
                      size: Size(300, 300),
                      painter: SpinWheel(),
                    ),
                  ),
                  CustomPaint(
                    size: Size(300, 300),
                    painter: Pointer(),
                  ),
                ],
              ),

              OutlinedButton(onPressed: (){
                _controller.reset();
                _angle = Tween<double>(
                  begin: 0,
                  end: end, // 4–6 full rotations
                ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
                _controller.forward();
                _controller.addStatusListener((status){


                  if(status==AnimationStatus.completed){
                    print("Angle ${getSectorFromAngle(end, 6).toString()}");
                  }
                });
                print(end);
              }, child: Text("Spin Now!")),
              SizedBox(height: 30,),
              Text("Color is: ${getSectorFromAngle(_angle.value, 6).toString()}",style: TextStyle(color: Colors.black,fontSize: 16),)
            ],
          ),
        ),
      ),
    );
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = AnimationController(vsync: this,duration: Duration(seconds: 4));
    final curve = CurvedAnimation(parent: _controller, curve: Curves.easeOut);
    _angle = Tween<double>(begin: 0,end: 3*2*pi).animate(curve);
    _controller.addListener((){
      setState(() {
      });
    });
  }
  String getSectorFromAngle(double endAngle, int totalSectors) {
    final colors = ["Blue", "Green", "Red", "Purple", "Grey", "Yellow"];

    // Normalize the angle between 0 and 2π
    double normalized = endAngle % (2 * pi);

    // Size of each sector
    double sectorAngle = 2 * pi / totalSectors;

    // Adjust angle so 0 is at the top
    double adjusted = (2 * pi - normalized + pi / 2) % (2 * pi);

    // Get sector index
    int index = (adjusted / sectorAngle).floor();

    // Rotate by 3 positions forward
    index = (index + 3) % totalSectors;

    return colors[index];
  }


}



class SpinWheel extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.black..style = PaintingStyle.fill;
    final center = Offset(size.width/2, size.height/2);
    final rect = Rect.fromCircle(center: center, radius: 100);
    canvas.drawCircle(center, 103, paint);
    final sector = 6;
    final sweepAngle = 2*pi/sector;
    final colors = [Colors.blue,Colors.greenAccent,Colors.red,Colors.purple,Colors.grey,Colors.yellow];
    for(int i=0;i<sector;i++){
      paint.color = colors[i];
      canvas.drawArc(rect, i*sweepAngle, sweepAngle, true, paint);
    }

  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
   return true;
  }

}

class Pointer extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.black..style = PaintingStyle.fill;
    var path = Path();
    final center = Offset(size.width/2, size.height/2);
    path.moveTo(center.dx, center.dy-10);
    path.lineTo(center.dx-10, center.dy+10);
    path.lineTo(center.dx+10, center.dy+10);
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

}

