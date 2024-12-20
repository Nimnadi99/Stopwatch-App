class Bicycle {
  int? cadence;
  int? gear;
  int _speed = 0;

  Bicycle(this.cadence, this.gear);

  int get speed => _speed;

  void applyBrake(int decrement) {
    _speed -= decrement;
  }

  void speedUp(int increment) {
    _speed += increment;
  }

  @override
  String toString() => 'Bicycle: $speed mph';
}

void main() {
  var bike = Bicycle(2, 1);
  print(bike);
  print('Bike speed is ${bike.speed}');
  bike.speedUp(20);
  print('Bike speed is ${bike.speed}');
  bike.applyBrake(10);
  print('Bike speed is ${bike.speed}');
}
