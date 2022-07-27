import 'package:flutter/material.dart';

Widget menu() {
  return Container(
    color: const Color.fromRGBO(63, 90, 166, 1),
    child: const TabBar(
      labelColor: Colors.white,
      unselectedLabelColor: Colors.white70,
      indicatorSize: TabBarIndicatorSize.tab,
      indicatorColor: Color.fromRGBO(255, 255, 255, 1),
      tabs: [
        Tab(
          icon: Icon(Icons.assignment),
        ),
        Tab(
          icon: Icon(Icons.notes),
        ),
      ],
    ),
  );
}
