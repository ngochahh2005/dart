class Position {
  int x, y;
  Position(this.x, this.y);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Position && x == other.x && y == other.y;
}

enum Orientation { north, east, south, west }

class Robot {
  Position position;
  Orientation orientation;

  Robot(this.position, this.orientation);

  void move(String s) {
    for (var c in s.split('')) {
      if (c == 'R')
        this.orientation = Orientation.values[(this.orientation.index + 1) % 4];
      else if (c == 'L')
        this.orientation = Orientation.values[(this.orientation.index + 3) % 4];
      else {
        switch (this.orientation) {
          case Orientation.north:
            this.position.y++;
            break;
          case Orientation.east:
            this.position.x++;
            break;
          case Orientation.south:
            this.position.y--;
            break;
          default:
            this.position.x--;
            break;
        }
      }
    }
  }
}

// https://exercism.org/tracks/dart/exercises/robot-simulator/iterations?idx=1 