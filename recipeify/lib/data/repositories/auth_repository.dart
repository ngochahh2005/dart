import 'package:firebase_auth/firebase_auth.dart';
import 'package:recipeify/core/storage/secure_storage_service.dart';

class AuthRepository {
  AuthRepository._internal();

  static final _instance = AuthRepository._internal();

  factory AuthRepository() => _instance;

  final _auth = FirebaseAuth.instance;
  final _storage = SecureStorageService();

  Stream<User?> get authStateChanges => _auth.authStateChanges();

  User? get currentUser => _auth.currentUser;

  Future<UserCredential> signIn({
    required String email,
    required String password,
  }) async {
    try {
      email = email.trim();
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = userCredential.user;
      if (user != null) {
        await _storage.saveUserInfo(email: user.email ?? '', uid: user.uid);
      }
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw _handleException(e);
    } catch (e) {
      throw Exception('Login failed: $e');
    }
  }

  Future<UserCredential> register({
    required String email,
    required String password,
  }) async {
    try {
      email = email.trim();
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await _sendEmailVerification();
      await _auth.signOut();
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw _handleException(e);
    } catch (e) {
      throw Exception('Register failed: $e');
    }
  }

  Future<void> logout() async {
    try {
      await _storage.clearUserInfo();
      await _auth.signOut();
    } catch (e) {
      throw Exception('Logout failed: $e');
    }
  }

  Future<void> _sendEmailVerification() async {
    final user = _auth.currentUser;
    if (user != null && !user.emailVerified) {
      await user.sendEmailVerification();
    }
  }

  Exception _handleException(FirebaseAuthException e) {
    String errorMessage = '';
    switch (e.code) {
      case 'email-already-exists':
        errorMessage = 'Email đã tồn tại!';
        break;
      case 'invalid-email':
        errorMessage = 'Email không hợp lệ!';
        break;
      case 'user-not-found':
        errorMessage = 'Không tìm thấy tài khoản nào với email này!';
        break;
      case 'wrong-password':
        errorMessage = 'Mật khẩu không chính xác!';
        break;
      case 'invalid-credential':
        errorMessage = 'Email hoặc mật khẩu không chính xác!';
        break;
      case 'user-disabled':
        errorMessage = 'Tài khoản đã bị vô hiệu hóa!';
        break;
      case 'too-many-requests':
        errorMessage = 'Bạn đã nhập sai quá nhiều lần. Vui lòng thử lại sau.';
        break;
      case 'network-request-failed':
        errorMessage = 'Lỗi kết nối mạng. Vui lòng kiểm tra lại 3G/Wifi.';
        break;
      case 'channel-error':
        errorMessage = 'Vui lòng nhập đầy đủ email và mật khẩu.';
        break;
      default:
        errorMessage = 'Đăng nhập thất bại. Mã lỗi: ${e.code}';
    }
    return Exception(errorMessage);
  }
}
