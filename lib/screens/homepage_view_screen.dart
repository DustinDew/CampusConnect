import 'package:campus_connect/widgets/bottom_navbar_widget.dart';
import 'package:flutter/material.dart';

class HomepageViewScreen extends StatelessWidget {
  final Map<String, dynamic> eventData;
  HomepageViewScreen({required this.eventData, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavBar(
        context: context,
        eventData: eventData,
      ),
      body: Column(
        children: [],
      ),
    );
  }
}
