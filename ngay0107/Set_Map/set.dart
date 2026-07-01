void main() {
  // khai bao
  Set<String> set1 = {'A', 'B', 'C'}; // truc tiep
  var set2 = <int>{1, 2, 3}; // sd var
  Set<String> set3 = Set(); // set rong
  var set4 = Set<int>.from([1, 2, 2, 3]); // tu list (loai bo trung)

  // CAC PHUONG THUC
  // 1. Them phan tu:
  set1.add('D'); // them 1 phan tu
  set1.addAll(['E', 'F']); // them nhieu phan tu

  // 2. Xoa phan tu:
  set1.remove('A'); // xoa 1 phan tu
  set1.removeAll(['B', 'C']); // xoa nhieu phan tu
  set1.clear(); // xoa tat ca

  // 3. Truy cap va kiem tra:
  print(set1.length); // so luong phan tu
  print(set1.isEmpty); // kiem tra rong
  print(set1.contains('A')); // kiem tra ton tai

  // 4. Cac phep toan tap hop:
  var set5 = {1, 2, 3};
  var set6 = {3, 4, 5};

  var union = set5.union(set6); // hop: {1, 2, 3, 4, 5}
  var intersection = set5.intersection(set6); // giao: {3}
  var difference = set5.difference(set6); // hieu: {1, 2}

  // 5. Bien doi:
  var list = set1.toList(); // chuyen thanh list
  var newSet = Set.from(set1); // tao list moi

  // 6. Loc va anh xa:
  var filtered = set1.where((e) => e.startsWith('A'));
  var mapped = set1.map((e) => e.toLowerCase());

  // 7. Xu ly tung phan tu:
  set1.forEach((element) {
    print(element);
  });

  // Vi du:
  // Quan ly danh sach ban be
  Set<String> friendIds = {'user1', 'user2', 'user3'};

  // them ban
  friendIds.add('user4');
  friendIds.add('user1');

  // kiem tra ban be
  bool isFriend = friendIds.contains('user1');

  // de xuat ban be
  Set<String> suggestions = {'user5', 'user6', 'user1'};
  var newFriends = suggestions.difference(friendIds); // chi lay nhung nguoi chua ket ban
}
