// ignore_for_file: must_be_immutable, unused_field

import 'package:flutter/material.dart';
import 'package:campus_connect/widgets/bottom_navbar_widget.dart';
import 'package:campus_connect/widgets/custom_buttons_widget.dart';
import 'package:campus_connect/widgets/weekly_events_widget.dart';
import 'package:campus_connect/widgets/event_calendar_widget.dart';

class EventCalenderViewScreen extends StatefulWidget {
  Map<String, dynamic> eventData;

  EventCalenderViewScreen({required this.eventData, Key? key})
      : super(key: key);

  @override
  State<EventCalenderViewScreen> createState() =>
      _EventCalenderViewScreenState(eventData);
}

class _EventCalenderViewScreenState extends State<EventCalenderViewScreen> {
  final PageController _controller = PageController(viewportFraction: 0.8);
  List test = [1, 2];
  Map<String, dynamic> eventData;

  _EventCalenderViewScreenState(this.eventData);

  void updateEvents(dateNumbers, eventTitle, eventDate, eventTime,
      eventDescription, eventIcon) {
    Map<String, dynamic> createNewEvent({
      required String title,
      required String date,
      required String time,
      required String description,
      required String icon,
    }) {
      return {
        'title': title,
        'date': date,
        'time': time,
        'description': description,
        'icon': icon,
      };
    }

    Map<String, dynamic> newEvent = createNewEvent(
        title: eventTitle,
        date: eventDate,
        time: eventTime,
        description: eventDescription,
        icon: "star");

    String eventMonth = dateNumbers[1];
    String eventDay = dateNumbers[0];
    if (int.parse(eventMonth) < 10) {
      eventMonth = dateNumbers[1].replaceAll("0", "");
      print("jup");
    }
    if (int.parse(eventDay) < 10) {
      eventDay = dateNumbers[0].replaceAll("0", "");
    }
    setState(() {
      eventData[eventMonth][eventDay].add(newEvent);
    });
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Termin Hinzugefügt!'),
        duration: Duration(seconds: 5),
        backgroundColor: Color.fromARGB(255, 82, 182, 69),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            //Daily Events PageView//
            Padding(
              padding: const EdgeInsets.only(
                top: 16.0,
                bottom: 16.0,
              ),
              child: DailyEventPageView(
                eventData: widget.eventData,
              ),
            ),
            Column(
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: AddEventButton(
                        updateData: updateEvents,
                        context: context,
                      ),
                    ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(right: 20.0),
                      child: SortButton(
                        context: context,
                      ),
                    ),
                  ],
                ),
                EventCalendar(
                  eventData: widget.eventData,
                )
              ],
            ),
          ],
        ),
      ),

      //BottomNavigationBar//
      bottomNavigationBar: BottomNavBar(
        pageIndex: 1,
        context: context,
        eventData: eventData,
      ),
    );
  }
}

int getCurrentWeekday() {
  // Heutiges Datum abrufen
  DateTime now = DateTime.now();

  // Den Wochentag des heutigen Datums ermitteln (1 für Montag, 7 für Sonntag)
  int weekday = now.weekday;

  // Da wir den Wochentag von 1-basiert auf 0-basiert umrechnen wollen, subtrahieren wir 1
  int adjustedWeekday = weekday - 1;

  // Da Dart/Swift standardmäßig den Wochentag als 1 für Montag bis 7 für Sonntag liefert,
  // verwenden wir den Modulo-Operator, um sicherzustellen, dass der Rückgabewert im Bereich von 0 bis 6 liegt.
  return adjustedWeekday % 7;
}
