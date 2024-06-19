import 'package:flutter/material.dart';
import '../models/weather.dart';
import 'package:cached_network_image/cached_network_image.dart'; // For weather icon

class DetailScreen extends StatelessWidget {
  final Weather weather;

  DetailScreen({required this.weather});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(weather.cityName),
        flexibleSpace: Container( // Add gradient to AppBar
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF00BFFF), Color(0xFF87CEEB)],
            ),
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration( // Add gradient to the body
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF00BFFF), Color(0xFF87CEEB)],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Weather Icon
              CachedNetworkImage(
                imageUrl:
                    'https://openweathermap.org/img/wn/${weather.iconCode}@4x.png', // Larger icon size
                placeholder: (context, url) => const CircularProgressIndicator(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
                height: 120,
                width: 120,
              ),
              const SizedBox(height: 20),

              // Temperature
              Text(
                '${weather.temperature.toStringAsFixed(1)}°C',
                style: const TextStyle(
                  fontSize: 64,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                weather.description,
                style: const TextStyle(fontSize: 24, color: Colors.white),
              ),
              const SizedBox(height: 40),

              // Additional Details
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Wrap(
                  spacing: 20, // Horizontal spacing
                  runSpacing: 10, // Vertical spacing
                  children: [
                    _buildDetailBox(
                      icon: Icons.thermostat,
                      label: 'Feels Like',
                      value: '${weather.feelsLike.toStringAsFixed(1)}°C',
                    ),
                    _buildDetailBox(
                      icon: Icons.water_drop,
                      label: 'Humidity',
                      value: '${weather.humidity}%',
                    ),
                    _buildDetailBox(
                      icon: Icons.air,
                      label: 'Wind',
                      value: '${weather.windSpeed.toStringAsFixed(1)} m/s',
                    ),
                    // ... add more details as needed
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper function to build detail boxes
  Widget _buildDetailBox({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2), // Semi-transparent white background
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Icon(icon, size: 36, color: Colors.white),
          const SizedBox(height: 8),
          Text(label, style: const TextStyle(color: Colors.white)),
          Text(value, style: const TextStyle(fontSize: 18, color: Colors.white)),
        ],
      ),
    );
  }
}

