class Weather {
  final String cityName; // Name of the city
  final double temperature; // Temperature in Celsius
  final String description; // Weather description (e.g., "clear sky")
  final String iconCode; // Weather icon code from OpenWeatherMap API
  final double feelsLike; // Feels like temperature in Celsius
  final int humidity; // Humidity percentage
  final double windSpeed; // Wind speed in meters/second

  Weather({
    required this.cityName,
    required this.temperature,
    required this.description,
    required this.iconCode,
    required this.feelsLike,
    required this.humidity,
    required this.windSpeed,
  });

  // Factory method to create Weather objects from JSON data
  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      cityName: json['name'],
      temperature: json['main']['temp'].toDouble(),
      description: json['weather'][0]['description'],
      iconCode: json['weather'][0]['icon'],
      feelsLike: json['main']['feels_like'].toDouble(),
      humidity: json['main']['humidity'].toInt(),
      windSpeed: json['wind']['speed'].toDouble(),
    );
  }
}
