import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meow_collector/services/storage/secure_storage_service.dart';

class AuthService {
  AuthService._internal();

  static final _instance = AuthService._internal();

  factory AuthService() => _instance;

  final _auth = FirebaseAuth.instance;
  final _storage = SecureStorageService();

  Stream<User?> get authStateChanges => _auth.authStateChanges();

  User? get currentUser => _auth.currentUser;

  bool get isSignedIn => _auth.currentUser != null;

  Future<String?> getStoredUid() async {
    return await _storage.getUserId();
  }

  Future<String?> getStoredEmail() async {
    return await _storage.getUserEmail();
  }

  Future<UserCredential> register({
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );

      await sendEmailVerification();
      await _auth.signOut();

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception('Register error: ${e.message}');
    } catch (e) {
      throw Exception('Register failed: $e');
    }
  }

  Future<UserCredential> login({
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );

      await _saveUserInfo(userCredential.user);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception('Login error: ${e.message}');
    } catch (e) {
      throw Exception('Login failed: $e');
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

  Future<void> sendEmailVerification() async {
    final user = _auth.currentUser;
    if (user != null && !user.emailVerified) {
      await user.sendEmailVerification();
    }
  }

  Future<void> sendResetPasswordEmail(String email) async {
    await _auth.sendPasswordResetEmail(email: email.trim());
  }

  Future<void> _saveUserInfo(User? user) async {
    if (user != null) {
      await _storage.saveUserInfo(email: user.email ?? '', userId: user.uid);
    }
  }
}
