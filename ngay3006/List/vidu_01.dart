void main() {
  // List: bat dau tu chi so 0, kich thuoc co the thay doi duoc, ptu co the lap lai
  List<String> list1 = ['A', 'B', 'C']; // truc tiep
  var list2 = [1, 2, 3];
  List<String> list3 = []; // list rong
  var list4 = List<int>.filled(3, 0); // tao 1 list co 3 phan tu toan bo la 0
  print(list4);

  // 1. Them phan tu
  list1.add('D'); // them 1 phan tu
  list1.addAll(['A', 'C']);
  list1.insert(0, 'Z'); // chen vao vi tri 0 phan tu 'Z'
  list1.insertAll(1, ['1', '0']); // chen nhieu phan tu
  print(list1);

  // 2. Xoa phan tu ben trong list
  list1.remove('A'); // xoa 1 phan tu co gia tri 'A' o vi tri dau tien xuat hien
  list1.remove(0); // xoa 1 phan tu tai vi tri 0
  list1.removeLast(); // xoa ptu tai vi tri cuoi
  list1.removeWhere((e) => e == 'B'); // xoa theo dieu kien
  list1.clear(); // xoa het list
  print(list1);

  // 3. Truy cap phan tu
  print(list2[0]); // lay phan tu tai vi tri 0
  print(list2.first); // lay phan tu dau tien
  print(list2.last); // lay phan tu cuoi cung
  print(list2.length); // lay do dai cua list

  // 4. Kiem tra
  print(list2.isEmpty); // kiem tra rong
  print('List 3: ${list3.isNotEmpty ? 'Khong rong' : 'Rong'}');
  print(list4.contains(1)); // kiem tra list4 co chua 1 khong
  print(list4.contains(0));
  print(list4.indexOf(0)); // vt dau tien xuat hien cua 0
  print(list4.lastIndexOf(0)); // vt cuoi cung xuat hien cua 0

  // 5. Bien doi
  list4 = [2, 1, 3, 9, 0, 10];
  print(4);
  print(list4);
  list4.sort(); // sap xep tang dan
  print(list4);
  list4.reversed; // dao nguoc list, tu dong chuyen thanh 1 iterable
  list4 = list4.reversed.toList();
  print(list4);

  // 6. Cat va noi
  var subList = list4.sublist(1, 3); // cat 1 sublist [1, 3)
  print(subList);
  var str_joined = list4.join(","); // noi het cac phan tu trong list
  print(str_joined);

  // duyet cac phan tu ben trong list
  list4.forEach((element) {
    print(element);
  });
}
