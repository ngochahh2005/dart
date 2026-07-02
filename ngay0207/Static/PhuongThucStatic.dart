//Phương thức static cũng được chia sẻ bởi tất cả các đối tượng của lớp.
//Điểm đặc biệt là bạn có thể gọi phương thức static mà không cần tạo đối tượng của lớp đó.
class SimpleInterest {
  static double caculateInterest(double principal, double rate, double time) =>
      (principal * rate * time) / 100;
}

void main() {
  print(
    'The simple interest is ${SimpleInterest.caculateInterest(1000, 2, 2)}',
  );
}
