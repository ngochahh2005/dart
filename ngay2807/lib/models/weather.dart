import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'weather.freezed.dart';

@freezed
abstract class Weather with _$Weather {
  const Weather._();

  const factory Weather({
    required String cityName,
    required double temperature,
    required int humidity,
    required String time,
    required String condition,
    required IconData icon,
    required Color color,
  }) = _Weather;

  factory Weather.fromJson(Map<String, dynamic> json, String cityName) {
    final current = json['current'] as Map<String, dynamic>;
    final tmp = (current['temperature_2m'] as num).toDouble();
    final humidity = (current['relative_humidity_2m'] as num).toInt();
    final time = current['time'] as String;
    String condition;
    IconData icon;
    Color color;

    if (tmp >= 35) {
      condition = 'Nóng bức';
      icon = Icons.wb_sunny;
      color = Colors.orange;
    } else if (tmp >= 28) {
      condition = 'Ấm';
      icon = Icons.wb_sunny_outlined;
      color = Colors.amberAccent;
    } else if (tmp >= 22) {
      condition = 'Trời mát mẻ';
      icon = Icons.cloud_queue;
      color = Colors.blueAccent;
    } else if (tmp >= 20) {
      condition = 'Trời lạnh';
      icon = Icons.ac_unit;
      color = Colors.cyan;
    } else if (tmp >= 15) {
      condition = 'Trời rét';
      icon = Icons.thermostat;
      color = Colors.indigo;
    } else if (tmp >= 13) {
      condition = 'Rét đậm';
      icon = Icons.severe_cold;
      color = Colors.blue;
    } else {
      condition = 'Rét hại';
      icon = Icons.cloudy_snowing;
      color = Colors.deepPurple;
    }

    return Weather(
      cityName: cityName,
      temperature: tmp,
      humidity: humidity,
      time: time,
      condition: condition,
      icon: icon,
      color: color
    );
  }
}
