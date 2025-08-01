import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Navigator Style App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MapNavigationPage(),
    );
  }
}

class MapNavigationPage extends StatefulWidget {
  const MapNavigationPage({super.key});

  @override
  State<MapNavigationPage> createState() => _MapNavigationPageState();
}

class _MapNavigationPageState extends State<MapNavigationPage> {
  late YandexMapController _controller;

  @override
  void initState() {
    super.initState();
    _requestPermissions();
  }

  Future<void> _requestPermissions() async {
    await Permission.location.request();
  }

  void _onMapCreated(YandexMapController controller) {
    _controller = controller;
    /*_controller.move(
      point: const Point(latitude: 55.751244, longitude: 37.618423), // Москва
      animation: const MapAnimation(type: MapAnimationType.smooth, duration: 2),
    );*/
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          YandexMap(
            onMapCreated: _onMapCreated,
          ),
          Positioned(
            top: 50,
            right: 20,
            child: GestureDetector(
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Профиль нажат')),
                );
              },
              child: CircleAvatar(
                radius: 26,
                backgroundColor: Colors.white,
                child: Icon(Icons.person, size: 28, color: Colors.black),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
