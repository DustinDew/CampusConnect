import 'package:campus_connect/widgets/bottom_navbar_widget.dart';
import 'package:flutter/material.dart';

class CampusMapViewScreen extends StatelessWidget {
  final Map<String, dynamic> eventData;
  const CampusMapViewScreen({required this.eventData, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavBar(
        pageIndex: 3,
        context: context,
        eventData: eventData,
      ),
      body: Column(
        children: [],
      ),
    );
  }
}
