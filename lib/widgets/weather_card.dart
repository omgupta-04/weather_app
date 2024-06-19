import 'package:flutter/material.dart';
import '../models/weather.dart';
import 'package:cached_network_image/cached_network_image.dart';

class WeatherCard extends StatelessWidget {
  final Weather weather;

  WeatherCard({required this.weather});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5.0, // Add shadow
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)), // Rounded corners
      margin: const EdgeInsets.all(16.0),
      child: Container( // Add a Container for gradient background
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.blue, Colors.lightBlueAccent],
          ),
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                weather.cityName,
                style: const TextStyle(
                    fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text(
                        '${weather.temperature.toStringAsFixed(1)}°C',
                        style: const TextStyle(fontSize: 64, color: Colors.white),
                      ),
                      Text(
                        weather.description,
                        style: const TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ],
                  ),
                  CachedNetworkImage(
                    imageUrl:
                        'https://openweathermap.org/img/wn/${weather.iconCode}@2x.png',
                    placeholder: (context, url) =>
                        const CircularProgressIndicator(),
                    errorWidget: (context, url, error) => const Icon(Icons.error),
                    height: 80,
                    width: 80,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Divider(color: Colors.white), // Add a divider
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildDetailRow(Icons.thermostat, 'Feels Like',
                      '${weather.feelsLike.toStringAsFixed(1)}°C'),
                  _buildDetailRow(
                      Icons.water_drop, 'Humidity', '${weather.humidity}%'),
                  _buildDetailRow(Icons.air, 'Wind',
                      '${weather.windSpeed.toStringAsFixed(1)} m/s'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper function to build detail rows
  Widget _buildDetailRow(IconData icon, String label, String value) {
    return Column(
      children: [
        Icon(icon, color: Colors.white),
        const SizedBox(height: 5),
        Text(label, style: const TextStyle(color: Colors.white)),
        Text(value, style: const TextStyle(color: Colors.white)),
      ],
    );
  }
}

