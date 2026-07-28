import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../models/weather.dart';

class WeatherScreen extends StatelessWidget {
  final Weather weather;

  const WeatherScreen(this.weather, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Thời tiết của ${weather.cityName}'),
        backgroundColor: Colors.lightBlueAccent[100],
        actions: [
          IconButton(
            onPressed: () => context.pop(),
            icon: Icon(Icons.arrow_back_ios_new),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 16,
          children: [
            Icon(weather.icon, color: weather.color, size: 40),
            Text(
              '${weather.temperature.toStringAsFixed(1)}°C',
              style: TextStyle(fontSize: 48),
            ),

            Text('Độ ẩm: ${weather.humidity}%'),

            if (weather.condition.isNotEmpty)
              Text('Tình trạng: ${weather.condition}'),

            Text('Cập nhật lúc: ${weather.time}'),
          ],
        ),
      ),
    );
  }
}
