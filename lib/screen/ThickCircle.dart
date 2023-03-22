import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class ThickCircle extends StatelessWidget {
  const ThickCircle({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 12,
        width: 12,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.white, width: 5),
            borderRadius: BorderRadius.all(Radius.circular(20)),
            color: Colors.transparent),
      ),
    );
  }
}
