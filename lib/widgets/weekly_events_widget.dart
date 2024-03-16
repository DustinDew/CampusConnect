import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

Color _tertiaryColor = Color.fromARGB(255, 228, 244, 232);

class EventDetailsDialog extends StatelessWidget {
  final List weekEvents;
  final int index;
  final int dayIndex;
  EventDetailsDialog(this.weekEvents, this.index, this.dayIndex);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 600,
      margin: EdgeInsets.only(left: 0, right: 0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: SizedBox(
        width: 350,
        child: Column(
          children: [
            DefaultTextStyle(
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 20, color: Color.fromARGB(255, 57, 57, 57)),
              child: Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    weekEvents[dayIndex][index]["title"],
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                height: 2,
                color: Color.fromARGB(255, 225, 225, 225),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Row(
                children: [
                  Column(
                    children: [
                      SizedBox(
                        width: 100,
                        child: DefaultTextStyle(
                          textAlign: TextAlign.left,
                          style: TextStyle(fontSize: 20),
                          child: Text("Datum: "),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      DefaultTextStyle(
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 20),
                        child: Text(weekEvents[dayIndex][index]["date"]),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Row(
                children: [
                  Column(
                    children: [
                      SizedBox(
                        width: 100,
                        child: DefaultTextStyle(
                          textAlign: TextAlign.left,
                          style: TextStyle(fontSize: 20),
                          child: Text("Uhrzeit: "),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      DefaultTextStyle(
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 20),
                        child: Text(weekEvents[dayIndex][index]["time"]),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                height: 2,
                color: Color.fromARGB(255, 225, 225, 225),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: SizedBox(
                height: 100,
                child: DefaultTextStyle(
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20),
                  child: Text(weekEvents[dayIndex][index]["description"]),
                ),
              ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 60, 141, 46),
                      padding:
                          EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                      textStyle:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
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
          ],
        ),
      ),
    );
  }
}

class DailyEventPageView extends StatefulWidget {
  final Map<String, dynamic> eventData;

  // Konstruktor mit dem erforderlichen Parameter
  DailyEventPageView({Key? key, required this.eventData}) : super(key: key);

  @override
  State<DailyEventPageView> createState() => _DailyEventPageViewState();
}

class _DailyEventPageViewState extends State<DailyEventPageView> {
  PageController _controller = PageController(initialPage: 1);

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

  @override
  Widget build(BuildContext context) {
    setState(() {
      _controller = PageController(initialPage: getCurrentWeekday());
    });
    List<Widget> eventListView = [
      DailyEventsListView(eventData: widget.eventData, dayIndex: 0),
      DailyEventsListView(eventData: widget.eventData, dayIndex: 1),
      DailyEventsListView(eventData: widget.eventData, dayIndex: 2),
      DailyEventsListView(eventData: widget.eventData, dayIndex: 3),
      DailyEventsListView(eventData: widget.eventData, dayIndex: 4),
      DailyEventsListView(eventData: widget.eventData, dayIndex: 5),
      DailyEventsListView(eventData: widget.eventData, dayIndex: 6)
    ];
    final List<String> weekdays = [
      'Montag',
      'Dienstag',
      'Mittwoch',
      'Donnerstag',
      'Freitag',
      'Samstag',
      'Sonntag',
    ];
    double cardHeight = 300;

    if (MediaQuery.of(context).size.height >= 890) {
      cardHeight = 380;
    }

    if (MediaQuery.of(context).size.height <= 700) {
      cardHeight = 280;
    }

    List<String> getCurrentWeekDates() {
      List<String> weekDates = [];

      // Heutiges Datum abrufen
      DateTime now = DateTime.now();

      // Den Wochentag des heutigen Datums ermitteln (1 = Montag, 7 = Sonntag)
      int currentWeekday = now.weekday;

      // Berechne den Unterschied zwischen dem heutigen Wochentag und dem Montag (1 für Montag, 2 für Dienstag usw.)
      int differenceFromMonday = currentWeekday - DateTime.monday;

      // Berechne das Datum des Montags der aktuellen Woche
      DateTime mondayOfCurrentWeek =
          now.subtract(Duration(days: differenceFromMonday));

      // Iteriere über die Tage der Woche (Montag bis Sonntag) und füge sie zur Liste hinzu
      for (int i = 0; i < 7; i++) {
        DateTime currentDate = mondayOfCurrentWeek.add(Duration(days: i));
        String formattedDate = DateFormat('dd.MM').format(currentDate);
        weekDates.add(formattedDate);
      }

      return weekDates;
    }

    List weekDays = getCurrentWeekDates();
    return SizedBox(
      height: cardHeight,
      child: PageView.builder(
        pageSnapping: true,
        itemCount: 7,
        controller: _controller,
        itemBuilder: (context, index) {
          return ListenableBuilder(
            listenable: _controller,
            builder: (context, child) {
              return Container(
                alignment: Alignment.center,
                child: Padding(
                  padding:
                      const EdgeInsets.only(bottom: 18.0, left: 8, right: 8),
                  child: Card(
                    elevation: 1,
                    color: _tertiaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12.0)),
                    ),
                    semanticContainer: false,
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(12),
                              topRight: Radius.circular(12),
                            ),
                            color: Color.fromRGBO(63, 63, 63, 1),
                          ),
                          width: 300,
                          height: 50,
                          child: Center(
                            child: Text(
                              "${weekdays.elementAt(index)} | ${weekDays[index]}.",
                              style: GoogleFonts.nunito(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: SizedBox(
                            width: 300,
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 12.0),
                              child: eventListView[index],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class DailyEventsListView extends StatelessWidget {
  final dynamic eventData;
  final int dayIndex;
  // Konstruktor mit dem erforderlichen Parameter
  DailyEventsListView(
      {Key? key, required this.eventData, required this.dayIndex})
      : super(key: key);

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

  List<int> getCurrentWeekDays() {
    DateTime now = DateTime.now();
    int currentMonth = now.month;

    // Berechne den ersten Tag der Woche (Sonntag)
    DateTime firstDayOfWeek = now.subtract(Duration(days: now.weekday - 1));

    // Liste für die Tageszahlen der aktuellen Woche
    List<int> weekDays = [];

    // Füge die Tageszahlen der aktuellen Woche zur Liste hinzu
    for (int i = 0; i < 7; i++) {
      DateTime currentDay = firstDayOfWeek.add(Duration(days: i));
      weekDays.add(currentDay.day);
    }

    return [currentMonth, ...weekDays];
  }

  List getDailyEvents(eventData) {
    List weekdays = getCurrentWeekDays();
    String currMonth = weekdays[0].toString();
    String monday = weekdays[1].toString();
    String tuesday = weekdays[2].toString();
    String wednesday = weekdays[3].toString();
    String thursday = weekdays[4].toString();
    String friday = weekdays[5].toString();
    String saturday = weekdays[6].toString();
    String sunday = weekdays[7].toString();
    List weekEvents = [
      eventData[currMonth][monday],
      eventData[currMonth][tuesday],
      eventData[currMonth][wednesday],
      eventData[currMonth][thursday],
      eventData[currMonth][friday],
      eventData[currMonth][saturday],
      eventData[currMonth][sunday]
    ];
    return weekEvents;
  }

  @override
  Widget build(BuildContext context) {
    List events = getDailyEvents(eventData);

    return ListView.builder(
      physics: const ClampingScrollPhysics(),
      padding: const EdgeInsets.all(18),
      itemCount: events.elementAt(dayIndex).length,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
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
                              _eventIcons.elementAt(index),
                              color: _eventColors[index],
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              events.elementAt(dayIndex)[index]["time"] +
                                  " | " +
                                  events.elementAt(dayIndex)[index]["title"],
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
          onTap: () {
            buildEventDetailsWindow(dayIndex, index, context, events);
          },
        );
      },
    );
  }
}

buildEventDetailsWindow(
    int dayIndex, int index, dialogContext, List weekEvents) {
  return showGeneralDialog(
    context: dialogContext,
    pageBuilder: (context, animation1, animation2) {
      return Container(color: Colors.white);
    },
    barrierDismissible: true,
    barrierColor: Colors.black.withOpacity(0.5),
    barrierLabel: '',
    transitionBuilder: (context, a1, a2, widget) {
      return ScaleTransition(
        scale: Tween<double>(begin: 0.5, end: 1.0).animate(a1),
        child: FadeTransition(
            opacity: Tween<double>(begin: 0.5, end: 1.0).animate(a1),
            child: Align(
              alignment: Alignment.center,
              child: EventDetailsDialog(weekEvents, index, dayIndex),
            )),
      );
    },
    transitionDuration: Duration(milliseconds: 180),
  );
}
