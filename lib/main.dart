import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  static const platform = MethodChannel('battery');

  String batteryLevel = 'Unknown battery level';

  Future<void> getBatteryLevel() async {
    String battery;

    try {
      final int result = await platform.invokeMethod('getBatteryLevel');

      battery = 'Battery level: $result%';
    } on PlatformException catch (e) {
      battery = "Failed to get battery level: '${e.message}'";
    }

    setState(() {
      batteryLevel = battery;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Battery Level')),

        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,

            children: [
              Text(batteryLevel),

              SizedBox(height: 20),

              ElevatedButton(
                onPressed: getBatteryLevel,
                child: Text('Get Battery Level'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
