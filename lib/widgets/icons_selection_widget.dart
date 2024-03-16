import 'package:flutter/material.dart';

class IconSelectionWidget extends StatefulWidget {
  final Function(IconData) onIconSelected;

  IconSelectionWidget({required this.onIconSelected});

  @override
  _IconSelectionWidgetState createState() => _IconSelectionWidgetState();
}

class _IconSelectionWidgetState extends State<IconSelectionWidget> {
  final List<IconData> icons = [
    Icons.celebration,
    Icons.fitness_center,
    Icons.groups,
    Icons.school,
    Icons.medical_services,
    Icons.restaurant,
    Icons.star,
  ];

  IconData selectedIcon = Icons.star; // Standardmäßig ausgewähltes Icon

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 24.0),
          child: Container(
              alignment: Alignment.centerLeft,
              child: Text(
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  "Icon")),
        ),
        Container(
          height: 150,
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4, // Anzahl der Spalten
            ),
            itemCount: icons.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  setState(
                    () {
                      selectedIcon = icons[index];
                    },
                  );
                  widget.onIconSelected(selectedIcon);
                },
                child: Container(
                  margin: EdgeInsets.all(15.0),
                  color: selectedIcon == icons[index]
                      ? Color.fromARGB(255, 216, 216, 216)
                      : Colors.transparent,
                  child: Icon(icons[index], size: 20.0),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
