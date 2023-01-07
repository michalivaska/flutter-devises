import 'dart:convert';

import 'package:http/http.dart' as http;

class Service {
  static const endpoint = 'https://api.frankfurter.app';

  static Future<List<Currency>> getCurrencies() async {
    var responseNames = await http.get(Uri.parse('$endpoint/currencies'));
    final names = jsonDecode(responseNames.body);
    final response = await http.get(Uri.parse('$endpoint/latest'));
    final json = jsonDecode(response.body);
    final rates = json['rates'];
    if (rates is Map<String, dynamic>) {
      return [
        for (var item in rates.entries)
          Currency(item.key, names[item.key], double.parse('${item.value}')),
      ];
    }
    return [];
  }
}

class Currency {
  final String code;
  final String name;
  final double value;

  Currency(this.code, this.name, this.value);
}
