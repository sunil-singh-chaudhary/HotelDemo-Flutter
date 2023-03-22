import 'package:design_demo/Routes/visibilityModel.dart';
import 'package:design_demo/screen/searchBarPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

import '../Routes/AppLocalizations.dart';
import '../Routes/AppTheme.dart';
import '../Routes/list_data.dart';
import 'HotelScreen.dart';
import 'TicketView.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Text(
                      'Goood Morinng',
                      style: kgmTextStyle,
                    ),
                  ),
                  Gap(2),
                  Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Text(
                      'Book Ticket',
                      style: kheadlineTextStyle,
                    ),
                  )
                ],
              ),
              const Gap(10),
              const Padding(
                padding: EdgeInsets.only(right: 20),
                child: Icon(Icons.menu),
              )
            ],
          ),
          const Gap(20),
          const searchBarPage(),
          const Gap(20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text(
                  AppLocalizations.of(context)?.translate('upcoming') ??
                      'upcoming', //upcoming
                  style: kheadlineTwoTextStyle,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Text(
                  'View All',
                  style: kgmTextStyle.copyWith(color: Colors.blue),
                ),
              ),
            ],
          ),
          SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                    children: ticketInfo
                        .map((ticketinfo) =>
                            TicketView(ticketBooking: ticketinfo))
                        .toList()),
              )),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 20),
                child: Text(
                  'Hotels',
                  style: kheadlineTwoTextStyle,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Text(
                  'View All',
                  style: kgmTextStyle.copyWith(color: Colors.blue),
                ),
              ),
            ],
          ),
          SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                    children: hotel_list
                        .map((singleHotel) =>
                            HotelScreen(hotel_list: singleHotel))
                        .toList()),
              )),
        ],
      ),
    );
  }
}
