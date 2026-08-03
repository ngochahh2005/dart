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
      throw Exception('Login error: ${e.message}');
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
      throw Exception('Register error: ${e.message}');
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
}
