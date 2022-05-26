import 'dart:convert';

import 'package:http/http.dart' as http;

class Num1 {
  static Stream<double> fetchData() =>
      Stream.periodic(const Duration(seconds: 1)).asyncMap((_) => getData());

  static Future<double> getData() async {
    const urlEsp =
        'https://esp-flutter-25f11-default-rtdb.firebaseio.com/ESP32_Device.json';
    final response = await http.get(Uri.parse(urlEsp));
    final body = json.decode(response.body);

    final num1 = double.parse(body['NUM1']['Data'].toString());
    print(num1);
    return num1;
  }
}
// final num2 = double.parse(body['NUM2']['Data'].toString());
//
// final v = double.parse(body['Voltage']['Data'].toString());
//
// final c = double.parse(body['current']['Data'].toString());
//
// final p = double.parse(body['power']['Data'].toString());
