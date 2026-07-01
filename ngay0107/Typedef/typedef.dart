/* 
  Typedef: 1 cách ngắn gọn để tạo các alias (bí danh) cho các loại dữ liệu.
  => Mã nguồn trở nên rõ ràng và dễ độc hơn, đặc biệt khi làm việc với các loại dữ liệu phức tạp
   
*/

typedef IntList = List<int>;

typedef ListMapper<X> = Map<X, List<X>>;

void main() {
  IntList l1 = [1, 2, 3, 4, 5];
  print(l1);

  IntList l2 = [1, 2, 3, 4, 5, 6, 7];

  Map<String, List<String>> m1 = {};
  ListMapper<String> m2 = {};       // m1 va m2 la cung kieu
}
