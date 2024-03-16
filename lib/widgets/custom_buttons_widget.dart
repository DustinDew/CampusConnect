import 'package:campus_connect/widgets/custom_form_widget.dart';
import 'package:flutter/material.dart';

Color _primaryColor = Color.fromARGB(255, 60, 141, 46);
Color _secondaryColor = Color.fromARGB(255, 20, 144, 26);
DateTime currentDate = DateTime.now();

// Klasse für den Button zum Hinzufügen eines neuen Events
class AddEventButton extends StatelessWidget {
  final BuildContext context;
  final Function(dynamic, dynamic, dynamic, dynamic, dynamic, dynamic)
      updateData;

  // Konstruktor
  AddEventButton({required this.context, required this.updateData});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      heroTag: "addButton",
      shape: CircleBorder(),
      elevation: 5,
      backgroundColor: _primaryColor,
      onPressed: () {
        // Allgemeines Dialogfeld anzeigen
        showGeneralDialog(
          barrierLabel: "Label",
          barrierDismissible: true,
          barrierColor: Colors.black.withOpacity(0.5),
          context: context,
          // Page-Builder für den Dialoginhalt
          pageBuilder: (context, anim1, anim2) {
            return Align(
              alignment: Alignment.centerLeft,
              child: Container(
                height: 600,
                margin: EdgeInsets.zero,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
                child: SizedBox(
                  width: 300,
                  child: Column(
                    children: [
                      // Text für den Dialogtitel
                      DefaultTextStyle(
                        style: TextStyle(
                          fontSize: 20,
                          color: Color.fromARGB(255, 57, 57, 57),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(8.0, 20, 8.0, 8.0),
                          child: Text('Neuer Termin'),
                        ),
                      ),
                      // Formular für die Eingabe der Eventdaten
                      Material(
                        child: MyCustomForm(
                          updateEventData: updateData,
                        ),
                      ),
                      SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
            );
          },
          // Übergangseffekt für den Dialog
          transitionBuilder: (context, anim1, anim2, child) {
            return SlideTransition(
              position:
                  Tween(begin: Offset(-1, 0), end: Offset.zero).animate(anim1),
              child: child,
            );
          },
        );
      },
      // Icon des Buttons
      child: Icon(
        Icons.add,
        color: Colors.white,
      ),
    );
  }
}

// Widget für den Sortierungsbutton
class SortButton extends StatelessWidget {
  // Build-Kontext
  final BuildContext context;

  // Konstruktor
  SortButton({required this.context});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      heroTag: "sortButton",
      shape: CircleBorder(),
      elevation: 2,
      backgroundColor: _primaryColor,
      onPressed: () {
        // Anzeige des allgemeinen Dialogs
        showGeneralDialog(
          barrierLabel: "Label",
          barrierDismissible: true,
          barrierColor: Colors.black.withOpacity(0.5),
          transitionDuration: Duration(milliseconds: 180),
          context: context,
          pageBuilder: (context, anim1, anim2) {
            return Align(
              alignment: Alignment.centerRight,
              child: Container(
                height: 600,
                margin: EdgeInsets.only(left: 12, right: 0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                  ),
                ),
                child: SizedBox(
                  width: 300,
                  child: Column(
                    children: [
                      // Text für den Filter
                      DefaultTextStyle(
                        style: TextStyle(
                          fontSize: 20,
                          color: Color.fromARGB(255, 57, 57, 57),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Filter'),
                        ),
                      ),
                      // Weitere Filteroptionen hier einfügen
                    ],
                  ),
                ),
              ),
            );
          },
          transitionBuilder: (context, anim1, anim2, child) {
            return SlideTransition(
              position:
                  Tween(begin: Offset(1, 0), end: Offset(0, 0)).animate(anim1),
              child: child,
            );
          },
        );
      },
      child: Icon(
        Icons.sort,
        color: Colors.white,
      ),
    );
  }
}

Map<String, dynamic> getWeekData(DateTime currentDate) {
  // Berechne den Anfang der Woche (Montag)
  DateTime startOfWeek =
      currentDate.subtract(Duration(days: currentDate.weekday - 1));

  // Berechne das Ende der Woche (Sonntag)
  DateTime endOfWeek = startOfWeek.add(Duration(days: 6));

  // Formatieren des Datums für die Ausgabe
  String formattedStartOfWeek =
      '${startOfWeek.day}.${startOfWeek.month}.${startOfWeek.year}';
  String formattedEndOfWeek =
      '${endOfWeek.day}.${endOfWeek.month}.${endOfWeek.year}';
  String formattedCurrentDay =
      '${currentDate.day}.${currentDate.month}.${currentDate.year}';

  // Rückgabe der Ergebnisse in einer Map
  return {
    'start': formattedStartOfWeek,
    'end': formattedEndOfWeek,
    'currentDay': formattedCurrentDay,
  };
}
