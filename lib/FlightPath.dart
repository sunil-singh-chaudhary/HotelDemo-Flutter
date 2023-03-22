import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

class FlightPath extends StatelessWidget {
  const FlightPath({super.key});

  @override
  Widget build(BuildContext context) {
    return Flexible(
        child: Stack(children: [
      LayoutBuilder(
        builder: (context, constraint) {
          // print("width--> ${constranst.constrainWidth()}");
          return Flex(
              direction: Axis.horizontal,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(
                  6,
                  (index) => const Center(
                        child: Text(
                          '-',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      )));
        },
      ),
      Center(
        child: Transform.rotate(
          angle: 1.5,
          child: const Icon(
            Icons.local_airport_rounded,
            color: Colors.white,
          ),
        ),
      ),
    ]));
  }
}
