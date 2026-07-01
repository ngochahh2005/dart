/*
  Enum (Enumaration - Kiểu liệt kê): 1 kiểu dữ liệu đặc biệt dùng để đại diện cho 1 tập hợp các giá trị hằng số cố định
*/

// 1. Cú pháp cơ bản
enum Orientation { north, east, south, west }

void main() {
  Orientation myDirection = Orientation.north;
  print(myDirection);

  // 2. Các thuộc tính và phương thức mặc định
  // + .index: trả về vị trí của giá trị, bắt đầu từ 0.
  print(Orientation.east.index); // = 1
  // + .name: trả về tên của giá trị.
  print(Orientation.south.name); // = south
  // + .values: trả về List chứa toàn bộ các giá trị của Enum
  print(Orientation.values);
}
