import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

class Voltage {
  static List? data = [];

  static Stream<double> fetchData() =>
      Stream.periodic(const Duration(seconds: 1)).asyncMap((_) => getData());

  static Future<double> getData() async {
    const urlEsp =
        'https://esp-flutter-25f11-default-rtdb.firebaseio.com/ESP32_Device.json';
    final response = await http.get(Uri.parse(urlEsp));
    final body = json.decode(response.body);

    final voltage = double.parse(body['Voltage']['Data'].toString());
    print('Voltage :' + voltage.toString());
   // int x = 0;
    data!.add(voltage);
    //print(data![x]);
    //x++;
    // print(data);
    return voltage;
  }
}
