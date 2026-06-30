/*
  expr1 ? expr2 : expr3;
  Nếu expr1 đúng, trả về expr2; ngược lại trả về expr3

  expr1 ?? expr2;
  Nếu expr1 không null, trả về giá trị của nó;
  ngược lại trả về giá trị expr2
*/

void main() {
  var kt = (100 % 2 == 0) ? "100 la so chan" : "100 la so le";
  print(kt);

  var x = 100;
  var y = x ?? 50;
  print(y); // y = 100

  int? z;
  y = z ?? 30;
  print(y); // y = 30
}
