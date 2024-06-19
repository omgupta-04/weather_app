import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingIndicator extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SpinKitDoubleBounce( // You can choose a different animation from flutter_spinkit
        color: Colors.blue,
        size: 50.0,
      ),
    );
  }
}
