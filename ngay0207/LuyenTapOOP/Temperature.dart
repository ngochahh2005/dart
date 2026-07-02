class Temperature {
  double _celsius;

  Temperature(this._celsius);

  double get celsius => _celsius;
  set celsius(double celsius) {
    if (celsius < -273.15)
      throw Exception('Nhiệt độ không được thấp hơn độ 0 tuyệt đối');
    _celsius = celsius;
  }

  double get fahrenheit => (_celsius * 9 / 5) + 32;
  set fahrenheit(double fahrenheit) {
    double celsius = (fahrenheit - 32) * 5 / 9;
    if (celsius < -273.15)
      throw Exception('Nhiệt độ không được thấp hơn độ 0 tuyệt đối');
    _celsius = celsius;
  }

  @override
  String toString() =>
      _celsius.toStringAsFixed(2) + ' ' + fahrenheit.toStringAsFixed(2);
}

void main() {
  Temperature temperature = Temperature(37);
  print(temperature);
  temperature.celsius = -280;
}
