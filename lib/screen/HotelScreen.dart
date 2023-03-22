import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:gap/gap.dart';

import '../Routes/AppTheme.dart';

@immutable
class HotelScreen extends StatefulWidget {
  final Map<String, dynamic> hotel_list;
  const HotelScreen({super.key, required this.hotel_list});

  @override
  State<HotelScreen> createState() => _MyHotelScreenState();
}

class _MyHotelScreenState extends State<HotelScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: const Color.fromARGB(255, 12, 36, 56),
          borderRadius: BorderRadius.circular(10)),
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      width: MediaQuery.of(context).size.width * 0.45,
      height: MediaQuery.of(context).size.width * 0.55,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            height: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(
                      'assets/images/${widget.hotel_list['imaeg']}')),
            ),
          ),
          const Gap(10),
          Text(
            widget.hotel_list['place'],
            style: kgmTextStyle.copyWith(color: Colors.white),
          ),
          const Gap(5),
          Text(
            widget.hotel_list['destination'],
            style: kgmTextStyle.copyWith(color: Colors.white),
          ),
          const Gap(10),
          Text(
            widget.hotel_list['Price'],
            style: kgmTextStyle.copyWith(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
