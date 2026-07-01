void main() {
  // CACH KHAI BAO
  // Khai bao truc tiep
  Map<String, dynamic> user1 = {
    // dynamic: kieu du lieu dong
    'name': 'Nam',
    'age': 20,
    'isStudent': true,
  };

  // su dung var
  var user2 = <String, dynamic>{'name': 'Hoa', 'age': 25};

  // khoi tao map rong
  Map<int, String> numbers = {};
  var emptyMap = Map<String, int>();

  // CAC PHUONG THUC
  // 1. Them va cap nhat:
  user1['email'] = 'nam@gmail.com'; // them entry moi
  user1['age'] = 21; // cap nhat value
  user1.putIfAbsent(
    // them neu key chua toi tai trong map
    'phone',
    () => '0123456789',
  );
  user1.addAll({
    // them nhieu entry
    'address': 'Ha Noi',
    'gender': 'male',
  });

  // 2. Xoa:
  user1.remove('age'); // xoa theo key
  user1.removeWhere((key, value) => value == null); // xoa theo dieu kien
  user1.clear(); // xoa tat ca

  // 3. Truy cap:
  print(user1['name']); // lay value theo key
  print(user1.length); // so luong entry
  // lay value an toan voi gia tri mac dinh
  String phone = user1['phone'] ?? 'Khong co so dien thoai';

  // 4. Kiem tra:
  print(user1.isEmpty); // kiem tra rong
  print(user1.isNotEmpty); // kiem tra khong rong
  print(user1.containsKey('name')); // kiem tra ton tai key
  print(user1.containsValue('Nam')); // kiem tra ton tai value

  // 5. Lay danh sach:
  print(user1.keys); // lay tat ca cac key
  print(user1.values); // lay tat ca cac values
  print(user1.entries); // lay tat ca cac entries

  // 6. Duyet Map:
  // Duyet theo key-value:
  user1.forEach((key, value) {
    print('$key: $value');
  });

  // Duyet qua entries
  for (var entry in user1.entries) {
    print('${entry.key}: ${entry.value}');
  }

  // 7. Bien doi:
  // Map key thanh chu hoa:
  var upperMap = user1.map((key, value) => 
    MapEntry(key.toUpperCase(), value)
  );

  // loc map
  var fileredMap = user1.entries
    .where((entry) => entry.value is String)
    .toList();
  
  // VI DU
  // 1. Luu tru thong tin san pham trong gio hang
  Map<String, int> cart = {
    'SP001': 2,     // productId: quantity
    'SP002': 1,
    'SP003': 3
  };

  // them san pham vao gio
  void addToCart(String productId) {
    cart.update(
      productId, 
      (quantity) => quantity + 1,
      ifAbsent: () => 1
    );
  }
}
