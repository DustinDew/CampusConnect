import 'dart:convert';
import 'dart:ui';

import 'package:campus_connect/screens/main_calendar_screen.dart';
import 'package:campus_connect/scripts/init.dart';
import 'package:campus_connect/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Hauptfunktion für den Start der Anwendung
Future<void> main() async {
  // Stellt sicher, dass die Widgets-Bindung initialisiert ist
  WidgetsFlutterBinding.ensureInitialized();

  // Lädt die Event-Daten aus der JSON-Datei
  Map<String, dynamic> eventData = await readJson();

  // Startet die Anwendung
  runApp(MyApp(
    eventData: eventData,
  ));
}

// Haupt-Widget für die Anwendung
class MyApp extends StatelessWidget {
  // Event-Daten, die beim Start der Anwendung übergeben werden
  final Map<String, dynamic> eventData;

  // Konstruktor für MyApp
  MyApp({required this.eventData, super.key});

  // Future-Objekt für die Initialisierung
  final Future _initFuture = Init.initialize();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CampusConnect', // Titel der Anwendung
      // Startseite der Anwendung mit FutureBuilder
      home: FutureBuilder(
        future: _initFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // Wenn die Initialisierung abgeschlossen ist, zeige den Hauptbildschirm mit den Event-Daten
            return EventCalenderViewScreen(
              eventData: eventData,
            );
          } else {
            // Ansonsten zeige den SplashScreen während der Initialisierung
            return SplashScreen();
          }
        },
      ),
    );
  }
}

// Benutzerdefiniertes Scrollverhalten für MaterialDesign
class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Überschreibt Methoden und Getter wie dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        // usw.
      };
}

// Funktion zum Lesen der Event-Daten aus der JSON-Datei
Future<Map<String, dynamic>> readJson() async {
  print("loading events..."); // Ausgabe zur Anzeige des Ladevorgangs
  // Lädt den Inhalt der JSON-Datei
  final String response = await rootBundle.loadString('lib/assets/data.json');
  // Dekodiert den JSON-String und gibt die Daten zurück
  final data = await json.decode(response);
  print(
      "finished loading events"); // Ausgabe, wenn der Ladevorgang abgeschlossen ist
  return data;
}
