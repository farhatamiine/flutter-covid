import 'dart:convert';

import 'package:covid_morocco/models/Covid.dart';
import 'package:http/http.dart' as http;

String url = "https://corona.lmao.ninja/countries";

Future<List<Covid>> getAllInfo() async {
  try {
    print("Getting the data :");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      print(jsonData);
      return new List<Covid>.from(jsonData.map((x) => Covid.fromJson(x)));
    }
  } catch (ex) {
    print(ex);
  } finally {
    print("Done");
  }
}
