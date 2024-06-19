import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/weather.dart';

class ApiService {
  static const String _baseUrl = 'https://api.openweathermap.org/data/2.5/weather';
  final String _apiKey = '4328f61c8bddbcc4474df072ad2f1ea8'; // Replace with your actual API key

  Future<Weather> getWeather(String cityName) async {
    final Uri uri = Uri.parse('$_baseUrl?q=$cityName&appid=$_apiKey&units=metric');

    try {
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        return Weather.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load weather data: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching weather data: $e');
    }
  }
}
