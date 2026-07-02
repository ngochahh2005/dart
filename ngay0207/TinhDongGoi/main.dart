import 'Employee.dart';

void main() {
  Employee employee = Employee(1, 'Nguyen Van A');
  print(employee);
  employee.name = 'Tran Thi B';
  print(employee);
}