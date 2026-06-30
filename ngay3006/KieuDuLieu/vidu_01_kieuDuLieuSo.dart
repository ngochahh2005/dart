void main() {
  // int: kieu so nguyen
  int x = 100;

  // double: kieu so thuc
  double y = 100.5;

  // num: co the chua so nguyen/so thuc
  num z = 10;
  num t = 10.75;

  // chuyen chuoi sang so nguyen
  var one = int.parse('1');
  print(one == 1 ? 'True' : 'False');

  // chuyen chuoi sang so thuc
  var onePointOne = double.parse('1.1');
  print(onePointOne == 1.1);

  // So nguyen -> chuoi
  String oneAsString = 1.toString();
  print(oneAsString);

  // So thuc -> chuoi va lam tron
  String piAsString = 3.14159.toStringAsFixed(2);
  print(piAsString);
}
