import 'dart:convert';

import 'package:http/http.dart' as http;


class Power {
  static Stream<double> fetchData() =>
      Stream.periodic(const Duration(seconds: 1)).asyncMap((_) => getData());

  static Future<double> getData() async {
    const urlEsp =
        'https://esp-flutter-25f11-default-rtdb.firebaseio.com/ESP32_Device.json';
    final response = await http.get(Uri.parse(urlEsp));
    final body = json.decode(response.body);

    final power = double.parse(body['power']['Data'].toString());
    print('Power :' + power.toString());

    return power;
  }
}
