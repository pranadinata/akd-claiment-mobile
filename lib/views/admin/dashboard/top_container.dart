import 'package:akd_flutter/models/colors.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_task_planner_app/theme/colors/light_colors.dart';

class TopContainer extends StatelessWidget {
  final double height;
  final double width;
  final Widget child;
  final EdgeInsets padding;
  TopContainer({required this.height, required this.width, required this.child, required this.padding});


  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: padding!=null ? padding : EdgeInsets.symmetric(horizontal: 20.0),
      decoration: BoxDecoration(
          color: color.Mblue,
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(30.0),
            bottomLeft: Radius.circular(30.0),
            // topLeft: Radius.circular(60.0)
          )),
      height: height,
      width: width,
      child: child,
    );
  }
}
