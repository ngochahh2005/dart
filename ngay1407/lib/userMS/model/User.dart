class User {
  int? id;
  String name;
  String email;
  String phone;
  String? avatar;
  DateTime dateOfBirth;

  User({
    this.id,
    required this.name,
    required this.email,
    required this.phone,
    this.avatar,
    required this.dateOfBirth,
  });

  // chuyen doi tuong User -> Map
  Map<String, dynamic> toMap() =>
      {
        'id': id,
        'name': name,
        'email': email,
        'phone': phone,
        'avatar': avatar,
        'dateOfBirth': dateOfBirth.toIso8601String()
      };

  // Tao doi tuong user tu map
  factory User.fromMap(Map<String, dynamic> map) =>
      User(
          id: map['id'],
          name: map['name'],
          email: map['email'],
          phone: map['phone'],
          avatar: map['avatar'],
          dateOfBirth: DateTime.parse(map['dateOfBirth'] as String)
      );

  // phuong thuc copy de tao ban sao voi 1 so thuoc tinh duoc cap nhat
  User copyWith({
    int? id,
    String? name,
    String? email,
    String? phone,
    String? avatar,
    DateTime? dateOfBirth
  }) => User(
    id: id ?? this.id,
    name: name ?? this.name,
    email: email ?? this.email,
    phone: phone ?? this.phone,
    avatar: avatar ?? this.avatar,
    dateOfBirth: dateOfBirth ?? this.dateOfBirth
  );

  @override
  String toString() {
    return 'User(id: $id, name: $name, email: $email, phone: $phone, avatar: $avatar, dateOfBirth: $dateOfBirth)';
  }


}
