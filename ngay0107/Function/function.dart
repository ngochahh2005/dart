/* 
  Dart là 1 ngôn ngữ thuần hướng đối tượng -> Hàm cũng là đối tượng và có kiểu function
  => Hàm có thể gán cho các biến hoặc truyền làm tham số cho các hàm khác
  Có thể gọi 1 thể hiện (instance) của 1 lớp Dart như thể nó là 1 hàm
*/

// Viet day du
double tong(var a, double b, double c) {
  return a + b + c;
}

// Su dung cu phap rut gon "=>"
double tong2(var a, double b, double c) => a + b + c;

/// => expression la cach viet gon cua { return expression; }
/// Luu y: chi co bieu thuc (expression) dung dang sau =>, khong ap dung cho cau lenh (statement)
/// VD: khong the de if statement dang sau => duoc. Tuy nhien co the su dung toan tu 3 ngoi:
/// condition ? expr1 : expr2

/// Ham voi ten cua tham so
/// Khi goi 1 ham (function), co the truyen gia tri thong qua ten bien paramName: value
String createFullName({String ho = "", String chuLot = "", String ten = ""}) =>
    ho + " " + chuLot + " " + ten;

/// Tham sp tuy chon (co hay khong cung duoc)
/// Cho phep goi ham ma khong can cung cap day du tat ca cac tham so.
/// Khi cac tham so tuy chon khong duoc cung cap, chung se nhan gia tri null theo mac dinh
/// De khai bao cac tham so tuy chon -> sd dau ngoac vuong []
double sum(double a, [double? b, double? c, double? d]) {
  var res = a;
  res += b ?? 0;
  res += c ?? 0;
  res += d ?? 0;
  return res;
}

/// Ham an danh
/// Trong Dart, co the tao cac ham khong co ten goi la ham an danh, hay con goi la lambda hoac closure
/// Chung thuong duoc su dung trong cac ngu canh ma ta khong can su dung ten ham
/// VD: khi truyen ham nhu tham so cho ham khac
/// De tao ham an danh: sd cu phap <=> khai bao ham co ten nhung bo qua phan kieu tra ve va ten ham
/// VD: (var a, var b) => a+b

// Ham main(): Khoi dau ung dung
void main() {
  print('Hello world!');
  var x = tong(1, 10.0, 100);
  print(x);
  var y = tong2(1, 10, 100);
  print(y);

  var fn = createFullName(ho: "Nguyen", chuLot: "Van", ten: "A");
  print(fn);

  var fn2 = createFullName(chuLot: "Van", ten: "A");
  print(fn2);

  print(sum(10));
  print(sum(10, 1));
  print(sum(10, 1, 2));
  print(sum(10, 1, 2, 3));

  var ham = (var a, var b) => a + b;
  print(ham(1, 2));
}
