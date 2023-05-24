//Costom CLipper class with Path
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hi_doctor/theme/Mycolors.dart';
import 'dart:math' show pi;

class Background extends StatelessWidget {
  const Background({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).copyWith().size;
    return Stack(
      children: [
        ClipPath(
          //upper clippath with less height
          clipper: WaveClipperTop(flip: false), //set our custom wave clipper.
          child: Container(
              color: MyColors.blue2,
              height: size.height * 0.3,
              width: size.width,
              alignment: Alignment.center,
              child: SizedBox()),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: ClipPath(
            //upper clippath with less height
            clipper:
                WaveClipperButtom(flip: true), //set our custom wave clipper.
            child: Container(
                color: MyColors.blue2,
                height: size.height * 0.3,
                width: size.width,
                alignment: Alignment.center,
                child: SizedBox()),
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: SizedBox(
              width: size.width * 0.6,
              height: size.height * 0.4,
              child: SvgPicture.asset("assets/signin1.svg")),
        )
      ],
    );
  }
}

class WaveClipperTop extends CustomClipper<Path> {
  final bool flip;
  WaveClipperTop({required this.flip});
  @override
  Path getClip(Size size) {
    var path = new Path();
    path.lineTo(
        0, size.height); //start path with this if you are making at bottom

    var firstStart = Offset(size.width * 0.25, size.height);
    //fist point of quadratic bezier curve
    var firstEnd = Offset(size.width * 0.35, size.height * 0.65);
    //second point of quadratic bezier curve
    path.quadraticBezierTo(
        firstStart.dx, firstStart.dy, firstEnd.dx, firstEnd.dy);

    var secondStart = Offset(size.width * 0.4, size.height * 0.4);
    //third point of quadratic bezier curve
    var secondEnd = Offset(size.width * 0.55, size.height * 0.3);
    //fourth point of quadratic bezier curve
    path.quadraticBezierTo(
        secondStart.dx, secondStart.dy, secondEnd.dx, secondEnd.dy);
    var thirdStart = Offset(size.width * 0.6, size.height * 0.28);
    //third point of quadratic bezier curve
    var thirdEnd = Offset(size.width * 0.75, size.height * 0.08);
    //fourth point of quadratic bezier curve
    path.quadraticBezierTo(
        thirdStart.dx, thirdStart.dy, thirdEnd.dx, thirdEnd.dy);

    path.lineTo(size.width * 0.8,
        0); //end with this path if you are making wave at bottom
    path.close();
    return flip
        ? _flip(
            path,
            size.width,
          )
        : path;
  }

  Path _flip(
    Path path,
    double width,
  ) {
    final m = Matrix4.identity()
      ..translate(width)
      ..rotateY(pi);
    return path.transform(m.storage);
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true; //if new instance have different instance than old instance
    //then you must return true;
  }
}

class WaveClipperButtom extends CustomClipper<Path> {
  final bool flip;
  WaveClipperButtom({required this.flip});
  @override
  Path getClip(Size size) {
    var path = new Path();
    path.lineTo(
        0, size.height); //start path with this if you are making at bottom
    path.lineTo(size.width, size.height);
    var firstStart = Offset(size.width * 0.8, size.height);
    //fist point of quadratic bezier curve
    var firstEnd = Offset(size.width * 0.75, size.height * 0.9);
    path.quadraticBezierTo(
        firstStart.dx, firstStart.dy, firstEnd.dx, firstEnd.dy);
    var secondStart = Offset(size.width * 0.75, size.height * 0.9);
    //fist point of quadratic bezier curve
    var secondEnd = Offset(size.width * 0.65, size.height * 0.7);
    path.quadraticBezierTo(
        secondStart.dx, secondStart.dy, secondEnd.dx, secondEnd.dy);
    var thirdStart = Offset(size.width * 0.6, size.height * 0.6);
    //fist point of quadratic bezier curve
    var thirdEnd = Offset(size.width * 0.5, size.height * 0.7);
    path.quadraticBezierTo(
        thirdStart.dx, thirdStart.dy, thirdEnd.dx, thirdEnd.dy);
    var fouthStart = Offset(size.width * 0.4, size.height * 0.8);
    //fist point of quadratic bezier curve
    var fouthEnd = Offset(size.width * 0.2, size.height * 0.2);
    path.quadraticBezierTo(
        fouthStart.dx, fouthStart.dy, fouthEnd.dx, fouthEnd.dy);
    var fifthStart = Offset(size.width * 0.15, size.height * 0.05);
    //fist point of quadratic bezier curve
    var fifthEnd = Offset(size.width * 0, size.height * 0);
    path.quadraticBezierTo(
        fifthStart.dx, fifthStart.dy, fifthEnd.dx, fifthEnd.dy);
    // path.lineTo(size.width, size.height);
    path.close();
    return flip
        ? _flip(
            path,
            size.width,
          )
        : path;
  }

  Path _flip(
    Path path,
    double width,
  ) {
    final m = Matrix4.identity()
      ..translate(width)
      ..rotateY(pi);
    return path.transform(m.storage);
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true; //if new instance have different instance than old instance
    //then you must return true;
  }
}
