import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarEventDetailsDialog extends StatelessWidget {
  final List dayEvents; // Liste der Ereignisse für den Tag
  final int index; // Index des ausgewählten Ereignisses

  CalendarEventDetailsDialog(this.dayEvents, this.index);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 600,
      margin: EdgeInsets.symmetric(horizontal: 20), // Seitenabstand
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20), // abgerundete Ecken
      ),
      child: SizedBox(
        width: 350, // Breite des Dialogs
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.center, // horizontal zentrierte Ausrichtung
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 50),
              child: DefaultTextStyle(
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 57, 57, 57)), // Stil des Titels
                textAlign:
                    TextAlign.center, // zentrierte Ausrichtung des Titels
                child: Text(
                  dayEvents[index]["title"], // Titel des Ereignisses
                ),
              ),
            ),
            SizedBox(height: 12), // Vertikaler Abstand
            Divider(
                color: Color.fromARGB(255, 225, 225, 225),
                thickness: 2), // Trennlinie mit spezifischer Farbe und Dicke
            SizedBox(height: 12), // Vertikaler Abstand
            Padding(
              padding: const EdgeInsets.only(left: 12.0),
              child: Row(
                children: [
                  SizedBox(
                    width: 100,
                    child: DefaultTextStyle(
                      style: TextStyle(fontSize: 20),
                      child: Text(
                        "Datum: ", // Beschriftung für das Datum
                        textAlign: TextAlign.left, // linke Ausrichtung
                      ),
                    ),
                  ),
                  DefaultTextStyle(
                    style: TextStyle(fontSize: 20),
                    child: Text(
                      dayEvents[index]["date"], // Datum des Ereignisses
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 12), // Vertikaler Abstand
            Padding(
              padding: const EdgeInsets.only(left: 12.0),
              child: Row(
                children: [
                  SizedBox(
                    width: 100,
                    child: DefaultTextStyle(
                      style: TextStyle(fontSize: 20),
                      child: Text(
                        "Uhrzeit: ", // Beschriftung für die Uhrzeit
                        textAlign: TextAlign.left, // linke Ausrichtung
                      ),
                    ),
                  ),
                  DefaultTextStyle(
                    style: TextStyle(fontSize: 20),
                    child: Text(
                      dayEvents[index]["time"], // Uhrzeit des Ereignisses
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 12), // Vertikaler Abstand
            Divider(
                color: Color.fromARGB(255, 225, 225, 225),
                thickness: 2), // Trennlinie mit spezifischer Farbe und Dicke
            SizedBox(height: 12), // Vertikaler Abstand
            SizedBox(
              height: 100, // Höhe des Textfelds für die Ereignisbeschreibung
              child: DefaultTextStyle(
                style: TextStyle(fontSize: 20),
                child: Text(
                  dayEvents[index]
                      ["description"], // Beschreibung des Ereignisses
                  textAlign: TextAlign
                      .center, // zentrierte Ausrichtung der Beschreibung
                ),
              ),
            ),
            Spacer(), // Flexibler Abstand, um den Platz nach unten zu füllen
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(
                      context); // Schließen des Dialogs beim Drücken der Schaltfläche
                },
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(160, 45),
                  backgroundColor: Color.fromARGB(
                      255, 60, 141, 46), // Hintergrundfarbe der Schaltfläche
                  padding: EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 10), // Innenabstand der Schaltfläche
                  textStyle: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold), // Textstil der Schaltfläche
                ),
                child: Text(
                  "Zurück", // Beschriftung der Schaltfläche
                  style: TextStyle(
                      color: Colors.white), // Textfarbe der Schaltfläche
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CalendarDayEvents extends StatelessWidget {
  final Map<String, dynamic> eventData; // Ereignisdaten
  final int dayIndex; // Index des Tages im Monat
  final int monthIndex; // Index des Monats im Jahr

  CalendarDayEvents({
    required this.eventData,
    required this.dayIndex,
    required this.monthIndex,
    super.key,
  });

  final List<IconData> _eventIcons = [
    Icons.celebration,
    Icons.fitness_center,
    Icons.groups,
    Icons.school,
    Icons.medical_services,
    Icons.restaurant,
    Icons.star,
  ];

  final List<Color> _eventColors = [
    Colors.red,
    Colors.orange,
    Colors.green,
    const Color.fromARGB(255, 7, 57, 97),
    Colors.lightBlue,
    Colors.purple,
    Colors.pink,
  ];

  @override
  Widget build(BuildContext context) {
    List events = eventData[monthIndex.toString()][dayIndex.toString()];

    return ListView.builder(
      physics: const ClampingScrollPhysics(),
      padding: const EdgeInsets.all(18),
      itemCount: events.length,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () {
            _showEventDetailsDialog(index, context, events);
          },
          child: SizedBox(
            height: 70,
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Card(
                elevation: 4,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  ),
                  height: 50,
                  width: 220,
                  child: Center(
                    child: Wrap(
                      spacing: 20,
                      alignment: WrapAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            Icon(
                              _eventIcons[index],
                              color: _eventColors[index],
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              '${events[index]["time"]} | ${events[index]["title"]}',
                              style: GoogleFonts.nunito(
                                color: Color.fromARGB(255, 73, 73, 73),
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  // Funktion zum Anzeigen der Ereignisdetails in einem Dialogfenster
  void _showEventDetailsDialog(
      int index, BuildContext context, List weekEvents) {
    showGeneralDialog(
      context: context,
      pageBuilder: (context, animation1, animation2) {
        return Container(
            color: Colors.white); // Leeres Container als Platzhalter
      },
      barrierDismissible: true, // Dialog durch Klicken außerhalb schließen
      barrierColor: const Color.fromARGB(
          0, 0, 0, 0), // Transparente Hintergrundfarbe für den Hintergrund
      barrierLabel: '',
      transitionBuilder: (context, a1, a2, widget) {
        return ScaleTransition(
          scale: Tween<double>(begin: 0.5, end: 1.0)
              .animate(a1), // Skalierungseffekt
          child: FadeTransition(
            opacity: Tween<double>(begin: 0.5, end: 1.0)
                .animate(a1), // Einblendungseffekt
            child: Align(
              alignment: Alignment.center,
              child: CalendarEventDetailsDialog(
                  weekEvents, index), // Dialoginhalt anzeigen
            ),
          ),
        );
      },
      transitionDuration: Duration(milliseconds: 180), // Übergangsdauer
    );
  }
}

class EventCalendar extends StatefulWidget {
  final dynamic eventData;

  // Konstruktor mit dem erforderlichen Parameter
  EventCalendar({Key? key, required this.eventData}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _EventCalendarWidgetState createState() =>
      // ignore: no_logic_in_create_state
      _EventCalendarWidgetState(eventData: eventData);
}

class _EventCalendarWidgetState extends State<EventCalendar> {
  final dynamic eventData;

  // Konstruktor mit dem erforderlichen Parameter
  _EventCalendarWidgetState({required this.eventData});

  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 18.0,
        right: 18,
      ),
      child: Column(
        children: [
          TableCalendar(
            calendarFormat: _calendarFormat,
            onFormatChanged: (format) {
              setState(() {
                _calendarFormat = format;
              });
            },
            calendarStyle: CalendarStyle(
              todayDecoration: const BoxDecoration(
                color: Color.fromARGB(255, 49, 128, 52),
                shape: BoxShape.circle,
              ),
              selectedDecoration: const BoxDecoration(
                color: Color.fromARGB(255, 116, 116, 116),
                shape: BoxShape.circle,
              ),
            ),
            rowHeight: 37,
            daysOfWeekHeight: 16,
            firstDay: DateTime.utc(2010, 10, 16),
            lastDay: DateTime.utc(2030, 3, 14),
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
              _showEventDialog(context, selectedDay.day, selectedDay.month);
            },
          ),
        ],
      ),
    );
  }

  void _showEventDialog(BuildContext context, dayIndex, monthIndex) {
    showGeneralDialog(
      barrierLabel: "Label",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: Duration(milliseconds: 200),
      context: context,
      pageBuilder: (context, anim1, anim2) {
        return Align(
          alignment: Alignment.center,
          child: Container(
            height: 600,
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: SizedBox(
              width: 350,
              child: Column(
                children: [
                  DefaultTextStyle(
                    style: TextStyle(
                      fontSize: 20,
                      color: Color.fromARGB(255, 57, 57, 57),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text('Events'),
                          SizedBox(
                            height: 300,
                            child: CalendarDayEvents(
                              eventData: eventData,
                              dayIndex: dayIndex,
                              monthIndex: monthIndex,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(255, 60, 141, 46),
                            padding: EdgeInsets.symmetric(
                                horizontal: 40, vertical: 10),
                            textStyle: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                        child: SizedBox(
                            width: 80,
                            height: 40,
                            child: Center(
                                child: Text(
                              style: TextStyle(color: Colors.white),
                              "Zurück",
                            ))),
                        onPressed: () {
                          Navigator.pop(context);
                        }),
                  )
                  // Weitere Inhalte für das Dialogfeld hier hinzufügen
                ],
              ),
            ),
          ),
        );
      },
      transitionBuilder: (context, anim1, anim2, child) {
        return SlideTransition(
          position:
              Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(anim1),
          child: child,
        );
      },
    );
  }
}
