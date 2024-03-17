import 'package:campus_connect/screens/main_calendar_screen.dart';
import 'package:flutter/material.dart';
import 'package:campus_connect/screens/campus_map_view_screen.dart';
import 'package:campus_connect/screens/homepage_view_screen.dart';

// Definiere die Primär- und Sekundärfarben sowie das aktuelle Datum
Color _secondaryColor = Color.fromARGB(255, 20, 144, 26);
DateTime currentDate = DateTime.now();

// Widget für die benutzerdefinierte Navigationsleiste am unteren Bildschirmrand
class BottomNavBar extends StatelessWidget {
  final BuildContext context;
  final Map<String, dynamic> eventData;
  final int pageIndex;
  // Konstruktor, der den Build-Kontext erwartet
  BottomNavBar(
      {required this.context,
      required this.eventData,
      required this.pageIndex});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: BottomNavigationBar(
        selectedFontSize: 0.0,
        unselectedFontSize: 0.0,
        iconSize: 25,
        backgroundColor: Color.fromARGB(207, 255, 255, 255),
        showSelectedLabels: false,
        showUnselectedLabels: false,
        // Liste von BottomNavigationBarItems mit jeweiligem IconButton
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: IconButton(
              onPressed: () {
                // Navigiere zur Homepage-Ansicht beim Klicken auf das Artikel-Icon
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return HomepageViewScreen(
                    eventData: eventData,
                  );
                }));
              },
              icon: Icon(
                Icons.article,
                color: pageIndex == 2
                    ? _secondaryColor
                    : Color.fromARGB(255, 26, 39, 55), // Artikel-Icon-Farbe
              ),
            ),
            label: '', // Kein Text für das Artikel-Icon
          ),
          BottomNavigationBarItem(
            icon: IconButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return EventCalenderViewScreen(
                    eventData: eventData,
                  );
                }));
              },
              icon: Icon(
                Icons.event,
                color: pageIndex == 1
                    ? _secondaryColor
                    : Color.fromARGB(255, 26, 39,
                        55), // Sekundärfarbe für das Veranstaltungs-Icon
              ),
            ),
            label: '', // Kein Text für das Veranstaltungs-Icon
          ),
          BottomNavigationBarItem(
            icon: IconButton(
              onPressed: () {
                // Navigiere zur Kartenansicht beim Klicken auf das Karten-Icon
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return CampusMapViewScreen(
                    eventData: eventData,
                  );
                }));
              },
              icon: Icon(
                Icons.map,
                color: pageIndex == 3
                    ? _secondaryColor
                    : Color.fromARGB(255, 26, 39, 55), // Karten-Icon-Farbe
              ),
            ),
            label: '', // Kein Text für das Karten-Icon
          ),
        ],
      ),
    );
  }
}
