import 'package:campus_connect/widgets/icons_selection_widget.dart';
import 'package:flutter/material.dart';

// Primäre und sekundäre Farbkonstanten
const Color _primaryColor = Color.fromARGB(255, 60, 141, 46);
const Color _secondaryColor = Color.fromARGB(255, 20, 144, 26);



// Zustandsklasse für das benutzerdefinierte Formular
class MyCustomForm extends StatefulWidget {
  // Funktion zum Aktualisieren der Eventdaten
  final Function(dynamic, dynamic, dynamic, dynamic, dynamic, dynamic)
      updateEventData;

  // Konstruktor
  MyCustomForm({Key? key, required this.updateEventData}) : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  State<MyCustomForm> createState() => _MyCustomFormState(updateEventData);
}

// Zustandsklasse für das benutzerdefinierte Formular
class _MyCustomFormState extends State<MyCustomForm> {
  // Funktion zum Aktualisieren der Eventdaten
  final Function(dynamic, dynamic, dynamic, dynamic, dynamic, dynamic)
      updateEventData;

  // Konstruktor
  _MyCustomFormState(this.updateEventData);

  // Controller für die Texteingabefelder
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  // Flag für die Anzeige eines Fehlers
  bool showError = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Eingabefeld für den Titel
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              child: TextFormField(
                controller: _titleController,
                cursorColor: Color.fromARGB(255, 51, 51, 51),
                decoration: const InputDecoration(
                  labelStyle: TextStyle(color: Color.fromARGB(255, 47, 47, 47)),
                  border: OutlineInputBorder(borderSide: BorderSide.none),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Color.fromARGB(255, 100, 100, 100))),
                  labelText: 'Titel',
                  filled: true,
                ),
              ),
            ),
            // Eingabefeld für das Datum
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              child: Theme(
                data: Theme.of(context).copyWith(
                  indicatorColor: Color.fromARGB(255, 210, 243, 201),
                  textSelectionTheme: TextSelectionThemeData(
                    selectionColor: Color.fromARGB(255, 193, 193, 193),
                  ),
                ),
                child: TextFormField(
                  controller: _dateController,
                  decoration: InputDecoration(
                      labelStyle:
                          TextStyle(color: Color.fromARGB(255, 47, 47, 47)),
                      border: OutlineInputBorder(borderSide: BorderSide.none),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 100, 100, 100))),
                      labelText: 'Datum',
                      filled: true,
                      prefixIconColor: _secondaryColor,
                      prefixIcon: Icon(Icons.calendar_today)),
                  readOnly: true,
                  onTap: () {
                    _selectDate(context);
                  },
                ),
              ),
            ),
            // Eingabefeld für die Uhrzeit
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              child: Theme(
                data: Theme.of(context).copyWith(
                  indicatorColor: Colors.green,
                  textSelectionTheme: TextSelectionThemeData(
                    selectionColor: Color.fromARGB(255, 193, 193, 193),
                  ),
                ),
                child: TextFormField(
                  controller: _timeController,
                  decoration: const InputDecoration(
                      labelStyle:
                          TextStyle(color: Color.fromARGB(255, 47, 47, 47)),
                      border: OutlineInputBorder(borderSide: BorderSide.none),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 100, 100, 100))),
                      labelText: 'Uhrzeit',
                      filled: true,
                      prefixIconColor: _secondaryColor,
                      prefixIcon: Icon(Icons.calendar_today)),
                  readOnly: true,
                  onTap: () {
                    _selectTime(context);
                  },
                ),
              ),
            ),
            // Eingabefeld für die Beschreibung
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              child: TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelStyle: TextStyle(color: Color.fromARGB(255, 47, 47, 47)),
                  border: OutlineInputBorder(borderSide: BorderSide.none),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Color.fromARGB(255, 100, 100, 100))),
                  labelText: 'Beschreibung',
                  filled: true,
                ),
              ),
            ),
            // Widget für die Auswahl eines Icons
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: IconSelectionWidget(
                onIconSelected: (selectedIcon) {
                  print('Ausgewähltes Icon: $selectedIcon');
                },
              ),
            ),
            // Fehlermeldung anzeigen, wenn erforderlich
            showError
                ? Center(
                    child: Text(
                      'Bitte alle Felder ausfüllen!',
                      style: TextStyle(color: Colors.red),
                    ),
                  )
                : SizedBox(),
            SizedBox(height: 10),
          ],
        ),
        // Button zum Hinzufügen des Events
        SizedBox(
          width: 120,
          height: 40,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: _primaryColor),
            onPressed: () {
              // Auslesen der Eingabewerte
              String title = _titleController.text;
              List dateNumbers = _dateController.text.split(".");
              String date = _dateController.text;
              String time = _timeController.text;
              String description = _descriptionController.text;

              // Überprüfen, ob alle Felder ausgefüllt sind
              if (title.isEmpty ||
                  date.isEmpty ||
                  time.isEmpty ||
                  description.isEmpty) {
                setState(() {
                  showError = title.isEmpty;
                });
              } else {
                // Aktualisieren der Eventdaten
                updateEventData(
                    dateNumbers, title, date, time, description, "star");
              }
            },
            child: Center(
              child: Text("Hinzufügen", style: TextStyle(color: Colors.white)),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _selectDate(context) async {
    DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2100),
        builder: (context, child) {
          return Theme(
              data: ThemeData().copyWith(
                colorScheme: ColorScheme.dark(
                    primary: Color.fromARGB(255, 56, 118, 43),
                    onPrimary: Colors.white,
                    surface: Color.fromARGB(255, 255, 255, 255),
                    onSurface: const Color.fromARGB(255, 42, 42, 42)),
              ),
              child: child ?? Container());
        });

    if (picked != null) {
      setState(() {
        List dateList =
            picked.toString().split(" ")[0].replaceAll("-", ".").split(".");
        String date = "${dateList[2]}.${dateList[1]}.${dateList[0]}";
        _dateController.text = date.toString();
      });
    }
  }

  Future<void> _selectTime(context) async {
    TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      useRootNavigator: false,
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              // change the border color
              primary: _primaryColor,
              // change the text color
              onSurface: Color.fromARGB(255, 39, 39, 39),
            ),
            // button colors
            buttonTheme: ButtonThemeData(
              colorScheme: ColorScheme.light(
                primary: Color.fromARGB(255, 255, 255, 255),
              ),
            ),
          ),
          child: child ?? Container(),
        );
      },
    );

    if (picked != null) {
      setState(() {
        if (picked.minute < 10 && picked.hour < 10) {
          _timeController.text = "0${picked.hour}:0${picked.minute}";
        } else if (picked.minute < 10) {
          _timeController.text = "${picked.hour}:0${picked.minute}";
        } else if (picked.hour < 10) {
          _timeController.text = "0${picked.hour}:${picked.minute}";
        } else {
          _timeController.text = "${picked.hour}:${picked.minute}";
        }
      });
    }
  }
}
