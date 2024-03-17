import 'package:campus_connect/screens/main_calendar_screen.dart';
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
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'CampusConnect',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20.0),
              Text(
                'Willkommen bei CampusConnect!',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                'Die App, die es dir ermöglicht, Events deiner Institution oder Hochschule zentral einzusehen und eigene Termine lokal zu erstellen.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
              SizedBox(
                height: 50,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size(300, 45),
                    backgroundColor: Color.fromARGB(
                        255, 60, 141, 46), // Hintergrundfarbe der Schaltfläche
                    padding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10), // Innenabstand der Schaltfläche
                    textStyle: TextStyle(
                        fontSize: 16,
                        fontWeight:
                            FontWeight.bold), // Textstil der Schaltfläche
                  ),
                  onPressed: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return EventCalenderViewScreen(
                        eventData: eventData,
                      );
                    }));
                  },
                  child: SizedBox(
                      width: 200,
                      child: Center(child: Text("Hier gehts zum Kalender"))))
            ],
          ),
        ),
      ),
    );
  }
}
