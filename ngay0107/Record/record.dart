/* 
  Records: 1 kiểu dữ liệu tổng hợp được giới thiệu trong Dart 3.0
  Cho phép nhóm nhiều giá trị có kiểu khác nhau thành 1 đơn vị
  Records là immutable - không thể thay đổi sau khi được tạo
*/

void main() {
  var r = ('first', a: 2, 5, 10.5); // khai bao 1 record
  // Dinh nghia record co 2 gia tri
  var point = (123, 456);

  // Dinh nghia person
  var person = (name: 'Alice', age: 25, 5);

  // Truy cap gia tri trong record
  // Dung chi so
  print(point.$1);
  print(point.$2);
  print(person.$1);

  // Dung ten
  print(person.name);
  print(person.age);
}
