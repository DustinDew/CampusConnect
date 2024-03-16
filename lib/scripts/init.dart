import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class Init {
  static Future initialize() async {
    await _registerServices();
    await _loadSettings();
  }

  static _registerServices() async {
    print("starting registering services...");
    await Future.delayed(Duration(seconds: 1));
    print("finished registering services");
  }

  static _loadSettings() async {
    print("starting loading settings...");
    await Future.delayed(Duration(seconds: 1));
    print("finished loading settings");
  }

  static Future<Map<String, dynamic>> readJson() async {
    print("loading events...");
    final String response = await rootBundle.loadString('lib/assets/data.json');
    final data = await json.decode(response);
    print("finished loading events");
    return data;
  }
}
