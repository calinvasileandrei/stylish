import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class StylishBouncingButton extends StatefulWidget {
  final buttonText;
  final callback;
  final width;
  StylishBouncingButton({Key key,@required this.buttonText,@required this.width,this.callback});

  @override
  _StylishBouncingButtonState createState() => _StylishBouncingButtonState(buttonText,width,callback);
}
class _StylishBouncingButtonState extends State<StylishBouncingButton> with SingleTickerProviderStateMixin {
  String buttonText;
  final callback;
  final buttonWidth;
  double _scale;
  AnimationController _controller;

  _StylishBouncingButtonState(@required this.buttonText,@required this.buttonWidth,this.callback);

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 500,
      ),
      lowerBound: 0.0,
      upperBound: 0.1,
    )..addListener(() {
      setState(() {});
    });
    super.initState();
  }
  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
  @override
  Widget build(BuildContext context) {
    _scale = 1 - _controller.value;
    return GestureDetector(
      onTapDown: _tapDown,
      onTapUp: _tapUp,
      onTap: callback,
      child: Transform.scale(
        scale: _scale,
        child: _animatedButton(),
      ),
    );
  }
  Widget  _animatedButton() {
    return Container(
      height: 140.h,
      width: buttonWidth,
      decoration: BoxDecoration(
          color: Color(0xFFfa7b58),
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.all(Radius.circular(30.0)),
          boxShadow: [
            BoxShadow(
                color: Color(0xFFf78a6c).withOpacity(.6),
                offset: Offset(0.0, 10.0),
                blurRadius: 10.0)
          ]),
      child: Center(
        child: Text(
          buttonText,
          style:TextStyle(
              color: Colors.white,
              fontSize: 72.sp,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
  void _tapDown(TapDownDetails details) {
    _controller.forward();
  }
  void _tapUp(TapUpDetails details) {
    _controller.reverse();
  }
}