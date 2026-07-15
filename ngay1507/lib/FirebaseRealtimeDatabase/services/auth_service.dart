import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class AuthService {
  // _auth: Instance của FirebaseAuth, dùng để quản lý việc đăng nhập/đăng ký người dùng trên server của Firebase.
  final _auth = FirebaseAuth.instance;
  // _databaseRef: Tham chiếu tới gốc (/) của FirebaseRealtimeDatabase, dùng để lưu trữ và đọc dữ liệu người dùng.
  final _databaseRef = FirebaseDatabase.instance.ref();

  // Stream theo doi trang thai dang nhap
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  // lay user hien tai
  User? get currentUser => _auth.currentUser;

  // Dang ky
  Future<User?> register(
    String email,
    String password,
    String displayName,
  ) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = credential.user;
      if (user != null) {
        // Tạo bản ghi mới trong nhánh users với id chính là uid của người đó
        await _databaseRef.child('users/${user.uid}').set({
          'uid': user.uid,
          'email': email,
          'name': displayName,
          'createdAt': ServerValue.timestamp,
        });
        // lưu tên người dùng vào hồ sơ của Firebase Auth để sau này có thể gọi user.displayName
        await user.updateDisplayName(displayName);
        await user.reload();
      }
      return user;
    } on FirebaseAuthException catch (e) {
      print('Loi dang ky: ${e.message}');
      return null;
    }
  }

  // dang nhap
  Future<User?> login(String email, String password) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(email: email, password: password);
      return credential.user;
    } on FirebaseAuthException catch (e) {
      print('Loi dang nhap: ${e.message}');
      return null;
    }
  }

  // dang xuat
  Future<void> logout() async {
    await _auth.signOut();
  }

  // tim uid cua nguoi dung dua tren email
  Future<String?> findUidByEmail(String email) async {
    try {
      // truy van users them email
      final snapshot = await _databaseRef.child('users')
          .orderByChild('email')  // yêu cầu Firebase đánh chỉ mục (index) nhánh users dựa trên trường email của mỗi người dùng
          .equalTo(email) // Lọc kết quả, chỉ lấy những bản ghi nào có trường email đúng bằng giá trị truyền vào
          .once();  // Lấy dữ liệu một lần duy nhất tại thời điểm gọi hàm (thay vì lắng nghe thay đổi liên tục).
      final data = snapshot.snapshot.value as Map?;
      if (data == null || data.isEmpty) return null;
      return data.keys.first as String?;
    } catch (e) {
      print('Loi tim user: $e');
      return null;
    }
  }
}
