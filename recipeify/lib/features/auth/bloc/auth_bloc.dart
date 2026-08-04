import 'package:firebase_auth/firebase_auth.dart';
import 'package:recipeify/core/storage/secure_storage_service.dart';
import 'package:recipeify/data/repositories/auth_repository.dart';

import 'auth_event.dart';
import 'auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;
  final SecureStorageService _storageService;

  AuthBloc(this._authRepository, this._storageService) : super(AuthInitial()) {
    on<AuthSubscriptionStarted>((event, emit) {
      _authRepository.authStateChanges.listen((User? user) {
        if (user != null) {
          add(AuthCheckStatus());
        } else {
          emit(AuthUnauthenticated());
        }
      });
    });

    on<AuthCheckStatus>((event, emit) async {
      emit(AuthLoading());
      try {
        final user = _authRepository.currentUser;
        if (user != null) {
          if (user.emailVerified) {
            final pin = await _storageService.getPin();
            if (pin != null && pin.isNotEmpty) {
              emit(AuthRequiresPin(user));
            } else {
              emit(AuthAuthenticated(user));
            }
          } else {
            await _authRepository.logout();
            emit(AuthUnauthenticated());
          }
        } else {
          emit(AuthUnauthenticated());
        }
      } catch (e) {
        emit(AuthError(e.toString()));
      }
    });

    on<AuthRegister>((event, emit) async {
      emit(AuthLoading());
      try {
        await _authRepository.register(
          email: event.email,
          password: event.password,
        );

        emit(AuthRegisterSuccess());
      } catch (e) {
        emit(AuthError(e.toString()));
      }
    });

    on<AuthLogin>((event, emit) async {
      emit(AuthLoading());
      try {
        final userCredential = await _authRepository.signIn(
          email: event.email,
          password: event.password,
        );
        final user = userCredential.user;
        if (user != null && user.emailVerified) {
          final pin = await _storageService.getPin();
          if (pin != null && pin.isNotEmpty) {
            emit(AuthRequiresPin(user));
          } else {
            emit(AuthAuthenticated(user));
          }
        } else {
          await _authRepository.logout();
          emit(AuthError('Vui lòng xác thực email để đăng nhập!'));
        }
      } catch (e) {
        emit(AuthError(e.toString()));
      }
    });

    on<AuthLogout>((event, emit) async {
      emit(AuthLoading());
      try {
        await _authRepository.logout();
        emit(AuthUnauthenticated());
      } catch (e) {
        emit(AuthError(e.toString()));
      }
    });
  }
}
