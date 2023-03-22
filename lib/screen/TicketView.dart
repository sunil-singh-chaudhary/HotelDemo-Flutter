import 'package:design_demo/Routes/Sizer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:gap/gap.dart';

import '../FlightPath.dart';
import 'ThickCircle.dart';

class TicketView extends StatefulWidget {
  final Map<String, dynamic> ticketBooking;
  const TicketView({super.key, required this.ticketBooking});

  @override
  State<TicketView> createState() => _TicketViewState();
}

class _TicketViewState extends State<TicketView> {
  @override
  Widget build(BuildContext context) {
    Sizer.getsize(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(Sizer.getcalculateHeight(10), 0,
                Sizer.getcalculateHeight(10), 0),
            height: MediaQuery.of(context).size.height * 0.12,
            width: MediaQuery.of(context).size.width * 0.90,
            padding:
                EdgeInsets.symmetric(horizontal: Sizer.getcalculateHeight(10)),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(Sizer.getcalculateHeight(20)),
                  topRight: Radius.circular(Sizer.getcalculateHeight(20))),
              color: const Color.fromARGB(255, 18, 49, 75),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Text(
                      widget.ticketBooking['from']['code'],
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: Sizer.getcalculateHeight(16),
                          fontWeight: FontWeight.w500),
                    ),
                    Flexible(child: Container()),
                    const ThickCircle(),
                    const FlightPath(),
                    const ThickCircle(),
                    Flexible(child: Container()),
                    Text(
                      widget.ticketBooking['to']['code'],
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: Sizer.getcalculateHeight(16),
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.ticketBooking['from']['name'],
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: Sizer.getcalculateHeight(16),
                            fontWeight: FontWeight.w500),
                      ),
                      Text(
                        widget.ticketBooking['flying_time'],
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: Sizer.getcalculateHeight(16),
                            fontWeight: FontWeight.w500),
                      ),
                      Text(
                        widget.ticketBooking['to']['name'],
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: Sizer.getcalculateHeight(16),
                            fontWeight: FontWeight.w500),
                      ),
                    ]),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(Sizer.getcalculateHeight(10), 0,
                Sizer.getcalculateHeight(10), 0),
            color: Colors.green,
            width: MediaQuery.of(context).size.width * 0.90,
            height: MediaQuery.of(context).size.height * 0.03,
            child: Row(
              children: [
                SizedBox(
                  height: Sizer.getcalculateHeight(20),
                  width: Sizer.getCalulateWidth(5),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topRight:
                                Radius.circular(Sizer.getcalculateHeight(10)),
                            bottomRight:
                                Radius.circular(Sizer.getcalculateHeight(10)))),
                  ),
                ),
                Flexible(child: LayoutBuilder(
                  builder: (p0, p1) {
                    return Flex(
                      direction: Axis.horizontal,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(
                          ((p1.constrainWidth()) / 10).floor(),
                          (index) => const SizedBox(
                                height: 2,
                                width: 5,
                                child: DecoratedBox(
                                    decoration: BoxDecoration(
                                  color: Colors.white,
                                )),
                              )),
                    );
                  },
                )),
                SizedBox(
                  //right Half ticket circle
                  height: Sizer.getcalculateHeight(20),
                  width: Sizer.getCalulateWidth(5),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft:
                                Radius.circular(Sizer.getcalculateHeight(10)),
                            bottomLeft:
                                Radius.circular(Sizer.getcalculateHeight(10)))),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 10, right: 10),
            padding: const EdgeInsets.only(left: 10, right: 10),
            width: MediaQuery.of(context).size.width * 0.90,
            height: MediaQuery.of(context).size.width * 0.13,
            decoration: const BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.ticketBooking['date'],
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const Gap(5),
                        const Text(
                          'Date',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          widget.ticketBooking['departure-Time'],
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const Gap(5),
                        const Text(
                          'Departure Time',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          widget.ticketBooking['number'].toString(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const Gap(5),
                        const Text(
                          'Number',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      ],
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
