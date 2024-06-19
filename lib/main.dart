import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/profile_screen.dart';
import 'screens/weather_screen.dart';
import 'screens/detail_screen.dart';
import 'models/user.dart';
import 'models/weather.dart';
import 'weather_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? userDataString = prefs.getString('user');
  User? user;
  if (userDataString != null) {
    Map<String, dynamic> userDataMap = jsonDecode(userDataString);
    user = User.fromMap(userDataMap);
  }

  runApp(
    ChangeNotifierProvider(
      create: (context) => WeatherProvider(),
      child: MyApp(user: user),
    ),
  );
}

class MyApp extends StatelessWidget {
  final User? user;
  const MyApp({super.key, this.user});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: user != null ? '/weather' : '/',
      routes: {
        '/': (context) => ProfileScreen(),
        '/weather': (context) => user != null
            ? WeatherScreen(defaultCity: user!.location)
            : ProfileScreen(),
        '/detail': (context) => DetailScreen(
              weather: ModalRoute.of(context)!.settings.arguments as Weather),
      },
      builder: (context, child) {
        return Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF00BFFF), // Deep Sky Blue
                Color(0xFF87CEEB), // Sky Blue
              ],
            ),
          ),
          child: child,
        );
      },
    );
  }
}
