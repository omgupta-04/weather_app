import 'package:flutter/foundation.dart';
import '../models/weather.dart';
import '../services/api_service.dart';

class WeatherProvider extends ChangeNotifier {
  Weather? _weatherData;
  String? _error;
  bool _isLoading = false; // To track loading state

  Weather? get weatherData => _weatherData;
  String? get error => _error;
  bool get isLoading => _isLoading;

  Future<void> fetchWeather(String cityName) async {
    _isLoading = true;
    notifyListeners(); // Notify listeners about the loading state change

    try {
      final data = await ApiService().getWeather(cityName);
      _weatherData = data;
      _error = null;
    } catch (e) {
      _error = e.toString();
      _weatherData = null;
    } finally {
      _isLoading = false;
      notifyListeners(); // Notify listeners when loading is done (with or without error)
    }
  }
}
