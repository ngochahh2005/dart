class SpaceAge {
  final Map<String, double> Orbital = {
    'Mercury': 0.2408467,
    'Venus': 0.61519726,
    'Earth': 1.0,
    'Mars': 1.8808158,
    'Jupiter': 11.862615,
    'Saturn': 29.447498,
    'Uranus': 84.016846,
    'Neptune': 164.79132,
  };

  SpaceAge();

  double age({required String planet, required int seconds}) => double.parse((seconds / 31557600 / (Orbital[planet] ?? 1.0)).toStringAsFixed(2));
}

//http://exercism.org/tracks/dart/exercises/space-age/edit
