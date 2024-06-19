import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/weather.dart';
import '../weather_provider.dart';
import '../widgets/weather_card.dart';
import '../widgets/loading_indicator.dart';
import '../widgets/error_message.dart';

class WeatherScreen extends StatefulWidget {
  final String defaultCity;
  const WeatherScreen({required this.defaultCity});

  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final _searchController = TextEditingController();
  String _currentCity = '';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<WeatherProvider>(context, listen: false)
          .fetchWeather(widget.defaultCity);
    });
    _currentCity = widget.defaultCity;
  }

  @override
  Widget build(BuildContext context) {
    final weatherProvider = Provider.of<WeatherProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather App'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => weatherProvider.fetchWeather(_currentCity),
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween, // Distribute children evenly
          children: [
            Column(
              children: [
                TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Enter city name',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onSubmitted: (value) => weatherProvider.fetchWeather(value),
                ),
                const SizedBox(height: 20),
                if (weatherProvider.isLoading)  LoadingIndicator(),
                if (weatherProvider.error != null)
                  ErrorMessage(message: weatherProvider.error!),
                if (weatherProvider.weatherData != null && !weatherProvider.isLoading)
                  WeatherCard(weather: weatherProvider.weatherData!),
              ],
            ),

            // Button at the bottom
            Align(
              alignment: Alignment.bottomCenter,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50), // Set the button height
                  backgroundColor: Colors.blueAccent, // Set the button color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10), // Set the button border radius
                  ),
                ),
                onPressed: () {
                  if (weatherProvider.weatherData != null) {
                    Navigator.pushNamed(
                      context,
                      '/detail',
                      arguments: weatherProvider.weatherData,
                    );
                  }
                },
                child: const Text(
                  'View Details',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
