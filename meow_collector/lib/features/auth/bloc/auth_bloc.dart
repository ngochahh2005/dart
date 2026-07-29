import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meow_collector/services/auth/auth_service.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final _authService = AuthService();

  AuthBloc() : super(AuthInitial()) {
    on<AuthSubscriptionStarted>((event, emit) {
      _authService.authStateChanges.listen((User? user) {
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
        final user = _authService.currentUser;
        if (user != null) {
          emit(AuthAuthenticated(user));
        } else {
          final uid = await _authService.getStoredUid();
          if (uid != null) {
            emit(AuthLoading());
          } else {
            emit(AuthUnauthenticated());
          }
        }
      } catch (e) {
        emit(AuthError(e.toString()));
      }
    });
    on<AuthRegister>((event, emit) async {
      emit(AuthLoading());
      try {
        final userCredential = await _authService.register(
          email: event.email,
          password: event.password,
        );
        emit(AuthAuthenticated(userCredential.user!));
      } catch (e) {
        emit(AuthError(e.toString()));
      }
    });
    on<AuthLogin>((event, emit) async {
      emit(AuthLoading());
      try {
        final userCredential = await _authService.login(
          email: event.email,
          password: event.password,
        );
        emit(AuthAuthenticated(userCredential.user!));
      } catch (e) {
        emit(AuthError(e.toString()));
      }
    });
    on<AuthLogout>((event, emit) async {
      emit(AuthLoading());
      try {
        await _authService.logout();
        emit(AuthUnauthenticated());
      } catch (e) {
        emit(AuthError(e.toString()));
      }
    });
  }
}
