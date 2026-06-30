void main() {
  // Vong lap for
  for (var i = 1; i <= 5; i++) {
    print(i);
  }

  // iterable: list, set
  var names = ["A", "B", 'C'];
  for (var name in names) {
    print(name);
  }

  // while
  var i = 1;
  while (i <= 5) {
    print(i);
    i++;
  }

  // do while (thuc hien it nhat 1 lan)
  print("Vong lap do-while");
  var x = 1;
  do {
    print(x);
    x++;
    if (x == 3) break;
  } while (x <= 5);

  // break/continue
}
