import 'package:flutter/material.dart';

const Color _primaryColor = Color.fromARGB(255, 60, 141, 46);

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "CampusConnect",
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 20),
          CircularProgressIndicator(
            color: _primaryColor,
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            "Kalendar wird aktualisiert...",
            style: TextStyle(
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
