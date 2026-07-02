// Biến static là biến được chia sẻ chung cho tất cả các đối tượng của một lớp.
//Nó chỉ được khởi tạo một lần duy nhất khi lớp được tải vào bộ nhớ.
//Biến này thường được dùng để lưu trữ dữ liệu cấp lớp (class-level data).
class Employee {
  static int cnt = 0;

  Employee() {
    cnt++;
  }

  void totalEmployee() {
    print('Total Employee: $cnt');
  }
}

void main() {
  Employee e1 = Employee();
  e1.totalEmployee();
  
  Employee e2 = Employee();
  e2.totalEmployee();

  Employee e3 = Employee();
  e3.totalEmployee();
}
